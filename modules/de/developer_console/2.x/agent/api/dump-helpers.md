<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kint dump helpers

Defined in `developer_console.module`; loaded whenever the module is enabled (global functions). All Kint output is produced by the internal `_developer_console_kint_output($variable, $type, $depth_limit)`.

## `kdpm($variable = NULL, $set_str = '')`
Kint-powered `dpm`-style dumper. `$set_str` is a string of single-char flags (order-independent, e.g. `"PA"`):
- Any digits in `$set_str` → max nesting depth (default 4), e.g. `kdpm($x, '2')`.
- `L` — suppress the logger notice (by default each call logs `developer_console` notice with caller file/line).
- `A` — output for every user. **Without `A`, output is skipped unless the current user has the `access debug info` permission** (`$user->hasPermission('access debug info')`).
- `R` — render only once per request (static guard).
- `K` — if the variable is array/object, dump only its keys.
- `B` — expand Kint's rich renderer folder (`RichRenderer::$folder = TRUE`).
- Output-mode (first match wins from `F,S,G,P,L`, default `M`):
  - `M` (default) — Kint dump into a Drupal status message.
  - `S` — return dump as a string.
  - `P` — print dump directly (usually page top).
  - `F` — append dump to a file `private://kint_dump.dat` (falls back to `public://` if no private wrapper); throws if unwritable.
  - `G` — read that file back and show it as a status message.
  - `L` in the mode list also maps to the "unlimited depth" browser output branch.

## Other helpers
- `debug_info($args = '')` — dumps `debug_backtrace()` (minus frame 0) via `kdpm(..., $args)`; use to see the current call stack.
- `var_size($id, $variable = NULL)` — returns byte length of `$variable` (string length, else `strlen(serialize(...))`); memoized per `$id` static.
- `time_monit($tag = 'default', $args = '')` — in-code stopwatch using `drupal_static`; first call initializes and prints where; later calls with the same `$tag` print elapsed ms. Always appends `L` (no logger).

## Twig `kdpm()` — `src/Twig/KintExtension.php`
Registered as a Twig function `kdpm` (`is_safe html`, needs env+context, variadic). In a template: `{{ kdpm(node) }}` dumps a variable, `{{ kdpm() }}` dumps the whole template context. It tries to recover the source variable names from the template file (`getTwigFunctionParameters()` parses the `.html.twig` line) so the dump is labelled. The Twig function calls `_developer_console_kint_output()` directly (default string mode `S`) rather than the global `kdpm()`, so it does not itself apply the `access debug info` permission check — treat any `{{ kdpm(...) }}` as debug scaffolding to remove before shipping a template.
