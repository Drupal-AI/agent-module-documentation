<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig function & filter catalogue

Every function/filter, the submodule that must be enabled, and its signature. Call them directly
in any `.html.twig`. (Signatures show PHP defaults; optional args can be omitted in Twig.)

## bamboo_twig_loader — render & load

Functions (`render_*` are marked `is_safe: html`):

- `bamboo_render_block(block_id, params = {}, wrapper = false)` — render a block plugin by id;
  injects runtime contexts; `wrapper=true` wraps in the `block` theme.
- `bamboo_render_form(module, form, params = null)` — build `Drupal\<module>\Form\<form>`.
- `bamboo_render_entity(entity_type, id = null, view_mode = '', langcode = null)` — id omitted →
  uses the entity from the current route.
- `bamboo_render_entity_revision(entity_type, revision_id = null, view_mode = '', langcode = null)`.
- `bamboo_render_region(region, theme = null)` — render all blocks in a region (default theme if omitted).
- `bamboo_render_field(field_name, entity_type, id = null, langcode = null, formatter = null)`.
- `bamboo_render_image(file_id, style, alt = null)` — render via the `image_style` theme.
- `bamboo_render_image_style(path, style, preprocess = false)` — returns the derivative URL.
- `bamboo_render_menu(menu_name, level = 1, depth = 0)` — depth 0 = unlimited.
- `bamboo_render_views(name, display, ...args)` — alias of core `views_embed_view`.

Loaders (return objects, not markup):

- `bamboo_load_entity(entity_type, id = null, langcode = null)` — translation-aware.
- `bamboo_load_entity_revision(entity_type, revision_id = null, langcode = null)`.
- `bamboo_load_field(field_name, entity_type, id = null, langcode = null)` — the FieldItemList, or null if empty.
- `bamboo_load_currentuser()` — the User entity, or null when anonymous.
- `bamboo_load_image(path)` — an `ImageInterface` for a path/URI.

## bamboo_twig_config — read config/settings/state

- `bamboo_config_get(name, key)` — `config.factory->get(name)->get(key)`, e.g.
  `bamboo_config_get('system.site', 'name')`.
- `bamboo_settings_get(key)` — a `settings.php` value (`Settings::get`).
- `bamboo_state_get(key)` — a State API value.

## bamboo_twig_security — permissions & roles

- `bamboo_has_permission(permission, user = null)` — user omitted → current user; null if anon/missing.
- `bamboo_has_permissions(permissions[], conjunction = 'AND', user = null)` — AND/OR (invalid conjunction throws).
- `bamboo_has_role(role, user = null)`.
- `bamboo_has_roles(roles[], conjunction = 'AND', user = null)`.

## bamboo_twig_i18n — internationalization

- `bamboo_i18n_current_lang()` — current language id (e.g. `en`).
- `bamboo_i18n_format_date` (filter) — `date|bamboo_i18n_format_date(type = 'medium', format = '', timezone = null, langcode = null)`; needs the Twig environment.
- `bamboo_i18n_get_translation` (filter) — `entity|bamboo_i18n_get_translation(langcode = null)` → the entity translation for the context language.

## bamboo_twig_token — tokens

- `bamboo_token(token, data = {}, options = {})` — replaces `[token]`; pass the token **without**
  brackets, e.g. `bamboo_token('site:name')` or `bamboo_token('node:title', {'node': node})`.

## bamboo_twig_file — files

- `bamboo_file_url_absolute(uri)` (function) — absolute URL for a stream URI (`generateAbsoluteString`).
- `bamboo_file_extension_guesser` (filter) — `mime_type|bamboo_file_extension_guesser` → best-guess extension.

## bamboo_twig_path — paths

- `bamboo_path_system(type, name = null)` — path to a `module`/`theme`/`profile`/`theme_engine`/`core`
  (name ignored for `core`), e.g. `bamboo_path_system('module', 'bamboo_twig')`.

## bamboo_twig_cacheable — cache metadata

- `bamboo_attach_cacheable_metadata(cacheable_metadata)` — attaches `#cache` keys, keeping only
  `tags`, `contexts`, `max-age`, e.g. `{{ bamboo_attach_cacheable_metadata({'contexts': ['user'], 'tags': ['node:1']}) }}`.

## bamboo_twig_extensions — Twig-Extensions filters

Three filters ported from the upstream Twig-Extensions library, **prefixed `bamboo_extensions_`**:

- `bamboo_extensions_truncate` (Text, needs environment) — `string | bamboo_extensions_truncate(length = 30, preserve = false, separator = '...')`.
- `bamboo_extensions_time_diff` (Date, needs environment) — `date | bamboo_extensions_time_diff(now = null, unit = null, humanize = true)` (human "N days ago").
- `bamboo_extensions_shuffle` (Array) — `array | bamboo_extensions_shuffle` (randomise).
