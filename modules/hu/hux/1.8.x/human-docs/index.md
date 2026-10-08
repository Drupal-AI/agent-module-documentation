# Hux — manual setup guide

**Hux** (`hux`) is a developer tool that lets you implement Drupal hooks and
alters as **methods on a plain PHP class using attributes** — no `.module` file
required. Instead of writing `function mymodule_entity_access(...)` in a procedural
file, you write a method and tag it with `#[Hook('entity_access')]`. Because the
method lives on a service class, you get full **dependency injection**: inject the
services you need through the constructor and your hook logic becomes clean and
unit-testable.

Hux offers a few things beyond a plain hook. `#[Hook]` is **repeatable**, so one
method can implement several hooks and one class can implement the same hook many
times, with an optional `priority` to control ordering. `#[Alter]` implements
`hook_*_alter` handlers. And `#[ReplaceOriginalHook]` lets you **override another
module's** existing procedural hook — optionally receiving the original
implementation as a callable so you can wrap or delegate to it.

Note that Drupal core 11.1 introduced its own OOP `#[Hook]` system, so Hux is most
useful on projects that want its **extra** features — multiple implementations of
one hook, replacing another module's hook while still calling the original, or
masquerading as a different module.

There is **nothing to configure in the UI** — Hux has no settings page,
permissions, routes, or Drush commands. It is a coding API, so this guide has an
installation page and a usage walkthrough here rather than a separate configuration
page.

This guide is written for a **human** developer. If you want a terse, token-cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (needs PHP 8.3 and Drupal 11.1+).

## Where it lives in the admin menu

Nowhere — Hux has no admin UI. Once enabled, it works entirely through the
attributes you add in your own module's code.

## How to use it

Hux discovers hook classes automatically when you place them in your module's
`Drupal\<module>\Hooks\` namespace — that is, in `src/Hooks/`. A method's hook name
is the attribute string **without** the `hook_` prefix.

```php
// my_module/src/Hooks/MyModuleHooks.php
namespace Drupal\my_module\Hooks;

use Drupal\Core\Access\AccessResult;
use Drupal\Core\Access\AccessResultInterface;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Session\AccountInterface;
use Drupal\hux\Attribute\Alter;
use Drupal\hux\Attribute\Hook;

class MyModuleHooks {

  // Inject any service you need through the constructor.
  public function __construct(private readonly \Psr\Log\LoggerInterface $logger) {}

  // Implements hook_entity_access().
  #[Hook('entity_access')]
  public function access(EntityInterface $entity, string $op, AccountInterface $account): AccessResultInterface {
    return AccessResult::neutral();
  }

  // One method, several hooks — stack the attributes.
  #[Hook('entity_insert')]
  #[Hook('entity_update')]
  public function onChange(EntityInterface $entity): void {
    $this->logger->info('Changed @id', ['@id' => $entity->id()]);
  }

  // Implements hook_user_format_name_alter().
  #[Alter('user_format_name')]
  public function alterName(string &$name, AccountInterface $account): void {
    $name .= ' (member)';
  }
}
```

Some things worth knowing:

- **Priority** — pass `#[Hook('entity_access', priority: 100)]` to run earlier
  (higher runs first).
- **Replace another module's hook** — use
  `#[ReplaceOriginalHook(hook: 'entity_access', moduleName: 'media')]` and, if you
  want to call the original, add a `#[OriginalInvoker] callable $original` parameter
  that Hux fills with the original implementation.
- **Masquerade** — set `moduleName` on `#[Hook]` to register the implementation as
  if it belonged to another module.
- **Classes outside `src/Hooks/`** — register them by declaring a public service
  tagged `{ name: hooks }` in your module's `*.services.yml`.
- **Cache** — you only need a cache rebuild when you add the **first** hook to a
  new class; adding more attributed methods to an already-registered class needs no
  rebuild.
- **Optimized mode** — for a small production speed-up at the cost of some
  developer-friendliness, set `parameters.hux.optimize: true` in a `services.yml`
  (default `false`).

A couple of limits: the `theme` hook and the `module_implements` alter are not
supported, and a hook name that already starts with `hook_` will fail an
assertion. See the [`agent/`](../agent/api/hooks.md) docs for the full attribute
reference.
