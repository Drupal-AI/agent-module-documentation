<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Custom Label is a Facets processor that renames facet items, mapping an item's raw value (machine name / entity ID) or its display value (title / term name) to a custom label you supply.

---

The module adds one Facets **build-stage processor** plugin (`facets_custom_label`) with a single textarea setting, `replacement_values`. Each line of that textarea is `origin|value|new label`, where `origin` is `r` (match the item's *raw* value — a machine name, node/term ID, etc.) or `d` (match the item's *display* value — a content title or term name). At the processor's `build` stage (weight 50) it parses the mapping into raw-keyed and display-keyed lookups, then for each facet result replaces the display value via `Result::setDisplayValue()` when the raw value or the current display value matches. It changes only what the visitor sees on the facet block; the underlying query, raw values and result counts are untouched. There is no admin settings page for the module itself — you enable and configure the processor on an individual facet under the facet's *Processors* / edit form. For translated labels, enable core **Configuration Translation** and translate the facet configuration. The processor does not currently support display values that themselves contain the `|` pipe separator.

---

- Rename a content-type facet item from the machine name `article` to a friendly `Awesome news`.
- Relabel a taxonomy-term facet by term name, e.g. `Apple` → `Apple products`.
- Replace an entity-ID facet value (e.g. a node/term ID) with a human-readable label.
- Give boolean/status facet values friendlier text (e.g. `1` → `Published`).
- Localise facet labels by combining the processor with Configuration Translation.
- Present marketing-friendly wording on facets without changing the source data.
- Map several raw values to nicer labels in one textarea, one mapping per line.
- Fix an unclear taxonomy term display just in the facet, not the term itself.
- Relabel a language-code facet (`en` → `English`, `fr` → `Français`).
- Turn a cryptic supplier code facet into a readable brand name.
- Rename a field-value facet like `in_stock` to `Available now`.
- Override a facet item's label by its display value when you don't know the raw value.
- Keep raw values and counts intact while showing custom labels to visitors.
- Apply consistent capitalisation/wording to facet items across a search page.
- Relabel a format facet (`pdf` → `PDF document`) in a document library search.
- Provide clearer wording for accessibility on faceted search UIs.
- Rename ambiguous status values in an e-commerce product facet.
- Adjust a country/region facet's labels for a specific audience.
- Change one facet item's wording without editing the referenced entity.
- Give a date-range or bucket facet a plain-English label.
- Standardise facet labels between environments via exported facet config.
- Relabel migrated legacy values that still carry old machine names.
- Show branded category names in facets while keeping neutral machine names in config.
