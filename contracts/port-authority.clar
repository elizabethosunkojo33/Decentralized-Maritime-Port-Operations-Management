;; Port Authority Verification Contract
;; Manages verification and registration of port authorities

(define-map port-authorities principal bool)
(define-map authority-details principal {name: (string-ascii 50), location: (string-ascii 100), established: uint})

(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-already-registered (err u101))
(define-constant err-not-found (err u102))

;; Register a new port authority
(define-public (register-port-authority (authority principal) (name (string-ascii 50)) (location (string-ascii 100)))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-not-authorized)
    (asserts! (is-none (map-get? port-authorities authority)) err-already-registered)
    (map-set port-authorities authority true)
    (map-set authority-details authority {
      name: name,
      location: location,
      established: block-height
    })
    (ok true)
  )
)

;; Verify if a principal is a registered port authority
(define-read-only (is-port-authority (authority principal))
  (default-to false (map-get? port-authorities authority))
)

;; Get port authority details
(define-read-only (get-authority-details (authority principal))
  (map-get? authority-details authority)
)

;; Revoke port authority status
(define-public (revoke-authority (authority principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-not-authorized)
    (asserts! (is-port-authority authority) err-not-found)
    (map-delete port-authorities authority)
    (map-delete authority-details authority)
    (ok true)
  )
)
