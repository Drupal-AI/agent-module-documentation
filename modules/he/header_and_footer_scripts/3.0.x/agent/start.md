# Header and Footer Scripts — agent index

Paste site-wide CSS/JS into three regions from admin forms. No plugins, no Drush, no config schema.
State is three plain config objects, each `{styles: string, scripts: string}`.

- **The three forms, config object names/keys, render regions, and the permission** →
  [configure/scripts.md](configure/scripts.md)

Key facts (config object → render location):
- `header_and_footer_scripts.header.settings` → injected into `<head>` (`hook_page_attachments_alter`, `#attached[html_head]`).
- `header_and_footer_scripts.body.settings` → printed after opening `<body>` (`hook_page_top`).
- `header_and_footer_scripts.footer.settings` → printed near end of page (`hook_page_bottom`).

Each object has `styles` and `scripts` strings (raw `<style>/<link>/<script>/<noscript>` markup).
Configure route: `header_and_footer_scripts.admin.header`. Permission:
`header_and_footer_scripts_settings` ("Add Scripts all over the site"). HTML comments are not supported.
