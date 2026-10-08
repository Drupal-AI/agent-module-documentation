<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Custom Order (facets_custom_order) — agent index

Adds a single **Facets sort processor** that orders a facet's values into a **site-defined
sequence** typed line-by-line into the facet's config form, instead of alphabetically or by
result count. Requires `facets`. Version **1.0.0**. Core `^8 || ^9 || ^10 || ^11`. GPL-2.0-or-later.

## What it actually ships
One plugin, no hooks, no permissions, no services, no routes, no theme, no submodules:
- `src/Plugin/facets/processor/CustomWidgetOrderProcessor.php` — `@FacetsProcessor` id
  **`custom_widget_order`**, label "Sort by custom order", registered on the **`sort` stage at
  weight 40** (`SortProcessorPluginBase` implements `SortProcessorInterface`).
- `config/schema/facets_custom_order.processor.schema.yml` — config schema for the processor
  settings (`custom_order` string, `display_values` boolean, plus an unused `sort` key).

## Mechanism (read the processor doc for detail)
- **Config form** (`buildConfigurationForm`) offers two settings on the facet's "Facet settings"
  page (Processors / sorting): a `custom_order` **textarea** ("one item per line") and a
  `display_values` **checkbox**.
- **Applied** in `sortResults(Result $a, Result $b)`: the textarea is `explode`d on `PHP_EOL`,
  each line `trim`med, then `array_flip`ped so **line position becomes a rank**. Each result's key
  is its **display value** if `display_values` is on, otherwise its **raw value**. The comparison
  is `($order[$a] ?? $count) <=> ($order[$b] ?? $count)`.
- **Values not listed** fall through to `$count` (the number of listed lines) — i.e. they all tie
  at the end, so unlisted values land after the ordered ones **in the input order** (the module's
  own description says "random"; in practice they keep the sort's prior order). A term added to the
  vocabulary after the order was written therefore silently drops to the tail.

## Why the built-in sorts are wrong for ordered values
- **by label** — a size facet reads L, M, S, XL; a price band reads "£0–50, £100–200, £50–100".
- **by count** — worse: the order **changes as content changes**, so a visitor who filters and
  returns finds the options rearranged.

## Configure
Structure → Facets → edit a facet → **Facet settings**, tick **"Sort by custom order"**, fill in
the order (one value per line), decide display-vs-raw. There is no module settings page
(`configure: null`); gating is Facets' own `administer facets` permission.

## Gotchas
- **Enter values, not just labels, unless you tick "Use display values".** Raw values (taxonomy
  term IDs, aggregated index strings) are often not what the admin sees rendered.
- **The `sort` (ASC/DESC) schema key is dead.** It appears in the schema but the form never builds
  it and `sortResults` never reads it — you cannot reverse the sequence from this processor; write
  the lines in the order you want.
- **Combine with a single active sort.** As a sort-stage processor it competes with other enabled
  sort processors by stage weight (40); enabling two orderings gives undefined results.

See `agent/processors/custom_widget_order.md` for the full plugin walkthrough.
