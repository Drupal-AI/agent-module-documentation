# LanguageCookieCondition plugin type

The subscriber only sets the cookie when **every** condition plugin passes. This is the module's one
plugin type — use it to add site-specific "when to (not) set the cookie" rules.

## Type wiring

- Manager: `src/LanguageCookieConditionManager.php` (service
  `plugin.manager.language_cookie_condition`), extends `DefaultPluginManager` and implements
  `ExecutableManagerInterface`. Discovers `Plugin/LanguageCookieCondition/*`, alter hook
  `language_cookie_condition_info`, cache key `language_cookie_condition_plugins`.
- Annotation: `src/Annotation/LanguageCookieCondition.php` (extends core `Condition`): `id`, `weight`,
  `name`, `description`.
- Interface / base: `LanguageCookieConditionInterface` / `LanguageCookieConditionBase` (extends core
  `ConditionPluginBase`). `evaluate()` delegates to `execute()`. Helpers `block()` (returns FALSE,
  "don't set the cookie") and `pass()` (returns TRUE). The current resolved language is available via
  `setCurrentLanguage()` / `getCurrentLanguage()`.
- Execution: the subscriber calls `$manager->createInstance($id, $config->get())` (so the plugin
  receives the whole `language_cookie.negotiation` config as its configuration), then
  `$manager->execute($plugin)` → `$plugin->evaluate()`. Definitions are sorted by `weight`.

## Shipped conditions (`src/Plugin/LanguageCookieCondition/`)

| id | Purpose |
|---|---|
| `blacklisted_paths` | Block when the current path (alias or internal) matches a configured `blacklisted_paths` glob. |
| `hardcoded_blacklisted_paths` | Block on built-in never-set paths. |
| `index_php` | Only proceed on real `index.php` web requests (skip CLI/cron). |
| `language_access` | Block if the current user has no access to the resolved language. |
| `method_is_valid` | Validate the request method. |
| `path_is_valid` | Validate the current path. |
| `php_sapi` | Block on certain PHP SAPIs. |
| `server_addr` | Server-address based check. |
| `xml_http_request` | Block on AJAX/XMLHttpRequest responses. |

## Write a condition

```php
namespace Drupal\my_module\Plugin\LanguageCookieCondition;

use Drupal\language_cookie\LanguageCookieConditionBase;

/**
 * @LanguageCookieCondition(
 *   id = "my_condition",
 *   weight = 0,
 *   name = @Translation("My condition"),
 *   description = @Translation("Only set the cookie under my rule.")
 * )
 */
class MyCondition extends LanguageCookieConditionBase {

  public function evaluate() {
    // Return $this->block() to prevent the cookie, $this->pass() to allow it.
    // $this->getCurrentLanguage() gives the resolved LanguageInterface.
    return $this->someCheck() ? $this->pass() : $this->block();
  }

}
```

Add a `buildConfigurationForm()` (and `validateConfigurationForm()` / `postConfigSave()`) if the
condition needs its own settings on the negotiation form — see
`LanguageCookieConditionBlacklistedPaths` for the textarea + `postConfigSave()` pattern that stores
`blacklisted_paths` into the shared config object.
