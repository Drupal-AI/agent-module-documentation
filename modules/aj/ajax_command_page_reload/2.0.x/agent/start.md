<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Command Page Reload (ajax_command_page_reload) — agent index

Provides one thing: a custom Drupal **AJAX command** that reloads the current page. Version **2.0.0** (2024). Core `^8 || ^9 || ^10 || ^11`. One dependency: `core/drupal.ajax`. No config, no permissions, no routes, no services, no submodules.

## Mechanism (from source)
- `src/Ajax/PageReloadCommand.php` — `PageReloadCommand implements CommandInterface, CommandWithAttachedAssetsInterface`.
  - `render()` returns `['command' => 'pageReload']` — **no URL, no arguments**.
  - `getAttachedAssets()` attaches the `ajax_command_page_reload/ajax_commands` library.
- `ajax_command_page_reload.libraries.yml` — defines `ajax_commands` (loads `js/ajax/command/page-reload.js`, depends on `core/drupal.ajax`).
- `js/ajax/command/page-reload.js` — registers `Drupal.AjaxCommands.prototype.pageReload`, which calls `window.history.replaceState(null, null, window.location.href)` then `window.location = window.location.href`.

## Key fact
The reload target is **always the current URL** (`window.location.href`). The command carries no URL and the server response cannot redirect the browser elsewhere through it. `replaceState` is used only to avoid a form-resubmit confirmation on reload.

## How to use
```php
use Drupal\Core\Ajax\AjaxResponse;
use Drupal\ajax_command_page_reload\Ajax\PageReloadCommand;

$response = new AjaxResponse();
$response->addCommand(new PageReloadCommand());
return $response;
```

## Two points of judgement
1. **A reload discards the visitor's state** — scroll position, other open dialogs, unsaved input elsewhere. Make it a considered choice, not the first reach when a partial update turns fiddly.
2. **On a form, the post-submit redirect is usually the better tool.** Drupal's normal redirect gets the same fresh page through the framework's own path. This command is for cases with **no submission to redirect from** (e.g. an action from a dialog or a `#ajax` element).

## Further docs
- `agent/api/command.md` — the PHP command class + JS handler, in detail.
