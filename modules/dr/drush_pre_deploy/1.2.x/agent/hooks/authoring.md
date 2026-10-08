<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drush_pre_deploy — authoring a pre-deploy hook

A pre-deploy hook is discovered by core's `UpdateRegistry` (updateType `predeploy`) exactly the way
deploy/post_update hooks are — from a specially named PHP file in a module or theme.

## File and function naming

- File: **`MODULE.predeploy.php`** in the module root (a theme's `THEME.predeploy.php` also works,
  since the command passes `@theme_handler` to the registry).
- Function: **`MODULE_predeploy_NAME(array &$sandbox): ?string`**. The token is `predeploy` — one
  word, not `pre_deploy`. `NAME` is an arbitrary machine-name suffix; within a module, hooks run in
  the order the registry returns them (alphabetical by function name — name them with an ordering
  prefix if order matters, e.g. `MODULE_predeploy_01_x`).
- The canonical signature is documented in the module's `drush_pre_deploy.api.php` as
  `hook_predeploy_NAME`.

## Example (`foo.predeploy.php`)

```php
<?php

use Drupal\node\Entity\Node;

/**
 * Remove a config object that would otherwise block config:import.
 */
function foo_predeploy_drop_stale_view(array &$sandbox): ?string {
  \Drupal::configFactory()->getEditable('views.view.legacy')->delete();
  return t('Deleted stale view before import.');
}
```

## Semantics

- **Runs once per environment.** After a successful run the function name is recorded in the
  `pre_deploy_hook` keyvalue collection and will not run again (mirrors deploy hooks). Adding a new
  `NAME` adds a new one-off task.
- **Batchable.** The command passes a `$sandbox` array and re-invokes the function while
  `$sandbox['#finished']` is set and `< 1`. For large data operations, track progress in `$sandbox`
  and set `$sandbox['#finished']` to a fraction; omit it (or set `>= 1`) for a single pass.
- **Return value.** Return an optional translated string; it is logged as a notice in deploy output.
- **Errors.** Throw `\Exception` (any `\Throwable` is caught) with a meaningful message; this fails
  the `deploy:pre-hook` run (exit 1) and, when auto-injected, aborts `drush deploy`.

## The critical caution: old schema

Because pre-deploy hooks run **before** `updatedb` and `config:import`, they execute against the
**current (old) database schema and config**. Do not reference fields, tables, config, or services
that a pending update/config import is about to introduce — that is the most common way a pre-deploy
hook breaks a deployment. Use pre-deploy hooks for work that must precede updates (cleanup, snapshots,
guarding preconditions, disabling a module before its update hook); use core `hook_deploy_NAME()` for
work that must follow them.
