# Entity Embed Display plugins

The module **defines** the `EntityEmbedDisplay` plugin type. A display plugin turns an
embedded entity into a render array; the editor picks one per embed and it becomes the
`data-entity-embed-display` value.

- Plugin namespace: `Plugin/entity_embed/EntityEmbedDisplay`
- Annotation: `@EntityEmbedDisplay` (`Drupal\entity_embed\Annotation\EntityEmbedDisplay`)
- Base class: `EntityEmbedDisplayBase` (or `FieldFormatterEntityEmbedDisplayBase` to wrap a
  field formatter)
- Manager: `plugin.manager.entity_embed.display`
- Interface: `EntityEmbedDisplayInterface`

Built-in plugins (examples to copy): `EntityReferenceFieldFormatter` (view-mode rendering,
derived per view mode as `view_mode:<entity_type>.<view_mode>`), `ImageFieldFormatter`,
`FileFieldFormatter`, `ViewModeFieldFormatter`, `MediaImageDecorator`.

## Skeleton
```php
namespace Drupal\my_module\Plugin\entity_embed\EntityEmbedDisplay;

use Drupal\entity_embed\EntityEmbedDisplay\EntityEmbedDisplayBase;

/**
 * @EntityEmbedDisplay(
 *   id = "my_display",
 *   label = @Translation("My display"),
 *   entity_types = {"node", "media"},   // or FALSE for all types
 * )
 */
class MyDisplay extends EntityEmbedDisplayBase {

  public function access(?\Drupal\Core\Session\AccountInterface $account = NULL) {
    // Return AccessResult; getEntityFromContext() gives the embedded entity.
    return parent::access($account);
  }

  public function build() {
    $entity = $this->getEntityFromContext();
    return ['#markup' => $entity->label()];
  }

  // Optional: buildConfigurationForm() to expose settings in the embed dialog.
}
```
Key methods: `getEntityFromContext()`, `getAttributeValues()`, `getContextValue()`,
`buildConfigurationForm()/validate/submit`. `entity_types` scopes which entities may use it;
`no_ui = TRUE` hides it from the dialog. Restrict availability further with the context alter
hook — see [../hooks/hooks.md](../hooks/hooks.md).
