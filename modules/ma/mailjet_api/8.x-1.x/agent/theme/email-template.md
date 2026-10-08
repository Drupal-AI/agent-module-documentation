# Email theme + image embedding

## `mailjet` theme hook

`hook_theme()` registers `mailjet` (template `templates/mailjet.html.twig`, `mail theme => TRUE`)
with a `message` variable. `template_preprocess_mailjet()` exposes `subject` and `body` from the
message. The template wraps `{{ body }}` in a simple HTML table shell.

Rendering only happens when config `use_theme` is on: the Mail plugin's `format()` renders

```php
['#theme' => $message['params']['theme'] ?? 'mailjet', '#message' => $message]
```

so a sender can point at a different theme hook via `params['theme']`. After theming, the plain
part is regenerated with Html2Text.

## Overriding per module / key

`hook_theme_suggestions_mailjet()` provides these suggestions (most specific wins):

- `mailjet` — default.
- `mailjet__MODULE` — emails sent by `MODULE`.
- `mailjet__MODULE__KEY` — emails from `MODULE` with mail `KEY`.

Add a matching `mailjet--mymodule.html.twig` / `mailjet--mymodule--mykey.html.twig` to your theme
to customize the markup.

## Image embedding (`embed_image`)

When config `embed_image` is on, `format()` scans the body for `src="…"`, reads each referenced
**local** file (URL query/host stripped, leading `/` removed → relative path) and replaces the
`src` with a base64 `data:` URI so images travel inside the email. Applies only when the Mailjet
API mailer is the formatter.
