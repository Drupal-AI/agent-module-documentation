<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `custom_toc.module` — hooks & helpers

All node-level wiring lives in `custom_toc.module`. It has **no procedural config**, no routes and
no services; it consumes `toc_api` services and the `toc_api` "default" `TocType` config entity.

## Field discovery helpers

- `custom_toc_get_active_field_name(NodeInterface): ?string` — returns the first **non-deleted**
  field on the node whose type is `toc_link_overrides`.
- `custom_toc_field_definition_is_deleted(FieldDefinitionInterface): bool` — TRUE when a
  `FieldConfigInterface` is deleted.
- `custom_toc_get_source_field(NodeInterface, $toc_field): string` — the TOC field's `source_field`
  setting, defaulting to `body`.
- `custom_toc_get_deleted_source_field(NodeInterface): string` — via
  `entity_field.deleted_fields_repository`, the source field of a **deleted** TOC field for this
  entity type/bundle (used only to strip a stray injected TOC).
- `custom_toc_has_html_headings(string): bool` — `preg_match('/<h[1-6]\b/i', …)`.
- `custom_toc_update_source_html(string): string` — runs source HTML through
  `toc_api.manager->create('toc_filter', …)` and returns `$toc->getContent()` (heading IDs applied).

## `hook_form_node_form_alter`

`custom_toc_form_node_form_alter()` runs only on `node` entity forms that have an active TOC field
and a non-empty `source_field`. It:

1. Adds the pre-save submit handler (`custom_toc_add_regenerate_submit_handler()`), splicing
   `custom_toc_node_form_submit` **before** `::save` in `$form['actions']['submit']['#submit']`.
2. If the editor has **not** already typed a TOC value, filters the source text with
   `check_markup()`, builds a TOC via `toc_api.manager` + `toc_api.builder` (using the "default"
   `TocType` options), renders it, and sets it as the TOC widget's `#default_value` — forcing the
   widget's format to `full_html`. Only seeds when `$toc->isVisible()`.

So opening a node edit form pre-fills an initial TOC, but any manual edit to the TOC field is
preserved.

## Pre-save submit — `custom_toc_node_form_submit`

Runs only when `custom_toc_regenerated` is set in form state. It applies the **rewritten source
HTML** (heading IDs) back to the source field before `::save`:

- Uses the stashed `custom_toc_regenerated_source_html` when present (only writes if it differs
  from the current source value, preserving `format`/`summary`); otherwise, if the source has
  headings, regenerates via `custom_toc_update_source_html()` and writes that.

This is what makes the in-page TOC anchor links line up with the body headings.

## `hook_node_view` — placing / replacing the TOC

`custom_toc_node_view()`:

1. **No active TOC field** → strip any TOC another module injected: if a *deleted* TOC field's
   source is known, `custom_toc_remove_injected_toc()` on that field; else
   `custom_toc_remove_any_injected_toc()` sweeps every field build for an `['toc']` element. Return.
2. **TOC field present but empty** → same removal (scoped to the source field if known). Return.
3. **TOC field has a value** → render it (`$node->get($toc_field)->view(['label' => 'hidden'])`).
   - If `toc_api`/another module already injected a `['toc']` into the **source field** build,
     `custom_toc_replace_injected_toc()` swaps in the stored TOC and drops the standalone TOC field
     build. Return.
   - Otherwise, if the TOC field's display component exists and is **not hidden**, leave the normal
     field rendering as-is; if it is hidden (or has no component), inject the rendered TOC into the
     build with `#weight => -10`.

## Ordering & page attachments

- `custom_toc_module_implements_alter()` moves `custom_toc`'s `hook_node_view` implementation to
  run **after** `toc_api_example`'s, so removal/replacement sees the already-injected TOC. (The
  README recommends **not** enabling `toc_api_example` alongside this module to avoid anchor
  desync.)
- `custom_toc_page_attachments()` attaches library `custom_toc/field_ui_icons` on the Field UI
  "add field storage" routes — an optional add-field-modal icon. This release ships **no
  `custom_toc.libraries.yml`**, so the attachment resolves to nothing.
