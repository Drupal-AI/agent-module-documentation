<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a custom Value or Visibility plugin

Both extension points are standard annotated plugins discovered under a module's `src/Plugin/views_evi/…`.

## Custom Value plugin

```php
namespace Drupal\my_module\Plugin\views_evi\Value;

use Drupal\views_evi\Plugin\views_evi\Value\ViewsEviValueBase;
use Drupal\views_evi\ViewsEviValueInterface;

/**
 * @ViewsEviValue(
 *   id = "current_user",
 *   title = "Current user id",
 * )
 */
class CurrentUserValue extends ViewsEviValueBase implements ViewsEviValueInterface {
  public function getValue() {
    $identifier = $this->getFilterWrapper()->getIdentifier();
    return [$identifier => \Drupal::currentUser()->id()];
  }
}
```

- Return an `[identifier => value]` array, or `[]` for "no override".
- Reach context through `$this->getFilterWrapper()` (`ViewsEviFilterWrapper`): `getIdentifier()`, `getId()`, `getFilterHandler()`, `getDisplayHandler()`, `getEvi()`.
- Extend `ViewsEviValueTokenBase` instead if you want the token map (`$this->getTokenReplacements()`), and add a `settingsForm()/defaultSettings()` pair for configurable settings (see `ViewsEviValueToken`).

## Custom Visibility plugin

```php
namespace Drupal\my_module\Plugin\views_evi\Visibility;

use Drupal\views_evi\Plugin\views_evi\Visibility\ViewsEviVisibilityBase;
use Drupal\views_evi\ViewsEviVisibilityInterface;

/**
 * @ViewsEviVisibility(
 *   id = "role_based",
 *   title = "Hidden for anonymous",
 * )
 */
class RoleBasedVisibility extends ViewsEviVisibilityBase implements ViewsEviVisibilityInterface {
  public function getVisibility(&$form) {
    return \Drupal::currentUser()->isAuthenticated();
  }
}
```

- Return `bool` (`FALSE` hides the widget and forces the Value plugin's value). `null` is treated as "leave visible".
- `&$form` is the live exposed form array — a plugin may manipulate `$form[$identifier]` / `$form['#info']["filter-$id"]` directly if needed.

## Settings form contract (`ViewsEviHandlerInterface`)

`settingsForm($settings, &$form)` returns the plugin's settings sub-form; `settingsFormValidate(&$form_values)`; `settingsFormSubmit($form_values)` returns the settings to persist; `defaultSettings()` returns defaults. The base classes provide no-op implementations, so override only what you need. Settings are stored per filter under the display option `views_evi_settings`.

## Extending tokens instead

If you only need to expose a new value to the existing `token`/`php` plugins, implement `hook_views_evi_tokens_alter()` (see `agent/plugins/tokens.md`) rather than a whole plugin.
