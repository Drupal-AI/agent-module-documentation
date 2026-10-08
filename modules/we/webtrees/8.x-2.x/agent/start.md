<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webtrees — agent index

Provides **single sign-on (SSO) between Drupal and Webtrees** (genealogy software; `webtrees_admin_views`/
`webtrees_views` submodules). Depends on core `system`, `user`. Version **8.x-2.6**. Core `^8||^9||^10||^11`.

Authentication/integration — **security-sensitive** SSO: keep the shared secret/token secret (env/Key, HTTPS),
ensure unambiguous mapping + validation; **review the SSO mechanism** before relying. Layers on core auth.
