<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# d ACCOUNT OpenID Connect Client — agent index

**OpenID Connect client for 'd ACCOUNT connect' sign-on**. Depends on `openid_connect`. Version **1.1.0**. Core
`^9.5||^10||^11`.

Authentication — built **on openid_connect**, which handles the OAuth **`state`/CSRF, token exchange and user
mapping** (login-CSRF defense — keep it updated). Supplies the d ACCOUNT endpoints/claims. Store the **client
ID/secret as secrets** (env/Key), HTTPS.
