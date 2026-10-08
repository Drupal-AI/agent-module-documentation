<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signature Field (signaturefield) — agent index

Signature **form element + field type** (draw on canvas, mouse/touch), stored as field data or a
generated **PNG**. Version **1.2.0**. Core `^10.3 || ^11`.

**Security posture (positive):** pure field-type/element machinery — **no routes, no controllers, no
AJAX save endpoints.** Signatures are written only through the normal entity form/field save path,
so standard **field/entity access control** applies. No unauthenticated write surface (contrast
`sign_widget`, which had one). Classes: `Element/Signature`, `PngConverter`, `SignatureItem`,
`SignatureFileItem`, widgets, formatter.

**Caveat:** a canvas signature is evidence of intent, not a cryptographic signature — protect the
entities holding them; don't rely on it as a legal/crypto guarantee.