<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Achla AI Search — setup

1. `composer require drupal/achlaai_search` then `drush en achlaai_search`.
2. Grant **Manage the Achla AI Search connector** (`manage achlaai_search connector`) only to trusted operators — it is a `restrict access: true` permission.
3. Open **Configuration → Web services → Achla AI Search** (`/admin/config/services/achlaai-search`).
4. Start an Ownership v2 attempt from that page; Achla completes it by POSTing to `/achla-ai/ownership/callback`.
5. Configure widget placement (CSS selector); validate it with the CSRF-protected placement-validation route.
6. Check `/admin/config/services/achlaai-search/status` for lifecycle state.

Legacy `achlaai/achlaai-search` sites: `composer remove achlaai/achlaai-search --no-update` then `composer require drupal/achlaai_search --with-all-dependencies`. Upgrades disable the old connector; an admin must reconnect before widget output resumes.
