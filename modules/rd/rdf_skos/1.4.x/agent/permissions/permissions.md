# Permissions

Defined in `rdf_skos.permissions.yml`. Both entity types are **read-only**: the access handlers
(`ConceptSchemeAccessControlHandler`, `ConceptAccessControlHandler`) forbid create, update and
delete for everyone and only grant the `view` operation.

| Permission | Grants | restrict access |
|---|---|---|
| `view published skos concept scheme entities` | View concept schemes (canonical + collection) | — |
| `administer skos concept scheme entities` | Concept-scheme graph settings form; also satisfies `view` | yes |
| `view published skos concept entities` | View concepts | — |
| `administer skos concept entities` | Concept graph settings form; also satisfies `view` | yes |

`view` is granted when the user holds the matching `view published …` **OR** `administer …`
permission (checked with `OR`). The two `administer …` permissions are the entity
`admin_permission` and gate the graph settings routes.

## Submodule

`rdf_skos_language_mapping` adds one permission, `administer rdf skos language mapping`, gating the
language-mapping form at `/admin/config/sparql/language-mapping`.
