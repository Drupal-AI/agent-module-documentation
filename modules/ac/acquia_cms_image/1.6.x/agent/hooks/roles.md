# Role permissions and install-time behavior

The module defines **no permissions of its own** (`provides_permissions: false`, no `*.permissions.yml`).
Instead it grants the core-media per-bundle permissions for the `image` bundle to the Acquia CMS roles, and
runs a couple of side effects on install.

## `acquia_cms_image_content_model_role_presave_alter(RoleInterface &$role)`

In `acquia_cms_image.module`. This implements `hook_content_model_role_presave_alter()` — an alter hook
**invoked by `acquia_cms_common`** while it builds/saves the distribution's roles. It grants:

| Role id | Permissions granted |
|---|---|
| `content_author` | `create image media`, `edit own image media`, `delete own image media` |
| `content_editor` | `edit any image media`, `delete any image media` |

These permission strings are provided by core's Media module (per-bundle `... image media`), not by this
module. The hook only fires within the `acquia_cms_common` role-presave flow, so on a non-Acquia-CMS site
these grants do not happen automatically.

## `acquia_cms_image_modules_installed($modules, $is_syncing)`

In `acquia_cms_image.install` (implements `hook_modules_installed()`). When the module is installed **not**
during a config sync (`!$is_syncing`) it:

1. Calls `_acquia_cms_common_editor_config_rewrite(TRUE)` — an `acquia_cms_common` helper that rewrites CKEditor
   config (so images can be embedded in text formats).
2. Runs `\Drupal::classResolver(SiteLogo::class)->createLogo()->setLogo()` to create the Acquia CMS logo media
   and set it as the global site logo. See [events/config-import.md](../events/config-import.md) for the
   `SiteLogo` details and the config-import path that does the same thing.

## Update hooks (`hook_update_N`)

In `acquia_cms_image.install`, run by `drush updatedb`:

| Hook | Effect |
|---|---|
| `_update_8001` | Replaces the old `image_scale_and_crop` effect on ten `coh_*` landscape/super-landscape styles with `focal_point_scale_and_crop` at fixed dimensions. |
| `_update_8002` | Resets the `image` formatter's image style on seven view displays (`embedded`, `large`, `large_landscape` → `coh_large_super_landscape`, `medium`, `medium_landscape`, `small`, `small_landscape`). |
| `_update_8003` | Installs new view modes/displays/styles (`teaser`, `x_small_square`, `large_super_landscape`, `x_small_landscape`, `x_small_square`) via `_acquia_cms_common_rewrite_configuration()` and adds lazy loading. |
| `_update_8004` | If `acquia_cms_site_studio` is enabled, adds an enforced `[acquia_cms_image, acquia_cms_site_studio]` module dependency to the `config/pack_acquia_cms_image` Site Studio templates. |
| `_update_8005` | If `acquia_cms_site_studio` is enabled, deletes `pack_acquia_cms_image*` Site Studio config objects that contain invalid data (no `uuid`/`id`), logging each deletion. |
