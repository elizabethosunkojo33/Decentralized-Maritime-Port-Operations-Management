;; Customs Coordination Contract
;; Coordinates customs processes

(define-map customs-clearances uint {
  cargo-operation-id: uint,
  customs-officer: principal,
  status: (string-ascii 20),
  clearance-time: (optional uint),
  notes: (string-ascii 200)
})

(define-data-var clearance-nonce uint u0)

(define-constant err-not-authorized (err u400))
(define-constant err-clearance-not-found (err u401))
(define-constant err-already-cleared (err u402))

;; Initiate customs clearance
(define-public (initiate-clearance (cargo-operation-id uint) (notes (string-ascii 200)))
  (let ((clearance-id (+ (var-get clearance-nonce) u1)))
    (begin
      (map-set customs-clearances clearance-id {
        cargo-operation-id: cargo-operation-id,
        customs-officer: tx-sender,
        status: "pending",
        clearance-time: none,
        notes: notes
      })
      (var-set clearance-nonce clearance-id)
      (ok clearance-id)
    )
  )
)

;; Approve customs clearance
(define-public (approve-clearance (clearance-id uint))
  (let ((clearance (unwrap! (map-get? customs-clearances clearance-id) err-clearance-not-found)))
    (begin
      (asserts! (is-eq tx-sender (get customs-officer clearance)) err-not-authorized)
      (asserts! (is-eq (get status clearance) "pending") err-already-cleared)
      (map-set customs-clearances clearance-id (merge clearance {
        status: "approved",
        clearance-time: (some block-height)
      }))
      (ok true)
    )
  )
)

;; Reject customs clearance
(define-public (reject-clearance (clearance-id uint) (reason (string-ascii 200)))
  (let ((clearance (unwrap! (map-get? customs-clearances clearance-id) err-clearance-not-found)))
    (begin
      (asserts! (is-eq tx-sender (get customs-officer clearance)) err-not-authorized)
      (asserts! (is-eq (get status clearance) "pending") err-already-cleared)
      (map-set customs-clearances clearance-id (merge clearance {
        status: "rejected",
        clearance-time: (some block-height),
        notes: reason
      }))
      (ok true)
    )
  )
)

;; Get clearance details
(define-read-only (get-clearance (clearance-id uint))
  (map-get? customs-clearances clearance-id)
)

;; Get clearance nonce
(define-read-only (get-clearance-nonce)
  (var-get clearance-nonce)
)
