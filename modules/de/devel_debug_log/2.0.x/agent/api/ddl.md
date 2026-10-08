<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logging debug messages: `ddl()`, `ddl_once()`, and the Twig `ddl()`

Grounded in `devel_debug_log.module`, `src/Twig/DevelDebugLogExtension.php`,
`src/Controller/DevelDebugLogController.php`, and `devel_debug_log.install`.

These are **global procedural functions** (autoloaded via the `.module` file once the module is
enabled) — no service, no `use` statement, just call them. They write to the `devel_debug_log`
database table; view the results at `admin/reports/debug`.

## `ddl($message, $title = '')`

```php
ddl($some_value, 'A title');           // titled entry
ddl($entity);                          // untitled entry
ddl(['a' => 1, 'b' => 2], 'my array'); // array/object → pretty-printed (Kint)
```

- `$message` — `mixed`. A **string** is stored as-is. An **array/object** is rendered through
  Devel's dumper first (`plugin.manager.devel_dumper`, using the plugin named in
  `devel.settings:devel_dumper` — Kint by default; on CLI it forces Kint rich mode). The column
  stores the **already-rendered dumper markup**, not the original value, so the row is display-only.
- `$title` — optional string shown before the message on the list page.
- Returns `void`. Each call INSERTs one row (`id`, `timestamp` = request time, `title`, `message`,
  `serialized`). There is no automatic pruning — rows accumulate until you clear them.

## `ddl_once($message, $title = '')`

Same as `ddl()` but skips the write if an **identical** message was already logged **during the
current request**. Dedup key is `md5(serialize($message))`, tracked in a `drupal_static`. Resources
are never deduped (they can't be serialized). Use inside loops to avoid dozens of identical rows.

```php
foreach ($items as $item) {
  ddl_once($item->type, 'item types seen'); // one row per distinct type this request
}
```

## Twig `ddl(value, title)`

Registered by `DevelDebugLogExtension`. **No-op unless Twig debug is enabled**
(`$env->isDebug()` → `twig.config: { debug: true }` in `sites/*/services.yml`, or
`drush -y config:set … ` is not applicable — it's a container param, set it in `services.yml`).

```twig
{{ ddl(node.field_foo.value, 'field_foo') }}   {# log one value with a title #}
{{ ddl(node) }}                                 {# log one value #}
{{ ddl() }}                                     {# no args → dumps the whole Twig context #}
```

With no arguments it logs the entire template context (minus nested `Template` objects) under the
title *"Context as array"*.

## Viewing and clearing

- Page: **Reports → Debug messages** (`admin/reports/debug`), permission `access debug messages`.
  Lists rows newest-first (`ORDER BY id DESC`) with a core pager; each row shows title, formatted
  time (`short` date format), and the message.
- **Clear log messages** button (a fieldset form on the same page) runs
  `DELETE FROM devel_debug_log` — removes everything, no per-row delete.

## Verify from Drush

```bash
# Write a test entry, then confirm it landed.
ddev drush php:eval 'ddl("hello from drush", "smoke test");'
ddev drush sqlq 'SELECT id, title, LEFT(message,40) FROM devel_debug_log ORDER BY id DESC LIMIT 3'
# Clear everything:
ddev drush sqlq 'DELETE FROM devel_debug_log'
```

> Note: on CLI, `ddl()` renders through Kint rich mode, so the stored `message` will contain HTML
> dump markup even for a scalar — that markup is what the admin page displays (via `|raw`).
