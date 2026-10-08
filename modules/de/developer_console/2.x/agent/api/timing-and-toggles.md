<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request timing & debug toggles

## Per-request time tracking — `TimeCounter` + `DevInit` middleware
- `src/StackMiddleware/DevInit.php` is registered as an `http_middleware` (priority 1000) and, on every request, calls `TimeCounter::initialize($request)`.
- `src/TimeCounter.php` (service `dev_time_counter`, also aliased to the class) only does anything when **both** conditions hold (`isEnabled()`):
  1. `Settings::get('dev_time_counter_enabled') === TRUE` — set in `settings.php` (`$settings['dev_time_counter_enabled'] = TRUE;`), and
  2. the request query string contains `track_time`.
- When enabled, `initialize()` logs (channel `dev_time_counter`, level warning) where tracking started; call `\Drupal::service('dev_time_counter')->track('label')` from code to log elapsed ms since the last checkpoint. Uses autowired lazy closures for the current request and the logger. Disabled by default; the warning log level is intentional so accidental tracking is visible.

## Debug dump toggles (State API)
These are runtime flags read from `\Drupal::state()` (no config UI; set with `drush state:set` or code):
- **`dev.forms`** — when TRUE, `developer_console_form_alter()` (in `.module`) dumps `[$form_id, get_class($form_state->getFormObject())]` via `kdpm()` for every form built. Set: `drush state:set dev.forms 1`.
- **`dev.path_info`** — when TRUE, `src/EventSubscriber/EventSubscriber.php` (`KernelEvents::REQUEST`) dumps route name, request URI, query string, method, content-type and raw body via `kdpm()` on each request. Set: `drush state:set dev.path_info 1`.
- Because both dump through `kdpm()`, the output is still subject to the `access debug info` permission gate (unless the `A` flag were used, which these callers do not pass). Turn the flags back off (`drush state:delete dev.forms`) when done.

## Practical use
- Enable form dumping to discover a form's id/class before writing `hook_form_alter` targeting it.
- Enable path-info dumping to inspect routing/request details while debugging.
- Enable `dev_time_counter_enabled` in a local `settings.php` and append `?track_time` to a URL to log request timing without editing code.
