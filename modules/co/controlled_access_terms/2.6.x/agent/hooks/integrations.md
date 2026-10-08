<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration hooks: RDF/JSON-LD, Views, Field UI, tokens

Procedural hooks in `controlled_access_terms.module` and `controlled_access_terms.tokens.inc` that
matter to integrators. None require configuration; they fire automatically when the relevant modules
are present.

## RDF / JSON-LD (Islandora linked-data output)

- `hook_rdf_namespaces()` — registers `wgs84_pos`, `org`, `xs` prefixes.
- `hook_jsonld_field_mappings()` — maps the `authority_link` field to `@type: xsd:anyURI`.
- `hook_jsonld_alter_normalized_array()` — post-processes an entity's JSON-LD `@graph`:
  - for each `typed_relation` value, adds the referenced entity's URI under the predicate named by the
    value's `rel_type` (logs a warning if the target is missing/invalid);
  - for each `edtf` value, adds a normalized ISO date (via `EDTFConverter::dateIso8601Value()`) typed
    as `xs:date` / `xs:gYearMonth` / `xs:gYear` depending on precision.

  Requires the `jsonld` module (uses `Drupal\jsonld\Normalizer\NormalizerBase`); it is only invoked by
  jsonld's normalization pipeline, so it is inert without it.

## Views

`hook_field_views_data_views_data_alter()` — for each `typed_relation` field adds a forward
entity-reference relationship and a reverse `entity_reverse` relationship (join from the target term
back to entities referencing it). See [../fields/typed-relation.md](../fields/typed-relation.md).

## Field UI presentation

- `hook_form_field_ui_field_storage_add_form_alter()` — attaches the `controlled_access_terms.icons`
  library (CSS) to the "add field" form.
- `hook_field_info_entity_type_ui_definitions_alter()` — relabels the generic `typed_relation` option
  to "Other" and reorders the typed-relation field options (taxonomy term first, media normalized).

## Islandora tokens (`islandoratokens`)

`controlled_access_terms.tokens.inc` defines a token type `islandoratokens` with node tokens that read
a `field_linked_agent` typed-relation field and a `field_edtf_date_created` EDTF field:

| Token | Returns |
|---|---|
| `[islandoratokens:title]` | Node title |
| `[islandoratokens:agent_author]` | Linked-agent term names with `rel_type == relators:aut` (comma parts flipped) |
| `[islandoratokens:agent_contributor]` | … `rel_type == relators:ctb` |
| `[islandoratokens:agent_publisher]` | … `rel_type == relators:pbl` |
| `[islandoratokens:agent_creators]` | All linked-agent term names (any relation) |
| `[islandoratokens:publication_date]` | `field_edtf_date_created` normalized to `Y/m/d` (falls back to year via `EDTFUtils::iso8601Value`) |

The separator honors `metatag.settings` `separator` (default `,`). These tokens assume the specific
field machine names above (as created by the ArchivesSpace/Islandora workflow), not arbitrary fields.

## Update hooks

`hook_update_8002` migrates legacy `text_edtf` widget / `text_edtf_human` / `text_edtf_iso8601`
displays to `edtf_default`; `hook_update_8003` rewrites stored EDTF strings from the 2012 draft to the
2018 spec. Both run via `drush updatedb`.
