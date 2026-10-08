<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Error prepend string surfaces PHP's `error_prepend_string` and `error_append_string` ini directives inside a Drupal response by wrapping the rendered content with those configured strings.
---
The module ships a single kernel `RESPONSE` event subscriber that reads `ini_get('error_prepend_string')` and `ini_get('error_append_string')` and concatenates them around the response body as `prefix . content . suffix`. The intent is to let a site reuse markup or branding defined at the PHP ini level (for example a styled error/branding wrapper) on Drupal-served responses, since Drupal's own output pipeline normally bypasses those directives. The wrapping strings are set only by the server operator in PHP configuration — via `php.ini`, `.htaccess`, or a `settings.php` `ini_set()` call — never from request input. There is no settings form, no route, no permission, and no config object: everything is driven by the two PHP ini values.

One important accuracy note: the subscriber's status-code guard is written as `!$response->getStatusCode() == 500`, and PHP's operator precedence evaluates this as `(!$statusCode) == 500`, which is `false` for every real HTTP status code (200, 404, 500, 301, ...). As shipped in 1.0.1 the guarded block therefore never runs, so the subscriber does not actually wrap responses until this condition is corrected. Also, wrapping (when working) only covers responses from thrown exceptions; fatal errors are handled by Drupal core's own error handler and require a separate core patch to cover. Verify the actual behaviour in your environment before relying on it.
---
- Reuse a server-defined error/branding wrapper on Drupal-served pages
- Prepend fixed markup to responses using a value from `php.ini`
- Append a footer string defined at the ini level
- Give error output a "dark mode" look via a `prefers-color-scheme` CSS snippet
- Improve the readability of exception error pages with custom styling
- Keep error-wrapper markup consistent with non-Drupal endpoints
- Bring `error_prepend_string` behaviour into Drupal without patching PHP output
- Set the wrapper strings via a `settings.php` `ini_set()` call
- Configure the directives through `.htaccess`
- Configure the directives through `php.ini` (easy under DDEV)
- Centralise wrapper markup in server configuration instead of a theme
- Bridge legacy ini-based error styling into a Drupal site
- Add operator-controlled prefix/suffix framing around responses
- Provide a global HTML wrapper without editing the active theme
- Standardise output framing across mixed PHP and Drupal endpoints
- Add a debug marker to responses in a controlled development environment
- Combine with the referenced core patch to also cover fatal errors
- Inspect the subscriber before production to confirm the wrapping scope
- Pair with the "Error custom pages" module when a fully themed approach is needed
- Enable purely from code with no database configuration to manage
