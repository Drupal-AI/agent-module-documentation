# Permissions

Defined in `smart_title_ui.permissions.yml`.

| Permission (label) | Machine name | Grants |
|---|---|---|
| Manage Smart Title configuration | `administer smart title` | Access to the settings form at `/admin/config/content/smart-title` — the sole `_permission` requirement on route `smart_title_ui.settings`. |

Holders can change which entity-type bundles are Smart-Title-eligible, which on save can also
strip `smart_title` third-party settings (`enabled`, `settings`) from existing entity view
displays of any bundle they untick. Treat it as a site-building / display-administration
permission and grant it only to trusted roles. It is the only permission the submodule defines;
the parent `smart_title` module defines none.
