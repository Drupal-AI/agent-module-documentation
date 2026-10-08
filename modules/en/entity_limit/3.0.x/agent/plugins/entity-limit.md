# The `entity_limit` plugin type

Limit conditions are plugins, so you can add a new way to decide a user's cap (e.g. per group, per time
window) without touching core enforcement.

- Manager service: `plugin.manager.entity_limit` (`EntityLimitPluginManager`), namespace
  `Plugin/EntityLimit`, annotation `@EntityLimit`, interface `EntityLimitPluginInterface`, alter hook
  `hook_entity_limit_info_alter()`, cache key `entity_limit_info_plugins`.
- Annotation fields (`src/Annotation/EntityLimit.php`): `id`, `title` (Translation), `priority` (int —
  lower number can be considered first when weights tie; `user_limit` = 0, `role_limit` = 1).

## Interface to implement

`Drupal\entity_limit\Plugin\EntityLimitPluginInterface` (extends `PluginFormInterface`,
`PluginInspectionInterface`). Extend `EntityLimitPluginBase` and implement:

| Method | Purpose |
|---|---|
| `buildConfigurationForm()` / `validateConfigurationForm()` / `submitConfigurationForm()` | The "Manage Limits" form rows (from `PluginFormInterface`). |
| `getLimitCount(EntityLimit $entityLimit)` | Return the numeric limit that applies to the current account for this config (`-1` = unlimited). |
| `checkAccess($limit, EntityLimit $entityLimit)` | Return TRUE (allow) / FALSE (deny) by comparing `$limit` to the account's current usage. |

`EntityLimitPluginBase` provides `getLabel()` (from `title`), `getPriority()` (from `priority`), and a
no-op `calculateDependencies()`.

## Skeleton

```php
namespace Drupal\my_module\Plugin\EntityLimit;

use Drupal\Core\Form\FormStateInterface;
use Drupal\entity_limit\Entity\EntityLimit;
use Drupal\entity_limit\Plugin\EntityLimitPluginBase;

/**
 * @EntityLimit(
 *   id = "group_limit",
 *   title = @Translation("Group Limit"),
 *   priority = 2,
 * )
 */
class GroupLimit extends EntityLimitPluginBase {

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    // Build a table of {id => limit} rows like RoleLimit/UserLimit do
    // ($form['#entity_limit'] holds the config entity; store rows under 'limits').
    return $form;
  }
  public function validateConfigurationForm(array &$form, FormStateInterface $form_state) {}
  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {}

  public function getLimitCount(EntityLimit $entityLimit) {
    // Resolve the applicable cap for the current account; return -1 for unlimited.
    return 0;
  }

  public function checkAccess($limit, EntityLimit $entityLimit) {
    // Count the account's existing entities of $entityLimit's type/bundles and
    // return $count < (int) $limit.
    return TRUE;
  }
}
```

## Reference implementations

- `src/Plugin/EntityLimit/RoleLimit.php` — role→limit table; `getLimitCount()` returns the highest limit
  across the account's roles; `checkAccess()` counts owned entities of the configured bundles.
- `src/Plugin/EntityLimit/UserLimit.php` — user→limit via `entity_autocomplete`; same counting logic keyed
  on the user id.

Both add per-row Add/Remove AJAX buttons and store rows as `limits[] = {id, limit}` on the config entity;
the config schema key is derived from the plugin id (`entity_limit.limits.[%parent.plugin]`).
