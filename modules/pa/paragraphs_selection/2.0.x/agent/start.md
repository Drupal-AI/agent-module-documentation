<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Selection (paragraphs_selection) — agent index

Inverts Paragraphs' allowed-types model: **each paragraph bundle records which fields it may be
placed on**, instead of each field naming the bundles it accepts. Requires `paragraphs`. Ships one
submodule, `paragraphs_selection_paragraphs_sets_support`. Version **2.0.6**, core
`^9 || ^10 || ^11`, GPL-2.0-or-later. No routes, no permissions, no services, no JS/templates.

## Mechanism (verified from source)

- **The plugin.** `src/Plugin/EntityReferenceSelection/ReverseParagraphSelection.php` defines the
  EntityReferenceSelection plugin `paragraph_reverse` (label "Paragraphs Selection"), extending
  Paragraphs' `ParagraphSelection`. You opt a paragraph field in by choosing this reference handler
  in the field's reference settings; its config form is the same enable/weight drag-drop list as
  core Paragraphs (rendered by the parent `buildConfigurationForm()`), pre-filled from the bundle
  third-party settings.
- **Storage flip on save.** `paragraphs_selection.module` →
  `paragraphs_selection_field_config_presave()` runs on any `entity_reference_revisions` field whose
  handler is `paragraph_reverse`. For each bundle toggled in the drag-drop UI it writes/updates a
  third-party setting **on the paragraphs_type bundle**: `paragraphs_selection.fields` = a list of
  `{id: <field config id>, weight: <n>}`. It then **unsets `target_bundles` and
  `target_bundles_drag_drop`** from the field's `handler_settings` and stores only
  `self_field_id` (= the field config id). So the field itself no longer holds an allowed-bundles
  list — the reverse mapping **replaces** it. `negate === '1'` (the parent handler's allow/exclude
  radio) inverts each bundle's `enabled` flag, turning the placement list into a blocklist.
- **Read-back.** `getSortedAllowedTypes()` ignores the (now absent) field-side list: it loads every
  paragraph bundle, keeps those whose `paragraphs_selection.fields` references this field's
  `self_field_id`, and returns them label/weight-sorted for the add-paragraph widget. Empty
  `self_field_id` falls back to the parent's behaviour.
- **Config schema.** `config/schema/paragraps_selection.schema.yml` (filename is misspelled in the
  module) defines `entity_reference_selection.paragraph_reverse` (`negate:int`, `self_field_id:str`)
  and `paragraphs.paragraphs_type.*.third_party.paragraphs_selection` (`fields` sequence of
  `{id:str, weight:int}`).

## Submodule — paragraphs_selection_paragraphs_sets_support

Bridges the same idea to `paragraphs_sets`. Depends on `paragraphs`, `paragraphs_sets`,
`paragraphs_sets_alter`, `paragraphs_selection`. Adds an **"Availability"** YAML `textarea` to the
Paragraphs Set config form (`hook_form_paragraphs_set_form_alter`) whose entity builder stores a
`paragraphs_selection.selection` third-party setting on the set (expected shape:
`fields: [{name: <field config id>, weight: <n>}]`). A `ServiceProvider` registers an event
subscriber on `ParagraphsSetsAlterEvents::USE_PARAGRAPHS_SET`: for a `paragraph_reverse` field it
marks the set usable only if the set's `selection.fields` lists that field id, and applies the
per-field weight. No schema for the `selection` setting ships in the submodule.

## What it is NOT

- **Not an access control.** It only shapes what the add-paragraph widget offers. It does not block a
  migration, a JSON:API/REST write, or already-stored content from placing a paragraph the rule now
  forbids.
- **Not a modal/visual "add paragraph" picker.** It changes *which* types the existing Paragraphs
  widget lists, not the widget's presentation. No AJAX/dialog routes exist.

## Solution types

- [`config/reverse-selection.md`](config/reverse-selection.md) — enabling the `paragraph_reverse`
  handler on a field, where placement is stored, `negate`, and the Paragraphs Sets submodule config.
