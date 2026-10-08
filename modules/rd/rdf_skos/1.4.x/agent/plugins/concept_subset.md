# ConceptSubset plugin type

Lets you (a) restrict which concepts a `skos_concept_entity_reference` field offers and/or
(b) map extra RDF predicates onto new base fields of `skos_concept`.

- Manager service: `plugin.manager.concept_subset` (`ConceptSubsetPluginManager`, extends `DefaultPluginManager`).
- Interface: `Drupal\rdf_skos\ConceptSubsetInterface`; base class `ConceptSubsetPluginBase`.
- Annotation: `@ConceptSubset` (`src/Annotation/ConceptSubset.php`).
- Discovery dir: `Plugin/ConceptSubset`. Alter hook: `hook_concept_subset_info_alter()`.

## Annotation properties
| Key | Meaning |
|---|---|
| `id` | Plugin id |
| `label` (title) | Human label shown in the field's selection settings |
| `description` | Optional description |
| `concept_schemes` | Optional array of scheme IRIs the plugin applies to; empty/absent = all |
| `predicate_mapping` | Optional bool; TRUE means the plugin also implements `PredicateMapperInterface` |

## Minimal subset plugin

    namespace Drupal\my_module\Plugin\ConceptSubset;

    use Drupal\Core\Entity\Query\QueryInterface;
    use Drupal\rdf_skos\ConceptSubsetPluginBase;

    /**
     * @ConceptSubset(
     *   id = "my_subset",
     *   label = @Translation("My subset"),
     *   concept_schemes = {}
     * )
     */
    class MySubset extends ConceptSubsetPluginBase {

      public function alterQuery(QueryInterface $query, $match_operator, array $concept_schemes = [], ?string $match = NULL): void {
        // Add conditions to the concept-selection query.
        $query->condition('top_concept_of', $concept_schemes, 'IN');
      }

    }

The chosen subset is stored on the field's selection-handler settings (`concept_subset`) and
applied by `SkosConceptSelection::applyConceptSubset()` when building the reference query.
`ConceptSubsetPluginManager::getApplicableDefinitions()` offers only subsets valid for the
selected schemes (intersection across schemes).

## Predicate-mapper subset (`predicate_mapping = TRUE`)

Also implement `Drupal\rdf_skos\Plugin\PredicateMapperInterface`:
- `getPredicateMapping()` — return `field_name => {column, predicate: [IRIs], format}` rows,
  merged into the concept mapping in `RdfSkosFieldHandler::getSkosPredicateMappings()`.
- `getBaseFieldDefinitions()` — return `BaseFieldDefinition`s, added to `skos_concept` via
  `hook_entity_base_field_info()`.

`format` is `SparqlEntityStorageFieldHandlerInterface::TRANSLATABLE_LITERAL` (literal text) or
`::RESOURCE` (an IRI, hydrated as an entity_reference). `getPredicateMappingDefinitions()` returns
the plugins with `predicate_mapping = TRUE`.
