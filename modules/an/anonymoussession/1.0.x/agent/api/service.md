<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `anonymoussession` service and `apply()`

The entire module is one service. Source: `src/Services/AnonymousSessionService.php`,
declared in `anonymoussession.services.yml`.

## Install / enable
```
composer require drupal/anonymoussession
drush en anonymoussession -y
```
No configuration step exists — enabling the module makes the service available.

## Service definition
```yaml
# anonymoussession.services.yml
services:
  anonymoussession:
    class: Drupal\anonymoussession\Services\AnonymousSessionService
    arguments:
      - '@session_manager'   # Drupal\Core\Session\SessionManager
      - '@current_user'      # Drupal\Core\Session\AccountProxyInterface
```

## Class API
`Drupal\anonymoussession\Services\AnonymousSessionService`

- Constructor `(SessionManager $sessionManager, AccountProxyInterface $currentUser)`.
- `public function apply(): void` — the only public method. Logic:
  ```php
  if ($this->currentUser->isAnonymous() && !isset($_SESSION['AnonymousSessionService'])) {
    $_SESSION['AnonymousSessionService'] = TRUE;
    $this->sessionManager->start();
  }
  ```
  - Does nothing for authenticated users.
  - For an anonymous user, sets the marker `$_SESSION['AnonymousSessionService'] = TRUE` and starts
    the core session (which triggers a session cookie / persistence).
  - Idempotent: the marker guards against starting the session more than once per session.
  - Returns nothing; no exceptions of its own.

## How to consume

Quick, procedural:
```php
$anonymousSession = \Drupal::service('anonymoussession');
$anonymousSession->apply();
$_SESSION['my_module']['step'] = 2;  // now reliably persisted for the anon visitor
```

Injected into your own service/controller (preferred):
```yaml
services:
  my_module.thing:
    class: Drupal\my_module\Thing
    arguments: ['@anonymoussession']
```
```php
public function __construct(protected $anonymousSession) {}

public function run(): void {
  $this->anonymousSession->apply();
  // Safe to use PrivateTempStore for anonymous users, $_SESSION, etc.
}
```

Call `apply()` **before** the first read/write of session state on that request.

## When / where to call it
- Call it only on the specific routes, controllers, event subscribers, or form handlers that need
  anonymous state. Calling it globally (e.g. every request) forces a session on all anonymous
  traffic.
- Trade-off: an anonymous request that has started a session is **not served by Drupal's anonymous
  page cache**, so broad use hurts anonymous cacheability. Scope it narrowly.

## What it does NOT provide
- No routes, controllers, forms, permissions, or admin UI.
- No configuration objects or config schema.
- No entities, plugin types, hooks, Drush commands, or libraries.
- No access-control behaviour — it neither grants nor checks permissions; it only establishes a
  session. Authorization remains entirely your code's responsibility.
