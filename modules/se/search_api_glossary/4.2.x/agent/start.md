<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API AZ Glossary — agent index

Adds an **A–Z glossary facet** to Search API: a Search API processor derives a first-letter/group
field (`glossaryaz_<field>`) from a text field, and a Facets widget renders the A B C … bar.
Depends on **search_api** + **facets**. No admin settings form of its own, no Drush.

- **The `group_prefix` config object and how to configure glossary end-to-end** →
  [configure/settings.md](configure/settings.md)
- **The Search API processor + Facets widget/processor plugin ids** →
  [plugins/plugins.md](plugins/plugins.md)
- **The `GlossaryHelper` service** → [api/helper.md](api/helper.md)
- **The first-letter alter hook** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Search API processor id **`glossary`**; it exposes hidden computed fields `glossaryaz_<field>`
  (prefix `glossaryaz_`) = uppercased first letter or group of the source value.
- Group labels: `search_api_glossary.settings` → `group_prefix` (`alpha` "A-Z", `numeric` "0-9",
  `special` "#").
- Facets: widget `glossaryaz`; processors `glossaryaz_all_items_processor`,
  `glossaryaz_pad_items_processor`, `glossaryaz_widget_order`.
- Service `search_api_glossary.helper` (`GlossaryHelper::glossaryGetter()`); hook
  `hook_search_api_glossary_source_alter()`.
