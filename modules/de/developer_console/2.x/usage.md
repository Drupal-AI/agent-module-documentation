Developer console adds an on-site admin page for running ad-hoc PHP code and database queries, plus Kint-based dump helpers and request execution-time tracking, aimed at developers who want a lightweight alternative to Devel.

---

The module exposes a two-field console form at `/admin/console` where a developer selects a syntax (PHP or SQL), types code or a query, and executes it in the running Drupal request; results, printed output, and execution time are shown back on the page, and the last ten entries of each type are kept in a history table (`developer_console_history`) for quick reuse. Alongside the console it ships global helper functions — `kdpm()` (a Kint-powered `dpm`/dump with output-mode flags), `debug_info()`, `var_size()`, and `time_monit()` — plus a Twig `kdpm()` function, an HTTP middleware and `TimeCounter` service for per-request timing gated by a `settings.php` flag and a `track_time` query string, and an optional request/form debug dump toggled through State keys (`dev.forms`, `dev.path_info`). Two restricted permissions guard the tooling: `access console` protects the console routes and `access debug info` gates whether dump output is rendered. Because the console evaluates arbitrary PHP and SQL, it is a developer/staging tool only and its permissions should never be granted on production or to untrusted users.

---

- Open `/admin/console` to run a snippet of PHP against the live Drupal environment.
- Run an ad-hoc SQL query (SELECT/UPDATE/etc.) from the console's DB-query mode and see affected rows in a table.
- Inspect the value returned by a PHP expression together with anything it prints.
- Measure how long a piece of code takes: the console reports execution time in milliseconds.
- Reuse a previous snippet from the per-type history list (last 10 PHP and last 10 SQL entries).
- Toggle whether a console entry is saved to history with the "save in history" checkbox.
- Dump any variable with Kint from module or theme code via the global `kdpm($var)` helper.
- Send Kint dump output to a Drupal status message (`kdpm($var)` default mode `M`).
- Print Kint output directly at the top of the page (`kdpm($var, 'P')`).
- Return Kint output as a string for further handling (`kdpm($var, 'S')`).
- Write Kint output to a file and retrieve it later (`kdpm($var, 'F')` then `kdpm(null, 'G')`).
- Limit dump nesting depth by passing an integer flag (e.g. `kdpm($var, '2')`).
- Dump only the keys of an array/object with the `K` flag.
- Prevent repeated output in one request with the `R` flag, or suppress the logger notice with `L`.
- Allow dump output for all users (not just those with `access debug info`) with the `A` flag.
- Print a debug backtrace of the current call with `debug_info()`.
- Measure elapsed time between checkpoints in code with `time_monit('tag')`.
- Get the serialized byte size of a variable with `var_size('id', $var)`.
- Call `kdpm()` inside a Twig template to dump template variables or the whole context.
- Turn on automatic dumping of every form's id and form-object class by setting State `dev.forms` to TRUE.
- Turn on per-request route/method/body debug dumps by setting State `dev.path_info` to TRUE.
- Enable low-overhead per-request time tracking by setting `dev_time_counter_enabled` in `settings.php` and adding `track_time` to a URL's query string.
- Restrict who can reach the console and the dump output using the `access console` and `access debug info` permissions.
- Use the sandbox form at `/admin/console/form` as a scratch place to observe submitted form values via `kdpm()`.
