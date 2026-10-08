<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Extra Field lets site builders attach configurable "extra" (pseudo) fields — blocks, views, tokens, inline Twig, entity links, or SDC components — to any content entity's view or form display, positioned like real fields on *Manage display* / *Manage form display*.

---

Each extra field is an `entity_extra_field` config entity (config prefix `extra_field`, id `<entity_type>.<bundle>.<name>`) that records a target entity type/bundle, a display type (`view` or `form`), a chosen field-type plugin, that plugin's configuration, and optional visibility conditions (core Condition plugins, "any" or "all" pass). The module defines an `ExtraFieldType` plugin type (manager `plugin.manager.extra_field_type`, discovered from `Plugin/ExtraFieldType`, annotation `@ExtraFieldType`) and ships six plugins: **block** (render any block plugin, with its config form and context), **views** (embed a view display with offset/arguments/title), **token** (output token-replaced text as plain or, optionally, raw/unfiltered HTML, or a formatted text_format value), **twig** (render an inline Twig template with entity + site context), **entity_link** (render an entity link template such as canonical/edit/delete), and **component** (render a Single Directory Component with slot/prop mappings). At runtime `hook_entity_extra_field_info()` registers the pseudo fields, and `hook_entity_view()` / `hook_form_alter()` build them via `entity_extra_field_display()`, which queries matching config entities, checks their display component + conditions, and renders each plugin's `build()` with proper cache tags/contexts. The base module has no admin UI of its own; enabling the **entity_extra_field_ui** submodule (requires `field_ui`) adds the "Manage extra fields" operation and the add/edit/delete forms per bundle. All UI is gated by the `administer entity extra field` permission, and a report at `/admin/reports/extra-fields` lists all configured extra fields. Config is translatable.

---

- Add a page title as an extra field on a content type's view display.
- Render a block (e.g. a menu, a custom block, a system block) between two real fields on an entity.
- Embed a related-content view directly in a node's display, passing the node id as a contextual argument.
- Output a token value (e.g. `[node:author:name]`) as a pseudo field.
- Render an inline Twig template that mixes entity data and site context into custom markup.
- Add a "canonical", "edit-form", or "delete-form" entity link as a field.
- Render a Single Directory Component (SDC) with props/slots mapped from the entity.
- Place an extra field on a *form* display (e.g. inject a block or instructions into the node edit form).
- Show an extra field only when a visibility condition passes (path, role, node type, etc.).
- Require all conditions to pass (AND) or any condition (OR) before an extra field renders.
- Reuse the same block across many bundles without placing it in a region.
- Add missing display elements to entities that lack them out of the box.
- Give editors a token-driven summary line without adding a stored field.
- Add computed/derived display-only content that never needs storage.
- Position extra fields precisely among real fields via drag-and-drop on *Manage display*.
- Embed a view of child/related entities using an entity-reference field as the token/argument source.
- Output raw HTML from a token when you deliberately need markup (unfiltered option, trusted admins only).
- Build a bundle-specific layout by combining several extra fields (blocks + views + tokens).
- Attach the extra field only to specific view modes (teaser vs full) via the display component.
- Disable the UI submodule in production once extra fields are configured, keeping the fields active.
- Translate extra field labels/descriptions and text_format token values on multilingual sites.
- Audit every configured extra field from the `/admin/reports/extra-fields` report.
- Alter the Twig extra field's context from custom code via `hook_entity_extra_field_twig_context_alter()`.
- Register additional field-type plugins by implementing the `ExtraFieldType` plugin type.
