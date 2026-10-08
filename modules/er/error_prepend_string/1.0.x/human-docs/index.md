# Error prepend string — manual setup guide

**Error prepend string** (`error_prepend_string`) — nicknamed *"Dark Mode Errors"* —
lets a Drupal site honour PHP's `error_prepend_string` and `error_append_string`
ini directives by wrapping the rendered response with those configured strings.
Normally Drupal's own output pipeline bypasses those directives; this module brings
them back into play, so you can inject a bit of markup or styling around error
output that Drupal serves.

The headline use is dressing up error pages — for example a small CSS snippet with a
`prefers-color-scheme` media query that gives errors a dark background and light red
monospaced text, so error output is easier to read (and matches how you've styled it
elsewhere). The wrapping strings come from **server configuration** — the values a
site operator sets in PHP — and nothing else feeds them.

There's no module settings form — the strings themselves are set in PHP
configuration (see below). It supports Drupal 8, 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page in Drupal**. You configure it by setting the
PHP ini directives, as described below.

## How to use it

1. Set `error_prepend_string` (and optionally `error_append_string`) in your PHP
   configuration — via `php.ini`, `.htaccess`, or a `settings.php` `ini_set()` call.
   Under DDEV this is straightforward to do in the project's PHP config.
2. The module's response subscriber then wraps served content as
   `prefix + content + suffix`, using those ini values.

Two limits are worth knowing:

- It applies to errors from **thrown exceptions**. **Fatal errors** are handled by
  Drupal core's own error handler, so covering those as well requires a core patch
  (there's a known issue with patches for Drupal 10.x and 11.x, applied via
  `cweagans/composer-patches`).
- The current release (1.0.1) does not actually wrap responses, because of an
  operator-precedence mistake in the subscriber's status-code guard
  (`!$statusCode == 500` is parsed as `(!$statusCode) == 500`, which is never true
  for a real HTTP status). **Verify the behaviour against your intent before relying
  on it in production**; the guard condition has to be corrected for any wrapping to
  take effect.

If you want a more elaborate, fully themed approach to error pages instead, look at
the *Error custom pages* module.
