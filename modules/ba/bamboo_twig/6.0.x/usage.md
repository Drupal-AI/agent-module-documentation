<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig is a collection of Twig extensions that add useful functions and filters to Drupal templates — rendering blocks, regions, entities, fields, forms, menus and views; reading config/state/settings; checking permissions/roles; formatting dates; handling files, paths and tokens — all callable directly from `.html.twig` files.

---

The project is split into a lightweight parent module and nine topic submodules, enabled à la carte for performance. The parent (`bamboo_twig`) itself registers **no** Twig function; it only provides the private base service `bamboo_twig.twig.base` (`\Drupal\bamboo_twig\TwigExtension\TwigExtensionBase`), an `AbstractExtension` subclass that lazily resolves Drupal services from the container (entity type manager, block manager, form builder, renderer, image factory, token, language manager, file URL generator, etc.). Every submodule's Twig extension `parent:`s that base service, so services are only instantiated when a template actually calls a function. The submodules are: **cacheable** (`bamboo_attach_cacheable_metadata`), **config** (`bamboo_config_get`, `bamboo_settings_get`, `bamboo_state_get`), **extensions** (Twig-Extensions Text/Date/Array filters), **file** (`bamboo_file_url_absolute`, `bamboo_file_extension_guesser`), **i18n** (`bamboo_i18n_current_lang`, `bamboo_i18n_format_date`, `bamboo_i18n_get_translation`), **loader** (`bamboo_load_*` and `bamboo_render_*`), **path** (`bamboo_path_system`), **security** (`bamboo_has_permission(s)`, `bamboo_has_role(s)`), and **token** (`bamboo_token`). There is no configuration UI, no permissions, and no Drush; you enable the submodules you need and call the functions in Twig.

---

- Render a configured block by plugin id from a template (`bamboo_render_block`).
- Render all blocks in a theme region into a custom template (`bamboo_render_region`).
- Render an entity by type and id in a chosen view mode (`bamboo_render_entity`).
- Render a single entity field with an optional formatter (`bamboo_render_field`).
- Embed a Drupal form by module + class name in Twig (`bamboo_render_form`).
- Render a menu tree with level/depth control (`bamboo_render_menu`).
- Embed a View by name and display (`bamboo_render_views`).
- Output an image style derivative URL or render an image-style image (`bamboo_render_image_style`, `bamboo_render_image`).
- Load an entity, field, revision, current user or image object for use in a template (`bamboo_load_*`).
- Read a Config API value from a template (`bamboo_config_get`).
- Read a `settings.php` value (`bamboo_settings_get`) or a State API value (`bamboo_state_get`).
- Check whether the current or a given user has a permission or role (`bamboo_has_permission`, `bamboo_has_role`).
- Check a collection of permissions/roles with AND/OR conjunction (`bamboo_has_permissions`, `bamboo_has_roles`).
- Get the current language code in a template (`bamboo_i18n_current_lang`).
- Format a date honouring Drupal i18n (`bamboo_i18n_format_date`).
- Get the correct translation of an entity for the current language (`bamboo_i18n_get_translation`).
- Replace a Drupal token from a template (`bamboo_token`).
- Build an absolute file URL from a stream URI (`bamboo_file_url_absolute`).
- Guess a file extension from a MIME type (`bamboo_file_extension_guesser`).
- Resolve the filesystem path of a module/theme/profile (`bamboo_path_system`).
- Attach cacheable metadata (tags/contexts/max-age) from a template (`bamboo_attach_cacheable_metadata`).
- Use the Twig-Extensions Text/Date/Array filters (truncate, time_diff, etc.) in Drupal.
- Enable only the submodules you use to keep the Twig runtime lean.
