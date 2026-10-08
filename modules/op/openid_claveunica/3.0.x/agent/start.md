<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenID ClaveUnica — agent index

**ClaveÚnica (Chile national identity) via OpenID Connect**. Version **3.0.0-alpha2**. Core `^9.5||^10.2||^11`.

Complete-account route custom-access-gated + per-user hash validated before `user_login_finalize()`; OAuth flow handled by openid_connect base. Credentials env-backed. Depends on `openid_connect`.