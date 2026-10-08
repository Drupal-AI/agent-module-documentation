<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EAF (Entity Attributes Field) adds a pluggable "attributes" field that stores non-content metadata (CSS classes, alignment/full-width flags, spacing, etc.) about an entity, its fields, or its field items, and exposes it to the theme layer.

---

EAF defines a single field type, `field_attributes_storage`, that holds a collection of *attributes* — data that is not part of the content itself but customizes how the content is displayed or behaves (for example a CSS class, a "full width" flag, an alignment choice, spacing, or "show this link as a button"). A field instance is configured to allow a chosen set of **EntityAttribute plugins**, and can offer attributes at three scopes: for the whole entity, for specific other fields on the bundle, and for individual items of those fields. Editors fill the attributes in a collapsible widget; the values are validated per plugin and stored as a single JSON string in one text column. Two debug formatters (`Attributes raw formatter`, `Attributes pretty formatter`) can print the stored JSON, but the intended output path is the module's preprocess hooks, which place the decoded attributes into `preprocess_field` / `preprocess_node` / `preprocess_paragraph` template variables so a theme can apply them to markup. The module ships two ready-made plugins (`EntityCssClass`, `FullWidth`) and an `EntityAttribute` plugin type so developers can add their own. It has no routes, permissions, external libraries, or Drush commands, and depends only on Drupal core.

---

- Add a reusable "attributes" field to a content type, paragraph, or other fieldable entity.
- Let editors add arbitrary CSS classes to an entity without touching the theme code.
- Offer a curated set of display options (e.g. left / right / center alignment) as attribute plugins.
- Add a "Full width" toggle that stretches a paragraph or section to 100% browser width.
- Store per-field attributes (e.g. mark one field to render differently) alongside the entity.
- Store per-field-item attributes (e.g. mark a single link in a multi-value link field as a button).
- Model background-color or background-image choices for sections as selectable attributes.
- Model spacing / padding options for fields or field items.
- Keep display metadata out of the main content so it is not indexed or searched.
- Persist all attribute data compactly as one JSON string in a single database column.
- Restrict which attribute plugins are available per entity type / bundle via the field settings form.
- Restrict attribute plugins per target field and per target field item separately.
- Expose stored classes/flags to Twig templates via preprocess variables for theme rendering.
- Print the raw stored attribute JSON on the entity display for debugging (raw formatter).
- Print pretty-printed attribute JSON for inspection (pretty formatter).
- Build a custom attribute (e.g. a taxonomy-driven class) by writing an EntityAttribute plugin.
- Reuse the same attribute plugins across many content types and fields.
- Sanitize editor-entered CSS classes automatically to valid CSS identifiers.
- Alter the set of attribute form elements globally via the `entity_attributes` alter hook.
- Provide a developer plugin API (`eaf.eaf_plugin_manager`) for programmatic attribute access.
- Attach a small CSS library so the attribute widget details element renders full-width in the form.
