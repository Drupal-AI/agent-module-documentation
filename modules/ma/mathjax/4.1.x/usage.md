<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MathJax loads the MathJax JavaScript library on your Drupal site so LaTeX/TeX and MathML written inside delimiters such as `$…$`, `$$…$$`, `\(…\)` and `\[…\]` is typeset as real mathematics in the browser.

---

The module is a settings form, one text-format filter and three JavaScript libraries — no PHP maths happens server-side. Its config object `mathjax.settings` has five keys: `use_cdn` (default 1), `cdn_url` (default the cdnjs MathJax **2.7.0** `TeX-AMS-MML_HTMLorMML` bundle), `config_type` (0 = *Text Format*, 1 = *Custom*), `default_config_string` / `config_string` (a JSON blob assigned to `window.MathJax`), and `enable_for_admin` (default 0). `hook_library_info_build()` rewrites the `mathjax/source` library at runtime to point at either that CDN URL or `/libraries/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML`, and `hook_requirements()` raises a runtime error on the status report when a local copy is selected but missing. In **Text Format** mode (the recommended default) nothing is attached globally: you add the **MathJax** filter (`filter_mathjax`) to a text format, and the filter wraps the processed text in `<div class="tex2jax_process">` and attaches the three libraries plus the `default_config_string` as `drupalSettings.mathjax`; the setup behaviour then adds `tex2jax_ignore` to `<body>` so only filtered fields are typeset. In **Custom** mode the module instead attaches everything on every page via `hook_page_attachments()` using your own `config_string`, skipping admin routes unless `enable_for_admin` is on. `js/config.js` simply assigns `window.MathJax = drupalSettings.mathjax.config` before the library loads, and `js/setup.js` re-typesets after every jQuery AJAX completion via `MathJax.Hub.Queue(['Typeset', MathJax.Hub])` — a MathJax **v2** API, so pinning `cdn_url` at a v3/v4 build breaks re-typesetting. One permission, `administer mathjax` (`restrict access: TRUE`), gates the settings form at `/admin/config/content/mathjax`.

---

- Render LaTeX formulas an editor typed into a node body between `$…$`.
- Typeset displayed equations written as `$$ … $$` or `\[ … \]` in an article.
- Publish university course notes containing derivations without pre-rendering images.
- Show MathML markup produced by an external authoring tool.
- Add maths support to just one text format (e.g. "Full HTML") and not to user comments.
- Serve MathJax from the CDN so no library needs to be deployed.
- Serve MathJax from `/libraries/MathJax` for sites that must not call out to a CDN.
- Pin a specific MathJax version by editing the CDN URL.
- Pass a custom MathJax JSON configuration (delimiters, extensions, message style) in Custom mode.
- Change the inline delimiters so `$` in prices is not mistaken for maths.
- Turn on MathJax for admin pages while building a page that previews formulas.
- Keep MathJax off admin pages by default to avoid slowing the editorial UI.
- Re-typeset formulas that arrive through AJAX (views pagers, modals) automatically.
- Restrict who can change MathJax behaviour with the `administer mathjax` permission.
- Use the settings form's built-in test block to confirm the library is loading.
- Combine with a text format that also allows raw HTML for advanced markup.
- Show chemistry/physics notation in a knowledge base.
- Render formulas inside Views fields that use a MathJax-enabled text format.
- Give a maths blog inline `\( … \)` support without any custom JavaScript.
- Diagnose a missing local library through the Drupal status report requirement check.
- Exclude a region from typesetting by relying on the `tex2jax_ignore` body class in Text Format mode.
- Mark up only the filtered field for processing via the `tex2jax_process` wrapper div.
- Migrate a legacy site that used server-side LaTeX images to client-side typesetting.
