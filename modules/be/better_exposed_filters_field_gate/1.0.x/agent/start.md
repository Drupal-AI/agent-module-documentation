<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Exposed Filters Field Gate (better_exposed_filters_field_gate) — agent index

**A Better Exposed Filters widget for taxonomy-term exposed filters that shows only terms whose chosen boolean field is enabled.** Package `Views`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-rc1 (dir 1.0.x).

- **The widget, its config keys, and how the option-filtering works** →
  [plugins/field_gate_widget.md](plugins/field_gate_widget.md)

## What it actually is

- One BEF widget plugin: `FieldGateCheckboxesRadioButtons` (id **`bef_field_gate`**, label *"Checkboxes/Radio Buttons with field gate"*), in `src/Plugin/better_exposed_filters/filter/FieldGateCheckboxesRadioButtons.php`, **extends BEF's `RadioButtons`**.
- `isApplicable()` restricts it to Views `TaxonomyIndexTid` filters only. One hook class `BetterExposedFiltersFieldGateHooks` implements `hook_better_exposed_filters_display_options_alter()` to register the widget in the BEF widget list for those filters.
- Depends on **`better_exposed_filters:better_exposed_filters`** (Composer `^7.0`) and core **`taxonomy`**.
- **No routes, no permissions, no services, no Drush, no global settings page, no install file.** Config lives inside each Views display's BEF settings (schema `better_exposed_filters.filter.bef_field_gate`).

## Mechanism (from source)

- Two config keys: `field_gate_enabled` (bool, default FALSE) and `field_gate_boolean_field` (string field name, default '').
- The config form (`buildConfigurationForm()`) lists the vocabulary's **boolean** term fields (via `entity_field.manager`); `validateConfigurationForm()` requires one when gating is on and checks it is a real boolean field on that vocabulary.
- At render, `exposedFormAlter()` calls `getAllowedTermIds()` — an entity query on `taxonomy_term` with `accessCheck(TRUE)`, `condition('vid', …)` and `condition(<boolean field>, 1)` — then removes non-allowed numeric term-ID options from the exposed form while preserving non-term options (e.g. `- Any -`) via `preserveNonTermOptions()`.

## Scope note

- This is **display-level curation of the option list only**. The underlying Views query, taxonomy access, and node access still govern the actual result rows; the module does not restrict which term IDs a request may submit. The README states this explicitly as a limitation. Not an access-control layer, and there are no public endpoints of its own.
