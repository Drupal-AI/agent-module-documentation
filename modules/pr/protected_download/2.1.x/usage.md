<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protected Download provides HMAC protected file downloads.

---

Protected Download provides **HMAC-protected, time-limited file download links** — generating signed URLs
(carrying the file URI, an expiry, and an HMAC) so a file can be downloaded via a link without exposing a
permanent public path. It is in the Media package.

Use it to hand out secure, expiring download links. It is an access/file-delivery feature and it is implemented
**correctly**: the download route is public (`_access: 'TRUE'`) but the controller **verifies the signature
before serving** — `SecurityKey::verify($uri, $expire, $hmac)` recomputes the HMAC and compares it with
**`hash_equals()`** (constant-time) and checks the **expiry**, so tampering with the URI or expiry, or using an
expired/forged link, is rejected. Understand the model: the signed URL is a **capability** — anyone who has a
valid (unexpired) link can download, so deliver links over secure channels and keep expiry windows short; and
the security rests on the HMAC key staying secret. It has no per-user access-control role. Generate and issue
protected links.

---

- Provide HMAC-signed download links.
- Make links time-limited (expiry).
- Hide permanent public paths.
- Verify the signature before serving.
- Use hash_equals (constant-time) + expiry check.
- Reject tampered/expired/forged links.
- TREAT a valid link as a capability (URL = access).
- Deliver links over secure channels.
- Keep expiry windows short.
- Keep the HMAC key secret.
- Have no per-user access-control role.
- Generate and issue links.
- Handle protected downloads.
- Sign downloads.
- Configure the links.
- Verify downloads.
- Handle the delivery.
- Issue signed links.
- Secure the key.
- Provide protected downloads.
