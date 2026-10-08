<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the email body

The module registers a `sendgrid` theme hook (`hook_theme()` in `sendgrid.module`) with the template
`templates/sendgrid.html.twig` and `'mail theme' => TRUE`. It is used only when the `use_theme` config
option is on.

## When it runs

In `SendgridMail::format()`:
1. The body array is joined into one string.
2. If `format_filter` (a text-format id) is set, the body is passed through
   `check_markup($body, $format, $langcode)`.
3. If the message opts out of HTML (`$message['params']['html'] === FALSE`), formatting stops here.
4. If `use_theme` is TRUE, the body is wrapped:
   ```php
   $render = ['#theme' => $message['params']['theme'] ?? 'sendgrid', '#message' => $message];
   $message['body'] = $renderer->renderPlain($render);
   ```
   So a caller can override the template per-message with `$message['params']['theme']`.

## Template variables

`template_preprocess_sendgrid()` exposes `subject` and `body` (`= $message['subject']` /
`$message['body']`), plus the raw `message` array. The default template wraps `{{ body }}` in a simple
HTML table.

## Template suggestions

`hook_theme_suggestions_sendgrid()` adds, in order:

- `sendgrid__{module}` — emails from a given module.
- `sendgrid__{key}` — emails of a given mail key.
- `sendgrid__{module}__{key}` — a specific module + key.

Create e.g. `sendgrid--user--password_reset.html.twig` in your theme/module to override just those
messages.
