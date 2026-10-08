<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings (`custom_breadcrumbs.settings`)

Settings form at `/admin/config/user-interface/custom-breadcrumbs` (route
**`custom_breadcrumbs.config`**, permission `administer custom_breadcrumbs`). Stored in the config
object **`custom_breadcrumbs.settings`**. These apply to every trail the module builds.

| Key | Type | Default | Effect |
|---|---|---|---|
| `home` | bool | `true` | Prepend a "Home" crumb linking to `<front>` (skipped on the front page). |
| `home_link` | string | `Home` | Label for the Home crumb (XSS-filtered). |
| `current_page` | bool | `true` | Append the current page's title as the final crumb (skipped on front page). |
| `current_page_link` | bool | `false` | If true, the current-page crumb links to itself; otherwise it is plain text. |
| `trim_title` | int | `0` | Max characters per crumb title; longer titles are truncated with `...`. `0` = no trim. |
| `admin_pages_disable` | bool | `false` | If true, the builder does not apply on admin routes. |
| `site_wide` | bool | `false` | If true, the builder applies on **every** route (not only path/entity matches). |

Read / write:

```bash
drush config:get custom_breadcrumbs.settings
drush config:set custom_breadcrumbs.settings home_link 'Start' -y
drush config:set custom_breadcrumbs.settings admin_pages_disable true -y
```

```php
\Drupal::configFactory()->getEditable('custom_breadcrumbs.settings')
  ->set('current_page_link', TRUE)
  ->set('trim_title', 40)
  ->save();
```

Notes:

- The builder's `applies()` returns FALSE on admin routes when `admin_pages_disable` is on, and
  otherwise requires a matching path pattern, a matching content-entity breadcrumb, **or**
  `site_wide = true`.
- The settings config is translatable (`custom_breadcrumbs.config_translation.yml`).
- The Home crumb and current-page crumb are added by the builder around the crumbs your
  per-trail entity defines (see [breadcrumb-entity.md](breadcrumb-entity.md)).
