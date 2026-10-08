<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Amazon — agent index

Adds **Login with Amazon (OAuth 2.0)** to the **Social Auth** framework. Depends on `social_auth`. Version
**4.1.0**. Core `^9.5||^10||^11`.

Auth — **delegates correctly**: no callback controller of its own (own routes commented out); the OAuth flow
incl. **`state` (CSRF) validation** is handled by the **Social Auth base** controller (inherits the framework's
CSRF-protected flow). Store the Amazon **client secret** as a secret; HTTPS; review auto-registration. No
access role beyond `administer social api authentication`.
