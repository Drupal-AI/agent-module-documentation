<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API AZ Glossary — plugins

The module **implements** plugins for Search API and Facets (it does not define new plugin *types*).

## Search API processor

| id | class | role |
|---|---|---|
| `glossary` | `Plugin/search_api/processor/Glossary` | For each field flagged "glossary" in the processor config, exposes a hidden computed property **`glossaryaz_<field>`** (type `string`) = first letter / group of the source value. |

- Stages: `add_properties` (99), `pre_index_save` (0), `preprocess_index` (-20).
- Target field prefix: `glossaryaz_` (see `makeFieldName()`).
- `getPropertyDefinitions()` reads the processor's own config (which fields have `glossary => 1` and
  their `grouping`), and `addFieldValues()` calls `search_api_glossary.helper->glossaryGetter($value,
  $grouping)` to compute the letter/group, storing it on the `glossaryaz_<field>` field.
- Enabled per index; config lives in `search_api.index.<id>` → `processor_settings.glossary`.

## Facets widget

| id | class | label |
|---|---|---|
| `glossaryaz` | `Plugin/facets/widget/GlossaryAZWidget` | "Glossary AZ" — renders the A–Z bar for a facet built on a `glossaryaz_*` field. |

## Facets processors

| id | class | label / effect |
|---|---|---|
| `glossaryaz_all_items_processor` | `Plugin/facets/processor/GlossaryAZAllItemsProcessor` | "All items in Glossary AZ" — show every A–Z item even with no results. |
| `glossaryaz_pad_items_processor` | `Plugin/facets/processor/GlossaryAZPadItemsProcessor` | "Add missing items to Glossary AZ" — pad the bar with absent letters. |
| `glossaryaz_widget_order` | `Plugin/facets/processor/GlossaryAZWidgetOrderProcessor` | "Sort by Glossary AZ" — order items A–Z. |

Enable the widget + processors on a Facet (config entity `facets.facet.<id>`) whose field is the
index's `glossaryaz_<field>`.
