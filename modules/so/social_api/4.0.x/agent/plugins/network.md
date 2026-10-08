<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Network` plugin type

## Discovery

| | |
|---|---|
| Directory in your module | `src/Plugin/Network/` |
| Interface | `Drupal\social_api\Plugin\NetworkInterface` |
| Annotation class | `Drupal\social_api\Annotation\Network` |
| Manager service | `plugin.network.manager` |
| Alter hook | `hook_social_api_network_info_alter(array &$definitions)` |
| Discovery cache key | `social_api_network_plugins` (bin `cache.discovery`) |

`NetworkInterface` extends `PluginInspectionInterface` and
`ContainerFactoryPluginInterface` and declares exactly one method: `getSdk(): mixed`.

## Annotation keys

```php
/**
 * @Network(
 *   id = "social_auth_acme",
 *   socialNetwork = @Translation("Acme"),
 *   type = "social_auth",
 *   className = "\League\OAuth2\Client\Provider\GenericProvider",
 *   handlers = {
 *     "settings": {
 *       "class": "\Drupal\social_auth_acme\Settings\AcmeAuthSettings",
 *       "config_id": "social_auth_acme.settings"
 *     }
 *   }
 * )
 */
```

| key | type | meaning |
|---|---|---|
| `id` | string | plugin id; by convention the implementer module's machine name |
| `socialNetwork` | Translation/string | human name of the service |
| `type` | string | integration family — `social_auth`, `social_post` or `social_widgets` |
| `className` | string | fully qualified class name of the SDK/provider the plugin wraps |
| `handlers` | array | extra handlers; only `settings` (`class` + `config_id`) is consumed by `NetworkBase` |

> Gotcha: the property is `socialNetwork`, so the definition array key is `socialNetwork`.
> `SocialApiController::integrations()` reads `$network['social_network']` (snake case),
> which does not match — the "Social Network" column of that table renders empty unless an
> alter hook adds the snake-cased key.

## `NetworkBase`

```php
namespace Drupal\social_auth_acme\Plugin\Network;

use Drupal\social_api\Plugin\NetworkBase;
use Drupal\social_api\SocialApiException;

class AcmeAuth extends NetworkBase {

  protected function initSdk(): mixed {
    if (!class_exists($this->getPluginDefinition()['className'])) {
      throw new SocialApiException('SDK class not found.');
    }
    /** @var \Drupal\social_auth_acme\Settings\AcmeAuthSettings $settings */
    $settings = $this->settings;
    return new \League\OAuth2\Client\Provider\GenericProvider([
      'clientId'     => $settings->getConfig()->get('client_id'),
      'clientSecret' => $settings->getConfig()->get('client_secret'),
      // …
    ]);
  }

}
```

What the base class gives you:

| member | notes |
|---|---|
| `getSdk()` | lazily calls `initSdk()` once and caches the result in `$this->sdk` |
| `initSdk()` | **abstract** — you implement it; throw `SocialApiException` on failure |
| `$this->settings` | the `SettingsInterface` object built by `init()` from `handlers.settings` |
| `$this->loggerFactory` | `logger.factory` |
| `$this->siteSettings` | `Drupal\Core\Site\Settings` |
| `$this->entityTypeManager` | `entity_type.manager` |
| `$this->networkManager` | `plugin.network.manager` |
| `create()` | already implemented; injects all of the above |

`init()` throws `SocialApiException` when `handlers.settings.class` does not exist or does
not implement `SettingsInterface`.

> Bug to be aware of in 4.0.x: `NetworkBase::__construct()` contains
> `$this->configuration = $entity_type_manager;`, overwriting the plugin configuration array
> with the entity type manager. Do not rely on `$this->configuration` inside a Network plugin.

## Settings class

```php
namespace Drupal\social_auth_acme\Settings;

use Drupal\social_api\Settings\SettingsBase;

class AcmeAuthSettings extends SettingsBase {
  public function getClientId(): string {
    return $this->config->get('client_id');
  }
}
```

`SettingsBase` implements `SettingsInterface`: `::factory(ImmutableConfig $config): static`
and `getConfig(): ImmutableConfig`. `NetworkBase::init()` calls the static `factory()`.

## Using a plugin

```php
$manager = \Drupal::service('plugin.network.manager');
$manager->getDefinitions();                  // all Network plugins
$manager->hasDefinition('social_auth_acme');
$sdk = $manager->createInstance('social_auth_acme')->getSdk();
```

`NetworkManager` also exposes `getModuleHandler()`.

## Listing what a site has

```bash
drush php:eval '
  foreach (\Drupal::service("plugin.network.manager")->getDefinitions() as $id => $d) {
    print $id . " type=" . ($d["type"] ?? "?") . " class=" . $d["class"] . "\n";
  }'
```

On a site with only `social_api` enabled this prints nothing — the module ships no Network
plugins itself.

## Altering definitions

```php
function my_module_social_api_network_info_alter(array &$definitions) {
  if (isset($definitions['social_auth_acme'])) {
    $definitions['social_auth_acme']['social_network'] = 'Acme';   // fix the controller column
  }
}
```

Run `drush cr` afterwards — definitions are cached.
