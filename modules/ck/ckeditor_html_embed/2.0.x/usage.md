<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ckeditor5 HTML Embed adds an "HTML embed" toolbar button to CKEditor 5 that lets editors paste and embed an arbitrary raw HTML snippet (iframes, `<script>` widgets, custom markup) directly inside body content.

---

The module is a thin Drupal integration wrapper around CKEditor 5's official `HtmlEmbed` feature. It ships no PHP: it provides a CKEditor 5 plugin definition (`ckeditor_html_embed.ckeditor5.yml`) that registers the JavaScript plugin `htmlEmbed.HtmlEmbed`, a toolbar item `htmlEmbed` (labelled "HTML Embed"), the bundled build library `ckeditor_html_embed/htmlEmbed`, and an admin CSS library for the toolbar icon. It declares the HTML elements it produces — `<div>` and `<div class="raw-html-embed">` — so Drupal's filter/allowed-tags handling knows about them. You enable it per text format by dragging the **HTML embed** button into that format's CKEditor 5 toolbar; the toolbar and active plugins are stored on the format's `editor.editor.<format>` config entity. The CKEditor feature is configured with `htmlEmbed.showPreviews: false` (previews off; the raw source is shown), and the module depends only on core's `ckeditor5`. Because embedded HTML can contain scripts, the button should be limited to trusted roles' text formats, and the format's "Limit allowed HTML tags" filter (if enabled) must permit the tags you want editors to embed.

---

- Let trusted editors embed a third-party `<iframe>` (maps, calendars, forms) inside a node body.
- Paste a marketing widget or embed code (e.g. a newsletter signup) into content.
- Add a social media embed snippet that core's media embed does not cover.
- Insert a custom `<script>`-based widget on specific pages via the WYSIWYG.
- Embed raw HTML tables or markup copied from another system.
- Provide a "raw HTML" escape hatch for power editors without granting full HTML source access.
- Add the HTML embed button only to a "Full HTML"-style format used by administrators.
- Keep embedded HTML in a distinct `raw-html-embed` wrapper so it is easy to target in CSS/themes.
- Embed a video player or audio widget from a provider lacking a Drupal media source.
- Insert analytics or A/B-testing snippets within body content on landing pages.
- Let editors drop in a code-generated chart or visualization embed.
- Add a booking/reservation widget iframe to a services page.
- Combine with a restricted text format so only certain roles can embed HTML.
- Show the raw HTML source in the editor (previews disabled) so editors see exactly what they pasted.
- Migrate legacy inline-HTML content into CKEditor 5 without losing the raw markup.
- Provide an embed point for donation or crowdfunding widgets.
- Embed a live chat or support widget on a contact page.
- Add structured/custom markup that a component library expects, inside otherwise plain content.
- Enable HTML embedding on a per-format basis while keeping other formats locked down.
- Give a documentation format the ability to embed interactive demos.
