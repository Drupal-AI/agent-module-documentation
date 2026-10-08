# Configure logo & wallpaper

Config object `gin_login.settings` (schema `config/schema/gin_login.schema.yml`). UI at
`/admin/config/system/configuration/gin-login` (route `gin_login.configuration_form`,
requires permission `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `logo.use_default` | bool | `true` | Use Drupal's default/site logo on the login screen. |
| `logo.path` | string | — | Path (or `public://` URI) to a custom logo when `use_default` is off. |
| `brand_image.use_default` | bool | `true` | Use one of the module's random bundled wallpapers. |
| `brand_image.path` | string | — | Path/URI to a custom wallpaper when `use_default` is off. |

The form has two sections: **Logo** (checkbox "Use default logo" + path field + file upload)
and **Wallpaper** (checkbox "Use random image" + path field + file upload). Uploaded files are
copied into the default file scheme; typed paths are resolved relative to the public files dir
and stored as `public://…` URIs. On save the router is rebuilt.

Accepted logo extensions: `png gif jpg jpeg apng webp avif svg`; wallpaper: same minus `svg`
(and must be an image). Read/write with `drush config:get gin_login.settings` /
`drush config:set gin_login.settings logo.use_default 0 -y`.

The login screen also inherits Gin's accent color, focus color, dark mode and high-contrast
settings from `gin` — configure those on the Gin theme settings page, not here.
