<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `drd_pi_auth` plugin type (provider-infrastructure auth)

DRD Agent defines one plugin type so DRD can authenticate against a hosting provider's
infrastructure when reaching sites there.

- **Manager:** `plugin.manager.drd_pi_auth` (`Drupal\drd_agent\DrdPiAuthManager`).
- **Discovery:** classes in `Plugin/DrdPiAuth/`, annotation `@DrdPiAuth`
  (`Drupal\drd_agent\Annotation\DrdPiAuth`), interface `DrdPiAuthInterface`.
- **Alter hook:** `hook_drd_agent_drd_pi_auth_info_alter()`; cache key `drd_agent_drd_pi_auth_plugins`.

## Shipped plugins

| id | Provider |
|---|---|
| `acquia` | Acquia Cloud |
| `pantheon` | Pantheon |
| `platformsh` | Platform.sh |

List them live:
`\Drupal::service('plugin.manager.drd_pi_auth')->getDefinitions()`.

## Implementing one

```php
namespace Drupal\my_module\Plugin\DrdPiAuth;

use Drupal\drd_agent\Plugin\DrdPiAuth\DrdPiAuthBase;

/**
 * @DrdPiAuth(
 *   id = "my_provider"
 * )
 */
class MyProvider extends DrdPiAuthBase {
  // Implement DrdPiAuthInterface: authenticate against the provider's API/infra.
}
```
