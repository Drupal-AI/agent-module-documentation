<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magic Login Link — agent index

**Secure passwordless login via time-sensitive magic links**. Depends on core `user`. Version **1.0.1**. Core
`^10.2||^11`.

Authentication — **positive/well-built**: token is core's **`user_pass_rehash()`** (unguessable HMAC, not a
brute-forceable code), **single-use**, **15-min expiry**, `hash_equals`, **flood control** (50/hr IP, 5/hr user).
`_access: TRUE` is correct (the token is the credential). Inherent caveat: security = **email + link delivery**
(TLS mail, short expiry).
