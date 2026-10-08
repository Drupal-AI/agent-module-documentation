<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — include / exclude paths

Config object: **`admin_theme.settings`** (schema in `config/schema/admin_theme.schema.yml`).

| Key | Form field | Meaning |
|---|---|---|
| `paths` | **Include** | Newline-separated path patterns where the admin theme IS used. |
| `exclude_paths` | **Exclude** | Newline-separated path patterns where the admin theme is NOT used. |

Both values are plain strings fed to a core `request_path` condition, so they use the same
syntax as block "Pages" visibility: one path per line, leading slash, `*` wildcard, and the
`<front>` token. Shipped default for both keys (a placeholder workaround for core issue
2930364): `/dummy-path-needed-until-core-issue-2930364-is-fixed`.

## Where you set it (UI)

There is no module-specific settings page. The two fields are injected into the appearance
form at **`/admin/appearance`** (`system_themes_admin_form`), under fieldsets **Include** and
**Exclude**. The `configure` link in `.info.yml` points at `system.themes_page`.

## How it takes effect

`admin_theme.admin_context` decorates the core `router.admin_context` service
(`AdminThemeAdminContext`). When the current path matches `paths` and does not match
`exclude_paths`, `isAdminRoute()` returns TRUE, so Drupal renders the page with the admin
theme. After saving, the module flags the router for rebuild.

## Set it via drush / config

```bash
# Read current include/exclude lists:
drush config:get admin_theme.settings

# Apply the admin theme to a dashboard and its sub-pages:
drush config:set admin_theme.settings paths "/company-dashboard
/company-dashboard/*" -y

# Exclude a path from the admin theme:
drush config:set admin_theme.settings exclude_paths "/node/add/landing_page" -y
```

Notes:
- `paths` / `exclude_paths` are single strings with embedded newlines, not sequences.
- Changing them may require a cache/router rebuild to fully take effect (`drush cr`).
- Leaving a key at the shipped dummy value effectively means "match nothing".
