<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth2 Client — agent index

**Configurable OAuth2 client apps** to call external OAuth2-protected APIs (client_credentials grant;
authorization_code not yet enabled). Depends on core `options`, `user`, `views`, `simple_oauth`. Provides
permissions. Version **1.0.0-alpha3**. Core `^10.4||^11`.

Authentication/integration — stores **client credentials + tokens** (client secret as a secret — env/Key; protect
tokens; HTTPS). No end-user login-CSRF surface (authorization_code disabled). Own permissions.
