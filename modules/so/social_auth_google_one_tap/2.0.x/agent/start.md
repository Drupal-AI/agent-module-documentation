<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Google One Tap — agent index

Adds **Google One Tap login** to the Social Auth framework (frictionless Google sign-in → ID token → login).
Depends on `social_auth_google`. Version **2.0.0**. Core `^10.5||^11`.

Auth — **implemented correctly** (reviewed): `OneTapController` **verifies the Google ID token server-side** via
the official Google client (`verifyIdToken()` → signature/audience/issuer/expiry), logging in only on a **valid**
payload (maps the verified `sub`). Forged tokens rejected — doesn't trust a client token. Store the Google
client ID appropriately; HTTPS.
