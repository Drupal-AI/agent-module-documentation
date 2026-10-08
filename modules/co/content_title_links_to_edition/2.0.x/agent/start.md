<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Title Links to Edition (content_title_links_to_edition) — agent index

Rewrites the **node title field in a configured Views listing** so it links to that node's
**edit form** (`entity.node.edit_form`) instead of its normal target. Package `Content`.
Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0. Depends only on core
**`node`** and **`views`** — no non-core requirements, no libraries, no Drush, no plugins.

- **Settings form, config object + schema, permission, install defaults, and the rewrite
  mechanism** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One display-time hook, `content_title_links_to_edition_preprocess_views_view_field()` in
  `content_title_links_to_edition.module`. For a rendered Views field it checks the config's
  `allowed_views` list; when the current `$view->id()` and `$field->field` match an **enabled**
  row, and the row entity is a `NodeInterface` whose bundle is permitted (`all_content_types`, or
  listed in `content_types`), it strips `<a>` tags from `$variables['output']` with a
  `preg_replace` and re-wraps the text in `Link::fromTextAndUrl(...)` pointing at
  `Url::fromRoute('entity.node.edit_form', ['node' => $entity->id()])`. Multilingual sites add the
  row language to the URL options.
- Two config-sync hooks keep the content-type list current:
  `content_title_links_to_edition_entity_bundle_create()` adds a new node bundle to
  `content_types` (enabled if `enable_contents_automatically`), and
  `..._entity_bundle_delete()` removes it. `hook_install` seeds `content_types` from existing
  enabled node types.
- `hook_help` for `help.page.content_title_links_to_edition`.

## Config, route, permission

- **Config object** `content_title_links_to_edition.settings` — keys `allowed_views` (sequence of
  `{enabled, view, title}`), `enable_contents_automatically` (bool), `all_content_types` (bool),
  `content_types` (map of bundle → "0"/"1"). Schema in `config/schema/`, defaults in
  `config/install/` (ships with the core `content` view / `title` field enabled).
- **Settings route** `content_title_links_to_edition.content_title_links_to_edition_settings_form`
  → `/admin/config/content_title_links_to_edition/settings`, form
  `\Drupal\content_title_links_to_edition\Form\SettingsForm`, admin route. Menu link under
  *Configuration → Content authoring* (`system.admin_config_content`) + a local task tab.
- **Permission** `administer content title links to edition` (`restrict access: TRUE`) gates the
  form.

See [config/settings.md](config/settings.md) for form fields, AJAX row handling, and cache
invalidation.
