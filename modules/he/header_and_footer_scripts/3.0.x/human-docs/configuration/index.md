# Configuration

Header and Footer Scripts gives you three forms — one per page region. Each form has
a **Styles** textarea and a **Scripts** textarea, and saves to its own configuration
object. You paste raw markup and the module injects it on every page.

## The three forms

| Region | Where to find it | Renders here |
|--------|------------------|--------------|
| **Header** | `/admin/config/development/header-and-footer-scripts/header` | Inside the document `<head>` |
| **Body** | `/admin/config/development/header-and-footer-scripts/body` | Right after the opening `<body>` tag |
| **Footer** | `/admin/config/development/header-and-footer-scripts/footer` | Near the end of the page |

Reach them from **Configuration → Development → Header Footer Scripts**. All three
require the restricted **"Add Scripts all over the site"** permission.

> **Header note.** Despite one form's help text mentioning the body tag, the
> **Header** form's content is injected into the document `<head>`. Use the **Body**
> form for anything that must sit immediately after the opening `<body>` tag — most
> importantly the Google Tag Manager `<noscript>` snippet.

## What you can put in the textareas

Paste one or more raw tags into the Styles and/or Scripts textareas:

- `<style>…</style>` — inline CSS
- `<link rel="stylesheet" href="…">` — an external stylesheet
- `<script>…</script>` — inline or external JavaScript
- `<noscript>…</noscript>` — a no-JavaScript fallback

The module splits the text on tag boundaries, rebuilds each tag, and preserves its
original attributes (like `media`, `type`, or `async`).

> **HTML comments are not supported** inside the textareas — leave them out.

## Common examples

- **Google Analytics (GA4):** paste the `gtag.js` `<script>` into the **Header**
  form's Scripts box.
- **Google Tag Manager:** the `<script>` goes in the **Header** form; the paired
  `<noscript>` goes in the **Body** form.
- **Global CSS tweak:** a `<style>` block in the **Header** (or the **Footer** if it
  must override theme CSS that loads later).
- **A chat or cookie-consent widget:** its `<script>` in the **Header** (for
  consent, so it runs early) or the **Footer** (for non-blocking widgets).

Click **Save configuration** on each form. Changes take effect on the next page
load site-wide.

## The permission

A single permission controls all three forms:

- **Add Scripts all over the site** (`header_and_footer_scripts_settings`) — marked
  **restricted**, because it grants the ability to run arbitrary JavaScript and CSS
  on every page. Grant it only to fully trusted administrator roles.

## Saving programmatically (for developers)

Each region is a plain config object with `styles` and `scripts` string keys, so
you can set them in code or via Drush:

```bash
drush config:get header_and_footer_scripts.header.settings
drush config:set header_and_footer_scripts.footer.settings scripts '<script>…</script>' -y
```

The three objects are
`header_and_footer_scripts.header.settings`, `…body.settings`, and
`…footer.settings`. (Uninstalling the module deletes all three.)
