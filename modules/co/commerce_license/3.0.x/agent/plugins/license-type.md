# License type plugins (CommerceLicenseType)

A **License type** decides *what a license grants* and is the **bundle** of the
`commerce_license` entity (the entity declares `bundle_plugin_type = "commerce_license_type"`).

- Manager service: `plugin.manager.commerce_license_type`
  (`\Drupal\commerce_license\LicenseTypeManager`, a `FallbackPluginManagerInterface`).
- Directory: `src/Plugin/Commerce/LicenseType/`. Annotation:
  `@CommerceLicenseType`. Interface: `LicenseTypeInterface`. Base: `LicenseTypeBase`.
- Registered as a plugin type in `commerce_license.plugin_type.yml`
  (`commerce_license.license_type`).

## Built-in: `role`

`Plugin/Commerce/LicenseType/Role.php` (`id = "role"`) grants a Drupal role while the license
is active:

- Adds a bundle field `license_role` (entity_reference to `user_role`) and a config value
  `license_role`.
- `grantLicense($license)` adds `$license->license_role->target_id` to the owner's roles;
  `revokeLicense($license)` removes it.
- On the user form the granted role is shown checked-and-disabled (can't be removed manually).

So a role-type license entity carries `type = role`, a `license_role` reference, a `state`,
and a `uid` (owner).

## Interfaces a license type can implement

- `ExistingRightsFromConfigurationCheckingInterface` — declare when the user already has the
  granted right (prevents pointless purchase; see `LicenseAvailabilityCheckerExistingRights`).
- `GrantedEntityLockingInterface` — lock the granted entity (e.g. the role) from manual edit.
- `LicenseTypeSynchronizableInterface` — for licenses that provision a remote/local resource.

## Implement one

```php
namespace Drupal\my_module\Plugin\Commerce\LicenseType;

use Drupal\commerce_license\Plugin\Commerce\LicenseType\LicenseTypeBase;
use Drupal\commerce_license\Entity\LicenseInterface;

/**
 * @CommerceLicenseType(
 *   id = "widget_access",
 *   label = @Translation("Widget access"),
 * )
 */
class WidgetAccess extends LicenseTypeBase {
  public function grantLicense(LicenseInterface $license) { /* grant access */ }
  public function revokeLicense(LicenseInterface $license) { /* revoke access */ }
  public function buildLabel(LicenseInterface $license) { return $this->t('Widget access'); }
  // Optionally buildFieldDefinitions() for per-bundle fields, and the config form methods.
}
```

Clearing caches makes the new bundle appear; add fields at
`/admin/commerce/config/licenses/license-types/{bundle}`. Alter the plugin list with
`hook_commerce_license_type_info_alter()`.
