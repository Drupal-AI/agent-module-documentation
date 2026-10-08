<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controlled Access Terms (controlled_access_terms) — agent index

Islandora-ecosystem module for authority/controlled-vocabulary metadata. It ships **three custom
field types** plus their widgets and formatters — an **EDTF** date field (Library of Congress
Extended Date/Time Format), an **Authority Link** field (a link with a "source authority" selector,
e.g. LCNAF/VIAF), and a **Typed Relation** field (an entity reference with a per-value relation type,
e.g. `relators:aut`). It also provides EDTF parsing utilities, Search API index processors, and
RDF/JSON-LD normalization for linked-data output. Version **2.6.0**, core `^10.2 || ^11`.

- **No settings page** (`configure` = null). All configuration is per-field, on the standard Field UI
  storage/field/widget/formatter forms.
- Module dependencies: `geolocation`, `token`. Composer also pulls `professional-wiki/edtf`.
- No permissions, no Drush commands, no hook_menu routes. Defines config **schema** (field/widget/
  formatter settings), not a new plugin type.
- Optional companion submodule **controlled_access_terms_defaults** ships ready-made vocabularies +
  fields — see [modules/controlled_access_terms_defaults/2.6.x](../../modules/controlled_access_terms_defaults/2.6.x/agent/start.md).

## Solution docs

- **Store/enter/display EDTF dates** → [fields/edtf.md](fields/edtf.md)
- **Link a term to an external authority record** → [fields/authority-link.md](fields/authority-link.md)
- **Typed entity references (author, contributor, …)** → [fields/typed-relation.md](fields/typed-relation.md)
- **Validate or convert EDTF strings in code** → [api/edtf-utils.md](api/edtf-utils.md)
- **Index EDTF dates / typed relations in Search API/Solr** → [plugins/search-api-processors.md](plugins/search-api-processors.md)
- **RDF/JSON-LD output, Views relationships, Islandora tokens** → [hooks/integrations.md](hooks/integrations.md)

## Key facts (machine names)

- Field types: `edtf`, `authority_link`, `typed_relation`
- Widgets: `edtf_default`, `authority_link_default`, `typed_relation_default`
- Formatters: `edtf_default`, `authority_formatter_default`, `typed_relation_default`, `typed_relation_dedup`
- Validation constraint: `EDTF` (on the `edtf` field type)
- Utility classes: `Drupal\controlled_access_terms\EDTFUtils`, `EDTFConverter`
- Search API processors: `edtf_date_processor`, `edtf_year_only`, `typed_relation_filtered`
- Token type: `islandoratokens` (`agent_author`, `agent_contributor`, `agent_creators`, `agent_publisher`, `publication_date`, `title`)
- Config schema prefixes: `field.field_settings.authority_link`, `field.field_settings.typed_relation`,
  `field.widget.settings.edtf_default`, `field.formatter.settings.edtf_default`,
  `field.formatter.settings.authority_formatter_default`, etc.
