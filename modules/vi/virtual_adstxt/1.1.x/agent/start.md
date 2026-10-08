<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Virtual Ads.txt (virtual_adstxt) — agent index
**Serves an editable `/ads.txt` from site config so publishers manage ad sellers without filesystem access.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Routes:** `/ads.txt` (`AdstxtController::show`, perm `access content`, read-only `text/plain`); `/admin/config/adstxt` (`AdminAdstxtForm`, perm `administer virtual_adstxt settings`).
- **Config:** `virtual_adstxt.settings` (`ads_txt`).

**Security:** Public `/ads.txt` is read-only under `access content` (ads.txt is meant to be public). The edit route requires `administer virtual_adstxt settings`, but the module defines no `permissions.yml` for it — so the permission is not UI-grantable and the form is effectively user-1-only (fail-closed; not writable by low-privilege users). No mutating anonymous endpoint. No security findings (informational: undefined edit permission).
