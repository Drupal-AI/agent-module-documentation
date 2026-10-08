# Permissions (`eu_cookie_compliance.permissions.yml`)

- `administer eu cookie compliance popup` — access the settings form
  (`/admin/config/system/eu-cookie-compliance/settings`) and configure the banner. Also gates
  the klaro_migrator migration form.
- `administer eu cookie compliance categories` — manage `cookie_category` config entities used
  by the category‑based consent flow.
- `display eu cookie compliance popup` — controls which roles actually see the banner; grant to
  the roles (e.g. anonymous) that must be shown the consent popup.
