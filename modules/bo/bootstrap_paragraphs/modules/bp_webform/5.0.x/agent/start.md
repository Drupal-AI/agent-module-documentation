<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Webform — agent index

Config-only submodule of **bootstrap_paragraphs**. Installs exactly one paragraph type,
`bp_webform` ("Webform"), holding a single Webform entity reference plus the shared
width/background styling fields. No configure route, no settings form, no permissions, no
Drush, no plugins, no services, no config schema, **no templates and no CSS**. Its entire
PHP is a `hook_help()`.

- **The bundle, its three fields, the webform-reference settings, displays, and how to
  expose it on a content type** → [configure/webform-bundle.md](configure/webform-bundle.md)

Key facts:

| | |
|---|---|
| Paragraph type | `bp_webform` (label `Webform`) |
| Own field | `bp_webform` — field type `webform`, `cardinality: 1`, `handler: default:webform` |
| Inherited fields | `bp_width`, `bp_background` (`list_string`, parent storages) |
| Form widget | `webform_entity_reference_select` |
| View formatter | `webform_entity_reference_entity_view`, `source_entity: false` |
| Field item columns | `target_id`, `default_data`, `status` (ships `open`), `open`, `close` |
| Config location | **`config/install/`** — unlike its siblings, so it IS removed on uninstall |
| Extra dependency | `drupal/webform` |

Two things that differ from the other bp_* submodules: the config is `install` (owned by the
module) rather than `optional`, and there is **no** `paragraph--bp-webform.html.twig`, so
`bp_width`/`bp_background` are rendered by the `list_key` formatter as text rather than being
mapped into wrapper CSS classes. Nothing is editor-visible until an
`entity_reference_revisions` field lists `bp_webform` in
`settings.handler_settings.target_bundles`.
