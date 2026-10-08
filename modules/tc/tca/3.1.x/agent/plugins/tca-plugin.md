# The `tca_plugin` plugin type

TCA discovers which entity types it protects via `TcaPlugin` plugins. The base module ships
none; each supported entity type is one plugin (see `tca_node`, `tca_commerce_product`).

## Anatomy
- **Manager:** `plugin.manager.tca_plugin` (`\Drupal\tca\Plugin\TcaPluginManager`, a
  default_plugin_manager). Discovers classes in `Plugin/TcaPlugin/` of any module.
- **Attribute:** `\Drupal\tca\Attribute\TcaPlugin(id, label, entityType, deriver?)`
  (legacy annotation `\Drupal\tca\Annotation\TcaPlugin` also exists).
- **Base class:** `\Drupal\tca\Plugin\TcaPluginBase` implements `TcaPluginInterface`.

## Minimal plugin
```php
namespace Drupal\my_module\Plugin\TcaPlugin;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\tca\Attribute\TcaPlugin;
use Drupal\tca\Plugin\TcaPluginBase;

#[TcaPlugin(
  id: 'tca_my_entity',
  label: new TranslatableMarkup('My entity'),
  entityType: 'my_entity',
)]
class MyEntity extends TcaPluginBase {

  public function isFieldable() {
    // TRUE → TCA installs tca_active/tca_public/tca_token base fields on the entity
    // and stores settings per-entity. FALSE → settings are config-only.
    return TRUE;
  }
}
```

## Interface methods you can override
- `isFieldable(): bool` — whether to attach the three base fields (default FALSE in base).
- `getFormSubmitHandlerAttachLocations(): array` — where in the entity form to attach the TCA
  submit handler (default `[['actions','submit','#submit']]`).
- `getBundleFormSubmitHandlerAttachLocations(): array` — same for the bundle form (add e.g.
  `['actions','save_continue','#submit']` if the bundle form has extra submit buttons).
- `getEntityTokenMap(): array` — maps the entity type (and its bundle entity type) ids;
  provided by the base class.
- `setEntityTypeManager()` — the manager injects the ETM after instantiation.

## What enabling a plugin does
- Its `entityType` joins `loadSupportedEntityTypes()` so `hook_form_alter`/`hook_entity_access`
  act on it.
- If `isFieldable()`, `hook_modules_installed()`/`hook_entity_base_field_info()` install the
  `tca_active`, `tca_public`, `tca_token` base fields for that entity type.
- The permission generator emits `tca administer <entityType>` and `tca bypass <entityType>`.
