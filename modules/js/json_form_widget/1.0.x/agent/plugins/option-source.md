# JSON Form Widget — `json_form_option_source` plugin type

Supplies dynamic option lists (enum values) to schema-driven form elements — e.g. populate a
dropdown from a taxonomy, an entity query, or an external API instead of a hardcoded schema enum.

## Plugin type wiring

- Manager service: `plugin.manager.json_form_option_source` → `OptionSource\JsonFormOptionSourcePluginManager`
  (subdir `Plugin/JsonFormOptionSource`, interface `JsonFormOptionSourceInterface`, annotation
  `Annotation\JsonFormOptionSource`, alter hook `json_form_option_source_info`, cache key
  `json_form_option_source_plugins`).
- Annotation `@JsonFormOptionSource`: `id`, `title`, `description`.
- Base class: `OptionSource\JsonFormOptionSourcePluginBase`.
- Consumed by `WidgetRouter` (service `json_form.widget_router`), which is injected with the manager
  to resolve option sources referenced from the schema/ui.

## Interface (`JsonFormOptionSourceInterface`)

```php
public function label(): string;
public function getOptions(array $config): array;      // ['value' => 'Title', ...]
public function getTargetType(array $config): string;  // e.g. 'taxonomy_term' (for autocreate)
public function validateConfig(array $config): bool;   // true, or throw on invalid config
```

## Example: `TaxonomySource` (`Plugin/JsonFormOptionSource/TaxonomySource.php`)

```php
#[/* annotation */]
/**
 * @JsonFormOptionSource(
 *   id = "taxonomy",
 *   label = @Translation("Drupal Taxonomy"),
 *   description = @Translation("Get JSON options from a Drupal taxonomy.")
 * )
 */
class TaxonomySource extends JsonFormOptionSourcePluginBase implements ContainerFactoryPluginInterface {
  public function getOptions(array $config): array {
    $this->validateConfig($config);                    // requires $config['vocabulary'] (string)
    $terms = $this->entityTypeManager->getStorage('taxonomy_term')->loadTree($config['vocabulary']);
    $options = [];
    foreach ($terms as $term) { $options[$term->name] = $term->name; }
    return $options;
  }
  public function getTargetType(array $config): string { return 'taxonomy_term'; }
}
```

Injects `entity_type.manager` via `create()`. Throws `InvalidArgumentException` when `vocabulary`
is missing/non-string.

## Implementing your own

1. Put the class in `MyModule\Plugin\JsonFormOptionSource`.
2. Add the `@JsonFormOptionSource(id, label, description)` annotation.
3. Extend `JsonFormOptionSourcePluginBase`, implement `getOptions()`/`getTargetType()`/`validateConfig()`.
4. Reference the source `id` (with its config) from your JSON schema/ui so `WidgetRouter` picks it up.
