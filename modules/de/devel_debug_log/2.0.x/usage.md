<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Devel Debug Log is a developer-only aid that lets you stash ad-hoc debug messages with a `ddl()` call and read them later on a dedicated admin page (**Reports → Debug messages**) instead of relying on on-screen messages or the watchdog log. It shines when the output would otherwise be hard to see — AJAX responses, redirects, subrequests, cron, and Twig rendering.

---

You call the global `ddl($message, $title)` function (or `ddl_once()`) from PHP anywhere in a module, hook, or service; array/object arguments are pretty-printed through Devel's dumper (Kint by default) and the resulting markup is appended as a row to a small custom database table (`devel_debug_log`). A matching Twig function `ddl(value, 'title')` is available inside templates but stays inert unless Twig debug is enabled. Each stored row keeps a timestamp, an optional title, and the rendered message; the page at `admin/reports/debug` (gated by the `access debug messages` permission, `restrict access: TRUE`) lists them newest-first with a pager and a **Clear log messages** button that truncates the table. Unlike `\Drupal::messenger()` output, the log persists across requests until you clear it, so you can trigger an AJAX call and then go read what happened. `ddl_once()` is the same as `ddl()` but skips writing if an identical message was already stored during the current request (deduped by `md5(serialize($message))`), which is handy inside loops. It hard-depends on `devel:devel` (^5.1) and `serialization`, defines no config, no plugin types, no Drush commands, and no hooks — it is intentionally minimal. Because it writes to a raw table and renders stored markup with `|raw` on an admin-restricted page, it is a debugging tool for non-production environments, not something to leave enabled on a live site.

---

- Log the contents of an AJAX callback's response without it vanishing from the screen.
- Debug a `hook_form_alter()` by dumping `$form` / `$form_state` values to a page you can read after submit.
- Inspect what a redirect-then-process flow computed, since messages set before a redirect are otherwise hard to catch.
- Dump the loaded entity inside an entity hook (`hook_entity_presave`, `hook_ENTITY_TYPE_update`) to see field values.
- Trace values across a batch or Queue worker run where `dpm()` output never reaches the browser.
- Debug cron or Drush-triggered code paths by writing to a persistent page rather than stdout.
- Pretty-print a complex nested array/object once with Kint via `ddl($data, 'My data')`.
- Deduplicate noisy loop output with `ddl_once($item, 'seen')` so each distinct value is logged only once.
- Dump the full Twig context of a template by calling `{{ ddl() }}` with no arguments (Twig debug on).
- Log a single Twig variable from a template: `{{ ddl(node.field_foo.value, 'field_foo') }}`.
- Watch how a value changes across multiple render/preprocess passes by logging at each step and reading them in order.
- Compare two objects by logging both with titles and diffing them on the debug page.
- Debug a webform or multistep form's state between steps without printing into the page markup.
- Capture what a REST/JSON:API controller returns by dumping the payload before serialization.
- Keep a running trace during a migration by appending `ddl()` calls at key points.
- Debug event subscribers and middleware where messenger output would break the response.
- Give a persistent debug surface to code that runs in an iframe/modal where messages aren't visible.
- Log the result of a service call to confirm dependency injection wiring is returning what you expect.
- Verify access-check logic by dumping the account and result inside a `_custom_access` callback.
- Use it as a lightweight alternative to `\Drupal::logger()` when you don't want debug noise in dblog/syslog.
- Clear all accumulated debug output in one click from the **Clear log messages** button before a fresh test run.
- Grant a non-admin developer read access to the debug page via the `access debug messages` permission.
- Confirm a piece of code runs at all (and how often) by dropping a titled `ddl()` marker into it.
