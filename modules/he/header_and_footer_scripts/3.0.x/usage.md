Header and Footer Scripts lets administrators paste arbitrary CSS/JS (inline or `<link>`/`<script>` tags) into three site-wide regions — head, top-of-body, and footer — from admin forms, without editing theme files.

---

The module provides three settings forms under *Configuration → Development → Header Footer Scripts* (`/admin/config/development/header-and-footer-scripts/{header,body,footer}`), each with a **Styles** textarea and a **Scripts** textarea. Each form saves to its own simple config object: `header_and_footer_scripts.header.settings`, `header_and_footer_scripts.body.settings`, and `header_and_footer_scripts.footer.settings`, every one holding a `styles` string and a `scripts` string. At render time the module parses those raw strings and injects them: the **header** region is added into `<head>` via `hook_page_attachments_alter()` (`#attached[html_head]`); the **body** region is printed right after the opening `<body>` via `hook_page_top()`; and the **footer** region is printed near the end of the page via `hook_page_bottom()`. It splits the textarea on tag boundaries and rebuilds each `<style>`/`<link>`/`<script>`/`<noscript>` as an `html_tag` render element, copying across the original attributes. Access to all three forms is gated by the single `header_and_footer_scripts_settings` permission ("Add Scripts all over the site", marked restricted). There is no config schema shipped and HTML comments are not supported inside the textareas.

---

- Add a Google Analytics / GA4 `gtag.js` snippet to `<head>` on every page without touching the theme.
- Install Google Tag Manager: the `<script>` in `<head>` and the `<noscript>` right after `<body>` (the body region).
- Drop in a Facebook Pixel, LinkedIn Insight, or other marketing tracking tag site-wide.
- Add a verification `<meta>`/`<script>` for Google Search Console or Bing.
- Inject a custom `<style>` block to tweak site CSS globally without a subtheme.
- Link an external stylesheet via `<link rel="stylesheet" href="...">` in the header region.
- Load a third-party JS widget (chat, cookie banner, A/B test) before the closing footer.
- Add a cookie-consent script early in `<head>` so it runs before other tags.
- Place a heavy analytics `<script>` in the footer so it does not block initial render.
- Add a `<noscript>` fallback for users with JavaScript disabled.
- Give marketers a UI to manage tracking codes without a deployment.
- Inject inline JS to set a global config variable read by other scripts.
- Add print-only or media-specific CSS via `<style>`/`<link media="...">`.
- Temporarily add a maintenance banner style/script across the whole site.
- Attach a hotjar/heatmap or session-recording snippet everywhere.
- Add schema.org JSON-LD `<script type="application/ld+json">` in the head region.
- Register a service-worker bootstrap script near the footer.
- Restrict who can edit these scripts with the "Add Scripts all over the site" permission.
- Keep environment-specific tags in exported config (`header_and_footer_scripts.*.settings`).
- Add a favicon or preconnect `<link>` into `<head>` site-wide.
- Load a font-provider script (e.g. Typekit) in the header.
- Add a custom `<style>` override that must win over theme CSS by loading late in the footer.
- Provide a quick way to test a third-party embed before building it into a theme.
