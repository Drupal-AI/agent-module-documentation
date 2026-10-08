<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT Authentication — agent index

**Stateless JWT-based authentication** (access/refresh token lifecycle, JTI revocation, flood protection). Stores
signing keys via **`key`**. Provides permissions. Version **1.0.2**. Core `>=10`.

Authentication — well-built (Key module, JTI revocation, flood). Keep the **signing key strong + secret** (a leak
forges tokens for any user); prefer **RS256**/strong HMAC, short access-token lifetimes, HTTPS. Own permissions.
