# Plugin type: `LanguageSelectionPageCondition`

A condition plugin decides **whether** the splash-page redirect (or block) fires on the current
request, and optionally **alters** the page content / response / destination. It is the module's one
extension point.

- Manager service: `plugin.manager.language_selection_page_condition`
  (`LanguageSelectionPageConditionManager`, extends `DefaultPluginManager`, implements
  `ExecutableManagerInterface`).
- Discovery dir: `src/Plugin/LanguageSelectionPageCondition/`.
- Annotation: `@LanguageSelectionPageCondition` (`Annotation\LanguageSelectionPageCondition`, extends
  core `@Condition`). Fields: `id`, `name`, `description`, `weight`, `runInBlock`.
- Interface: `LanguageSelectionPageConditionInterface` (extends core `ConditionInterface`).
- Base class: `LanguageSelectionPageConditionBase` (extends core `ConditionPluginBase`).
- Alter hook: `language_selection_page_condition_info` (alter the collected definitions).

## How the chain is run

- **Redirect decision** (`LanguageSelectionPageSubscriber`) and **form build**
  (`NegotiationLanguageSelectionPageForm`) iterate **all** definitions, weight-sorted ascending.
- `$manager->execute($plugin)` calls `$plugin->evaluate()`. In the base class `evaluate()` calls
  `execute()`; concrete plugins return `$this->pass()` (TRUE — continue) or `$this->block()` (FALSE —
  stop). **Any `block()` aborts the redirect / hides the block.**
- **Block visibility** (`LanguageSelectionPageBlock::blockAccess`) runs only the plugins whose
  definition has `runInBlock=TRUE`.
- **Page building** (`LanguageSelectionPageController`) calls `getDestination()`, `alterPageContent()`
  and `alterPageResponse()` on every plugin.

## Interface / base methods to implement or override

| Method | Purpose |
|---|---|
| `evaluate()` (→ `execute()`) | Return `pass()` (TRUE) to allow, `block()` (FALSE) to stop. This is the core gate. |
| `pass()` / `block()` | Base helpers returning TRUE / FALSE. |
| `getDestination($destination)` | Resolve/modify the post-selection destination path. Base returns it unchanged. |
| `alterPageContent(array &$content, $destination)` | Contribute to / wrap the splash-page render array. |
| `alterPageResponse(&$content)` | Post-process the built content (may replace it with a Response). |
| `buildConfigurationForm()` / `validateConfigurationForm()` / `submitConfigurationForm()` | Add a settings section to the detail form; the submitted value is saved to config under the plugin id. |
| `postConfigSave()` | Run after config save (e.g. rebuild routes). |
| `getWeight()` / `setWeight()` / `getName()` / `getDescription()` | Metadata helpers (base reads them from the definition). |

## Bundled condition plugins

| id | weight | runInBlock | Role |
|---|---|---|---|
| `title` | -200 | no | Stores the page title; always passes. |
| `method_is_valid` | -200 | no | Blocks if the `language-selection-page` negotiation method is not enabled for the interface type. |
| `php_sapi` | -120 | no | Blocks when `PHP_SAPI === 'cli'`. |
| `path_is_valid` | -110 | yes | Blocks if the current path is not a valid Drupal path. |
| `language_prefixes` | -110 | yes | Blocks unless **every** enabled language has a URL prefix; **also builds the per-language links** in `alterPageContent()`. |
| `xml_http_request` | -110 | no | Blocks on AJAX / `XMLHttpRequest`. |
| `path` | -100 | yes | Stores/validates the splash-page path; blocks when the current path *is* the splash page (loop guard); resets front page if the LSP path is set as `page.front`. |
| `type` | -90 | no | Operating mode (`standalone`/`embedded`/`block`); blocks when `block`; resolves the destination (`getDestination()`); wraps content as a full page when `standalone`. |
| `index` | -60 | no | Blocks unless the script is `index.php`. |
| `blacklisted_paths` | -50 | yes | Blocks on configured blacklisted paths (alias + internal, `*` wildcard). |
| `ignore_neutral` | -40 | yes | When enabled, blocks on a route whose entity parameter is untranslatable. |

## Writing your own condition

```php
namespace Drupal\my_module\Plugin\LanguageSelectionPageCondition;

use Drupal\language_selection_page\LanguageSelectionPageConditionBase;
use Drupal\language_selection_page\LanguageSelectionPageConditionInterface;

/**
 * @LanguageSelectionPageCondition(
 *   id = "my_condition",
 *   name = @Translation("My condition"),
 *   description = @Translation("Skip the splash page for logged-in users."),
 *   weight = -30,
 *   runInBlock = TRUE,
 * )
 */
final class MyCondition extends LanguageSelectionPageConditionBase implements LanguageSelectionPageConditionInterface {

  public function evaluate() {
    // Return $this->block() to suppress the splash page, $this->pass() to allow it.
    return \Drupal::currentUser()->isAuthenticated() ? $this->block() : $this->pass();
  }

}
```

Inject services with a `create()`/`__construct()` (the base implements
`ContainerFactoryPluginInterface`). Use `weight` to position relative to the bundled plugins and
`runInBlock` to control whether it also gates block visibility. To alter the **destination** instead
of the decision, override `getDestination($destination)`; to add markup, override
`alterPageContent()`. Clear caches after adding a plugin so the manager rediscovers it.
