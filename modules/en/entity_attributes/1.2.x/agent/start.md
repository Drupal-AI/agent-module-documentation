<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Attributes (entity_attributes) — agent index

Adds a YAML-edited **"Attributes" field** to many entity types and merges the parsed attributes into
the entities' Twig template variables (`attributes`, `title_attributes`, `content_attributes`,
`link_attributes`, `author_attributes`, plugin-defined sets). Package **Fields**. Core `^11`.
License GPL-2.0-or-later. Version **1.2.0**. Depends only on core **`field`** + **`system`**.

- **Settings form, config objects, schema, permissions, enabling entity types, CodeMirror** →
  [config/settings.md](config/settings.md)
- **Plugin type, base classes, the 8 bundled plugins, the processor + preprocess hooks, widget /
  formatter / field service, YAML validation, uninstall validator — i.e. how attributes get onto
  rendered markup** → [architecture/rendering.md](architecture/rendering.md)

## What it actually is

- A **plugin type** `entity_attributes` (manager `EntityAttributesManager` at
  `src/EntityAttributesManager.php`, PHP attribute `src/Attribute/EntityAttributes.php`, legacy
  annotation `src/Annotation/EntityAttributes.php`, interface `EntityAttributesInterface`, base
  `EntityAttributesBase` + `ContentEntityAttributesBase` / `ConfigEntityAttributesBase`). Plugins
  live in `src/Plugin/EntityAttributes/`.
- One **field widget** `entity_attributes_yaml` (`AttributesWidget`) and one **field formatter**
  `entity_attributes_hidden` (`AttributesFormatter`, renders nothing — attributes are applied in
  preprocess, not shown as field output). Both target the core `string_long` field type.
- One **settings route** `entity_attributes.config_form` at `/admin/config/search/entity-attributes`
  (`administer entity attributes`), plus dynamic per-bundle permissions `edit entity attributes
  {entity_type} {bundle}`.
- Two **submodules**: `entity_attributes_eck` (ECK entities), `entity_attributes_paragraphs`
  (paragraphs) — each adds one plugin + one preprocess hook. Documented under
  `modules/en/entity_attributes/modules/<submodule>/1.2.x/`.

## Bundled plugins (`src/Plugin/EntityAttributes/`)

| Plugin id | Class | Entity type(s) | Storage | Attribute sets |
|---|---|---|---|---|
| `node` | NodeAttributes | node | field | attributes, title_attributes, content_attributes, author_attributes |
| `taxonomy_term` | TaxonomyTermAttributes | taxonomy_term | field | attributes |
| `menu_link_content` | MenuLinkContentAttributes | menu_link_content | field | attributes, link_attributes |
| `block` | BlockAttributes | block | third_party_settings | attributes, title_attributes, content_attributes |
| `menu` | MenuAttributes | menu | third_party_settings | attributes, title_attributes, content_attributes |
| `static_menu_link` | StaticMenuLinkAttributes | menu_link | config object | attributes, link_attributes |

`node`/`taxonomy_term`/`menu_link_content` are content-entity plugins; `block`/`menu`/`static_menu_link`
are config-entity plugins. Submodules add `paragraph` and `eck_entity`.

## Services (`entity_attributes.services.yml`)

- `plugin.manager.entity_attributes` — plugin manager.
- `entity_attributes.processor` (`EntityAttributesProcessor`) — reads stored attributes and merges
  them into template variables in preprocess.
- `entity_attributes.field` (`EntityAttributesField`) — builds/enhances the attributes form element,
  YAML validation + submit handlers for config-entity forms.
- `entity_attributes.permissions` (`EntityAttributesPermissions`) — dynamic permissions + runtime
  permission checks.
- `entity_attributes.uninstall_validator` — blocks uninstall while plugins are enabled.
