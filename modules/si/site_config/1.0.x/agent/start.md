<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Config — agent index

Manages **global site configuration**, with optional `site_config_jsonapi` / `site_config_rest` submodules that
**expose config over JSON:API/REST**. Depends on core `language`. Version **1.0.1**. Core `^10.2||^11`.

Admin/config (web-services angle) — if the API submodules are enabled, config becomes **readable over an API**:
expose only settings safe to be **public** (not secrets/admin-only), gate the REST resources. No access role of
its own.
