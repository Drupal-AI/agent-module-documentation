<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_image — agent index

Config/glue module of the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Installs an
**Image media type** (`media.type.image`) with its image/categories/tags fields, two form displays, twelve
view displays, three view modes, and eighteen `coh_*` image styles. A little PHP grants image-media
permissions to the distribution's roles and auto-creates the Acquia CMS logo media on install. No settings
page (`configure` is null) and no config-schema/permissions/drush/plugins of its own.

- **The Image media type and all the config it installs (fields, displays, image styles, view modes) + how to override** → [configure/media-type.md](configure/media-type.md)
- **How it grants image-media permissions to `content_author`/`content_editor` and its install-time behavior** → [hooks/roles.md](hooks/roles.md)
- **The site-logo automation: `SiteLogo` service + config-import subscriber** → [events/config-import.md](events/config-import.md)

Key facts:
- Media type id `image`, source plugin `image`, source field `image` (`field.storage.media.image`, required, extensions `png gif jpg jpeg`, `new_revision: true`, translatable). Field instances `field_categories`/`field_tags` (taxonomy references) are installed here; their field storages + vocabularies come from `acquia_cms_common`.
- Form displays `default` and `media_library` use the `image_focal_point` widget and a field_group "Taxonomy" fieldset. View displays map the image to `coh_*` styles with lazy loading.
- View modes provided: `teaser`, `x_small_square`, `large_super_landscape`. Content translation enabled for the `image` bundle (`language.content_settings.media.image`).
- `acquia_cms_image_content_model_role_presave_alter()` (in `.module`) grants `create image media` / `edit own image media` / `delete own image media` to `content_author` and `edit any image media` / `delete any image media` to `content_editor` (core-media per-bundle permissions; not defined by this module).
- `acquia_cms_image_modules_installed()` (in `.install`) runs `_acquia_cms_common_editor_config_rewrite(TRUE)` and creates the logo media via `SiteLogo` on non-sync install.
- Service `acquia_cms_image.config_subscriber` (`AcquiaCmsImageConfigSubscriber`, subscribes to `ConfigEvents::IMPORT`) + internal `SiteLogo` class (`Drupal\acquia_cms_image\SiteLogo`, fixed logo media UUID `0c6f0f26-9fbb-4c2e-804c-418815aba162`, `public://media-icons/acquia_cms_logo.png`).
- `config/pack_acquia_cms_image*` are Site Studio (Cohesion) sync packages, only meaningful when `acquia_cms_site_studio` is present; update hooks `8004`/`8005` maintain them.
