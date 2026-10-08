<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Register User with Email Verification — agent index

REST **register-then-verify** flow: POST to create a user (**created blocked**), a random token is
emailed, POST username+token to activate. Resend endpoint too. Depends on core `rest`. Version
**8.x-1.13**. Core `^8||^9||^10||^11`.

**Reviewed sound:** account `block()`ed on creation; registration accepts only `field_*` (no roles/
status/pass injection); token via `Crypt::randomBytesBase64()` (strong, strict compare). CSRF removed
is expected for anonymous endpoints. Serve over HTTPS; the emailed token is a bearer credential.
