# Adding scripts and styles

Three forms, three config objects, three render regions. There is **no config schema** — the config
objects are simple key/value stores written by `ConfigFormBase` subclasses.

## Forms & routes

| Region | Route | Path | Form class | Config object |
|---|---|---|---|---|
| Header | `header_and_footer_scripts.admin.header` | `/admin/config/development/header-and-footer-scripts/header` | `HeaderForm` | `header_and_footer_scripts.header.settings` |
| Body | `header_and_footer_scripts.admin.body` | `.../body` | `BodyForm` | `header_and_footer_scripts.body.settings` |
| Footer | `header_and_footer_scripts.admin.footer` | `.../footer` | `FooterForm` | `header_and_footer_scripts.footer.settings` |

`configure` in info.yml points at the header route. Each form has two textareas → two config keys:
`styles` and `scripts`. All three forms require the `header_and_footer_scripts_settings` permission
("Add Scripts all over the site", restricted).

## Where each region renders (module hooks)

- **header** settings are output into the document `<head>` via `hook_page_attachments_alter()`
  (appended to `$attachments['#attached']['html_head']`). (Despite the form's help text mentioning
  the body tag, the code injects header content into `html_head`.)
- **body** settings are output right after the opening `<body>` tag via `hook_page_top()`
  (`$page_top[...]`). This is the correct place for a Google Tag Manager `<noscript>`.
- **footer** settings are output near the end of the page via `hook_page_bottom()`.

## What you can put in the textareas

Raw markup, one or more of: `<style>…</style>`, `<link … />`, `<script>…</script>`,
`<noscript>…</noscript>`. The module splits the text on tag boundaries, re-creates each as an
`html_tag` render element, and preserves the original attributes. **HTML comments are not supported**
inside the textareas.

## Setting it programmatically / in config

```php
\Drupal::configFactory()->getEditable('header_and_footer_scripts.header.settings')
  ->set('scripts', '<script>console.log("hi");</script>')
  ->set('styles', '<style>body{color:#111}</style>')
  ->save();
```

Drush equivalents: `drush config:set header_and_footer_scripts.footer.settings scripts '<script>…</script>' -y`.
Reading current values: `drush config:get header_and_footer_scripts.header.settings`.

Uninstalling the module deletes all three config objects (`hook_uninstall`).
