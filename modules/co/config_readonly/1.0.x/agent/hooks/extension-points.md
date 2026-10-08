<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension points

There is no `config_readonly.api.php`; these are the two real seams, read straight from the
source.

## `hook_config_readonly_whitelist_patterns()`

Invoked with `$moduleHandler->invokeAll('config_readonly_whitelist_patterns')` and cached
per object in `ConfigReadonlyWhitelistTrait::$patterns`. Return a flat array of patterns.
`config_readonly` implements it itself, returning
`Settings::get('config_readonly_whitelist_patterns')` — so `settings.php` and modules feed
the same list.

```php
// mymodule.module
/**
 * Implements hook_config_readonly_whitelist_patterns().
 */
function mymodule_config_readonly_whitelist_patterns() {
  return [
    'system.maintenance',      // exact name
    'mymodule.settings',
    'views.view.mymodule_*',   // '*' is the only wildcard, anchored ^…$
  ];
}
```

Gotchas:
- The array returned by `invokeAll()` is flattened across modules; returning `NULL` (which
  `Settings::get()` does when unset) is fine.
- Patterns are matched against **config object names**, not routes or form ids.
- Whitelisting a config-entity list page needs the prefix form, e.g. `views.view.*`.

## `ReadOnlyFormEvent` (`config_readonly_form_event`)

Dispatched from `config_readonly_form_alter()` for **every** form on a locked site, before
the module decides what to do. `Drupal\config_readonly\ReadOnlyFormEvent`:

| Member | Purpose |
|---|---|
| `const NAME = 'config_readonly_form_event'` | event name |
| `getFormState(): FormStateInterface` | the form state (use `getFormObject()`) |
| `getForm(): array` | the raw form array |
| `markFormReadOnly(): void` | block this form |
| `markFormEditable(): void` | explicitly allow this form |
| `isFormReadOnly(): bool` | current decision |
| `setEditableConfigNames(array): void` | names shown in the warning message |
| `getEditableConfigNames(): array` | read them back |

The module's own `ReadOnlyFormSubscriber` listens at **priority 200**. Use a *lower*
priority to react after it (e.g. to re-open a form), or a higher one to decide first.

```php
// mymodule.services.yml
services:
  mymodule.readonly_forms:
    class: Drupal\mymodule\EventSubscriber\MyReadOnlySubscriber
    tags:
      - { name: event_subscriber }
```

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\config_readonly\ReadOnlyFormEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyReadOnlySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    // Priority 100 < 200, so this runs after config_readonly's own decision.
    return [ReadOnlyFormEvent::NAME => [['onFormAlter', 100]]];
  }

  public function onFormAlter(ReadOnlyFormEvent $event): void {
    $form_object = $event->getFormState()->getFormObject();

    // Block an extra, non-config form.
    if ($form_object->getFormId() === 'mymodule_dangerous_form') {
      $event->markFormReadOnly();
    }

    // Or let one config form through anyway.
    if ($form_object->getFormId() === 'mymodule_settings_form') {
      $event->markFormEditable();
    }
  }
}
```

**Caveat:** `markFormEditable()` only removes the *form* guard. The storage guard still
throws `ConfigReadonlyStorageException` on save unless the config names are also in the
whitelist — so pair the event with `hook_config_readonly_whitelist_patterns()`.

## Not extension points

- No plugin types, no Drush commands, no permissions, no config schema, no templates.
- `ConfigReadonlyStorage` is a service class swap done in `ConfigReadonlyServiceProvider`;
  a second module decorating `config.storage` must account for it already being replaced.
