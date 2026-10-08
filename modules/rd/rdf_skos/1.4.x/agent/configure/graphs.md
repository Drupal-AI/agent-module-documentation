# Configure the SKOS graphs

RDF SKOS has **no global settings page**. Each entity type has its own graph-list form; both
write the same `rdf_skos.graphs` config entity. A graph is a `{name, uri}` pair — `name` is a
Drupal-side machine id, `uri` is the graph IRI in your triple store.

## Prerequisite: the SPARQL connection

The endpoint is NOT set here. It is the `sparql_default` database connection provided by
`sparql_entity_storage`, declared in `settings.php`, e.g.:

    $databases['sparql_default']['sparql'] = [
      'prefix' => '',
      'host' => 'virtuoso',
      'port' => '8890',
      'namespace' => 'Drupal\\sparql_entity_storage\\Driver\\Database\\sparql',
      'driver' => 'sparql',
    ];

This host/port is trusted server config. rdf_skos performs no HTTP itself; `sparql_entity_storage`
does all SPARQL transport. Without this connection Drupal will not bootstrap once the module is on.

## Forms / routes

| Entity type | Route | Path | Form class |
|---|---|---|---|
| `skos_concept_scheme` | `skos_concept_scheme.settings` | `/admin/structure/skos_concept_scheme/settings` | `Form\ConceptSchemeSettingsForm` |
| `skos_concept` | `skos_concept.settings` | `/admin/structure/skos_concept/settings` | `Form\ConceptSettingsForm` |

Both extend `Form\SkosEntitySettingsForm` and require the entity type's admin permission
(`administer skos concept scheme entities` / `administer skos concept entities`, both
`restrict access: true`). The single textarea takes one graph per line as `name|uri`, e.g.
`eurovoc|http://publications.europa.eu/resource/dataset/eurovoc`.

## Config object

`rdf_skos.graphs` (config entity; schema `rdf_skos.schema.yml` → `rdf_skos.graphs`):

    entity_types:
      skos_concept_scheme:
        - { name: eurovoc, uri: 'http://publications.europa.eu/resource/dataset/eurovoc' }
      skos_concept:
        - { name: eurovoc, uri: 'http://publications.europa.eu/resource/dataset/eurovoc' }

Ships empty (`config/install/rdf_skos.graphs.yml`). If a type has no graphs, `RdfSkosGraphHandler`
injects a placeholder "nonexistent" graph so SPARQL does not scan every graph in the store.
Constraint (README): entity IRIs must be **unique across all** configured graphs, because all
graphs are passed to the load methods.

## Set it in code / drush

Direct config (each row needs both `name` and `uri`):

    \Drupal::configFactory()->getEditable('rdf_skos.graphs')
      ->set('entity_types.skos_concept', [['name' => 'eurovoc', 'uri' => 'http://…/eurovoc']])
      ->set('entity_types.skos_concept_scheme', [['name' => 'eurovoc', 'uri' => 'http://…/eurovoc']])
      ->save();

Or the helper service, which adds the same graphs to **both** entity types and de-duplicates:

    // rdf_skos.skos_graph_configurator — SkosGraphConfiguratorInterface::addGraphs()
    // $graphs is keyed name => uri.
    \Drupal::service('rdf_skos.skos_graph_configurator')
      ->addGraphs(['eurovoc' => 'http://publications.europa.eu/resource/dataset/eurovoc']);

Either works via `drush php:eval '…'`. Run `drush cr` after changing graphs.
