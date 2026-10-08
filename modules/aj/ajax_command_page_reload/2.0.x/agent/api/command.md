<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — PageReloadCommand

The module's entire public surface is one AJAX command class plus its JS handler.

## PHP: `Drupal\ajax_command_page_reload\Ajax\PageReloadCommand`

Namespace: `Drupal\ajax_command_page_reload\Ajax`
File: `src/Ajax/PageReloadCommand.php`

Implements `Drupal\Core\Ajax\CommandInterface` and `Drupal\Core\Ajax\CommandWithAttachedAssetsInterface`.

```php
public function render(): array {
  return ['command' => 'pageReload'];
}

public function getAttachedAssets() {
  $assets = new AttachedAssets();
  $assets->setLibraries(['ajax_command_page_reload/ajax_commands']);
  return $assets;
}
```

- `render()` emits only the command name `pageReload`. It takes **no constructor arguments** and carries **no URL or payload**.
- Because it implements `CommandWithAttachedAssetsInterface`, the framework attaches the module's JS library automatically when the command is in the response — you do not need to attach the library yourself.

## Usage

```php
use Drupal\Core\Ajax\AjaxResponse;
use Drupal\ajax_command_page_reload\Ajax\PageReloadCommand;

// In any AJAX callback / controller that returns an AjaxResponse:
$response = new AjaxResponse();
// ... optionally other commands ...
$response->addCommand(new PageReloadCommand());
return $response;
```

## JavaScript handler

File: `js/ajax/command/page-reload.js`, library `ajax_command_page_reload/ajax_commands` (depends on `core/drupal.ajax`).

```js
Drupal.AjaxCommands.prototype.pageReload = () => {
  // Reload the page without possible form resubmit:
  if (window.history.replaceState) {
    window.history.replaceState(null, null, window.location.href);
  }
  window.location = window.location.href;
};
```

The handler always reloads the **current** URL. `replaceState` rewrites the current history entry to the current href so a subsequent reload does not re-POST a form (no "confirm form resubmission" dialog). There is no way to make this command navigate to a different URL — for that, use a redirect (e.g. `RedirectCommand` or a normal form redirect) instead.

## Notes
- No config, no permissions, no routes, no services, no hooks. Nothing to enable beyond installing the module and using the command in your own code.
- `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
