<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Edit Link (entity_reference_edit_link) — agent index

Adds an **"Edit" link beside the referenced entity inside entity reference field _widgets_** on
entity edit forms (this is a widget add-on, **not** a display formatter). Version **1.1.6**, core
`^9 || ^10 || ^11`, package `Field`, license GPL-2.0-or-later. No dependencies; no permissions,
Drush commands, or config schema of its own.

## Mechanism (read the source, not the assumptions)

- **No new plugin IDs.** `hook_field_widget_info_alter()` (in `.module`) swaps the *class* of two
  core widgets:
  - `entity_reference_autocomplete` → `EntityReferenceEditLinkAutocompleteWidget`
    (`src/Plugin/Field/FieldWidget/`), a subclass of core `EntityReferenceAutocompleteWidget`.
  - `entity_reference_autocomplete_tags` → `EntityReferenceEditLinkAutocompleteTagsWidget`,
    which **unsets** the link (tags widget shows no edit link).
- **The autocomplete widget** (`formElement()`): for the entity at this `$delta`, adds a `_link`
  render element **only if** the referenced entity `hasLinkTemplate('edit-form')` **and**
  `$referencedEntity->access('update', $user)` passes. The link is `#type => link`,
  `#url => $referencedEntity->toUrl('edit-form')`, `target="_blank"`. Access check is present and
  per-entity here.
- **Multi-value autocomplete rendering:** `hook_preprocess_field_multiple_value_form()` moves each
  row's `_link` into an added **"Edit Entity"** table column.
- **Select2 support:** `hook_field_widget_complete_form_alter()` handles the `select2_entity_reference`
  widget. `_entity_reference_edit_link_prepare_link()` builds a single link (single-value) or a
  **dropbutton** (multi-value).
- **Second, separate feature — the "Manage fields" title link:** `hook_form_alter()` +
  `hook_preprocess_page_title()` (+ `hook_theme_registry_alter()` for Gin ordering) add an
  `Edit <type>` link to the **node edit page title**, pointing to the content type's Field UI
  *field_ui_fields* route (`target="_blank"`). Gated by: the node's bundle being selected on the
  settings page (`entity_reference_edit_link.config` → `content_types`) **and** the current user
  holding `administer node fields`. Node forms only.
- **Styling:** attaches library `entity_reference_edit_link/reference.field` (CSS only,
  `css/reference-field.css`).

## Configuration

- Route `entity_reference_edit_link.config` → `/admin/config/entity-reference-edit-link`
  (`EditLinkConfigForm`), permission **`administer site configuration`**. Stores
  `entity_reference_edit_link.config:content_types` (a checkboxes list of node types) for the
  Manage-fields title link. The inline reference edit link itself needs **no configuration** — it is
  active for the affected widgets as soon as the module is enabled.

## Where to look

- `usage.md` — narrative + use cases.
- `agent/fields/edit-link-widget.md` — deep dive on the widget mechanism and access model.

## Gotchas

- It is a **widget** feature: it appears on **edit forms**, not on rendered/display output.
- Links open in a **new tab** (`target="_blank"`) — earlier docs that said "dialog" were wrong.
- The **tags** autocomplete widget is intentionally excluded.
- Editing a referenced entity from here changes it **everywhere** it is referenced — surface this to
  editors.
