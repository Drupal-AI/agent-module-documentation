<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Custom Label — agent index

Adds one Facets **build-stage processor**, `facets_custom_label`, that relabels facet items by
their raw value or display value. One setting: a `replacement_values` textarea of
`origin|value|new label` lines. No configure route, no permissions, no Drush, no services.
Requires the **Facets** module; state lives inside a facet config entity's `processor_configs`.

- **Enable the processor on a facet + the mapping syntax + where it is stored** →
  [configure/mapping.md](configure/mapping.md)
- **The processor plugin (id, stage/weight, how it rewrites results)** →
  [plugins/processor.md](plugins/processor.md)

Key facts:
- Mapping line = `origin|value|new label`. `origin` is `r` (match raw value: machine name /
  entity id) or `d` (match display value: title / term name).
- Stored at `facets.facet.<id>` → `processor_configs.facets_custom_label.settings.replacement_values`.
- It only rewrites the visible display value (`Result::setDisplayValue()`); raw values, the
  query, and counts are unchanged. Display values containing `|` are not supported.
