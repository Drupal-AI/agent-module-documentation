<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Fieldsets

Adds a "Global: Fieldset" Views field (id `fieldset`) that wraps and nests other
Views fields inside a `<fieldset>`, `<details>`, or `<div>`. Pure Views-core add-on:
no config UI, no permissions, no Drush, no dependencies beyond Views.

- [Add & configure the Fieldset field](configure/fieldset-field.md) — the `fieldset`
  Views field, its options (wrapper/legend/classes/collapsible/collapsed), tokens,
  nesting, and the Rearrange drag behavior.
- [Extend wrapper types](hooks/wrapper-types.md) — `hook_views_fieldsets_wrapper_types_alter()`.
- [Templates & theme hooks](theming/templates.md) — `views_fieldsets_fieldset` /
  `_details` / `_div`, their Twig templates, and per-view/display/id suggestions.
