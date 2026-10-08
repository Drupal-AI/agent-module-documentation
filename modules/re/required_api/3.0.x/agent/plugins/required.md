# Implement a Required strategy plugin

A strategy decides whether a given field is required for a given entity, and optionally adds a
config UI to the field settings form.

- **Namespace/dir:** `Drupal\<module>\Plugin\Required` → `src/Plugin/Required/`.
- **Attribute:** `#[\Drupal\required_api\Attribute\Required(id, label, description)]` (legacy
  `@Required` annotation also discovered).
- **Interface:** `RequiredPluginInterface` (extends `ConfigurableInterface`,
  `ContainerFactoryPluginInterface`); extend `RequiredBase` for the boilerplate.

## Methods

| Method | Contract |
|---|---|
| `isRequired(FieldDefinitionInterface $field, ContentEntityInterface $entity): bool` | the decision; called at form build and in the error handler. |
| `requiredFormElement(FieldDefinitionInterface $field): array` | render array for the field-settings config UI (wrapped by `RequiredBase::formElement()` into the `required_plugin_options` parents + AJAX wrapper). Return `[]` if none. |
| `submitFieldConfigForm(array &$form, FormStateInterface $form_state): void` | optional; runs as the first submit handler on the field settings form. |
| `defaultConfiguration()` / `getConfiguration()` / `setConfiguration()` | from `ConfigurableInterface`; `RequiredBase` provides defaults. |

## Example

```php
namespace Drupal\my_module\Plugin\Required;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\Core\Field\FieldDefinitionInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\required_api\Attribute\Required;
use Drupal\required_api\Plugin\Required\RequiredBase;

#[Required(
  id: 'authenticated_only',
  label: new TranslatableMarkup('Required for authenticated users'),
)]
class RequiredForAuthenticated extends RequiredBase {

  public function isRequired(FieldDefinitionInterface $field, ContentEntityInterface $entity): bool {
    return \Drupal::currentUser()->isAuthenticated();
  }

  public function requiredFormElement(FieldDefinitionInterface $field): array {
    return []; // no per-field options
  }
}
```

## Notes

- If you inject services, override `create()` (base uses the 3-arg `PluginBase` constructor).
- Persisted per-field options schema key: `required_api.plugin_options.<plugin_id>` (define it
  in your `config/schema` if `requiredFormElement()` stores values).
- Any strategy other than `default` makes the field `required = TRUE` at save
  (`hook_field_config_presave`); your `isRequired()` is what actually relaxes it at runtime.
- Return type must be a real `bool`. Missing plugins resolve to `Broken` (`isRequired()` →
  `TRUE`, i.e. always required) and are logged.
