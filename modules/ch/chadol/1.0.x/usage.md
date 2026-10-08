Chado Light exposes tables of a Chado PostgreSQL schema (a standard schema for biological/genomics data) as Drupal External Entities through a point-and-click SQL storage client, with no data synchronization.

---

Chado Light (`chadol`) ships one External Entities storage client plugin, `xnttchado` (class `Chado`, extending the `xnttsql` `Database` client), that connects to a Chado schema in any PostgreSQL connection registered in `settings.php`, introspects its tables via the `dbxschema` cross-schema API, and generates the SELECT/LIST/COUNT SQL an external entity type needs. When you configure an external entity type with this client you pick a Chado database instance, then a data type (by Chado `type_id` cvterm, or by raw table), and the plugin auto-maps id/uuid/title plus the columns you include; it can also add joins to related Chado tables (properties, controlled vocabulary terms, cross-references, publications, relationships, and foreign-key tables) and rich per-field filters. An admin page at `/chadolight/admin` lists detected Chado instances and lets you create built-in content types (db, dbxref, cv, cvterm, pub, organism) in one click. A JSON autocomplete endpoint backs the term/organism pickers used in the configuration forms. All access is read-oriented; create/update/delete queries are intentionally left empty.

---

- Serve a Chado `feature` table (genes, mRNA, markers, etc.) as a browsable Drupal entity type without writing SQL.
- Expose Chado `organism` records as Drupal content for site navigation and reference.
- Publish controlled vocabularies (`cv`) and their terms (`cvterm`) as external entities.
- Surface Chado cross-references (`dbxref`) and source databases (`db`) as linkable content.
- Present Chado publications (`pub`) as Drupal entities for bibliography pages.
- Map a Chado table selected by a specific `type_id` cvterm so one Drupal type = one biological data type.
- Map a Chado table wholesale (all rows of a table) when a single cvterm type does not apply.
- Auto-generate id, uuid (from `uniquename` when present) and title (from `name` when present) mappings for a Chado table.
- Include selected scalar columns (text, numeric, boolean, datetime) as Drupal fields with sensible widgets/formatters.
- Attach a table's property records (`*prop`) as aggregated JSON/array fields on the entity.
- Attach a table's controlled-vocabulary annotations (`*_cvterm`) as related fields.
- Attach a table's cross-references (`*_dbxref`), building clickable URLs from `db.urlprefix || dbxref.accession`.
- Attach a table's publications (`*_pub`) as related fields.
- Attach a table's relationships (`*_relationship`) treating the entity as subject, object, or either.
- Follow foreign-key tables (1-to-many and many-to-many link tables such as `featureloc`) as joins.
- Filter mapped content by text (contains, starts/ends with, regex, word matching, length), numeric ranges, booleans, and dates (absolute or relative offset).
- Filter by controlled-vocabulary term: whole CV, a term category (is_a descendants), or an explicit term list.
- Filter organisms by phylogenetic tree, by descendants of a tree node, or by genus/species text.
- Restrict a Chado content type to only rows that have related data for a required join.
- Combine Chado-backed fields with non-Chado fields via External Entities data aggregators.
- Serve Chado data to a BrAPI endpoint (via the BrAPI module) built on these external entities.
- Connect to a remote Chado database by adding its credentials to the `$databases` array in `settings.php`.
- Work with multiple Chado schemas/instances across multiple PostgreSQL connections on one site.
- Autocomplete cvterms and phylonodes when building filters in the entity-type configuration UI.
- List all detected Chado instances (with version and data size) from the admin overview page.
- One-click create the six built-in Chado content types for a detected instance.
