<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Additional JS CSS — agent orientation

Admin CSS/JS injection saved to public files and attached to the head.

Key files:
- `additional_js_css.module` — `hook_page_attachments()` attaches `public://additional_js_css/style.css` and `script.js` when the active theme is the default theme.
- `src/AdditionalJSCSSManager.php` — read/write the two files via the file system service.
- `src/Form/AdditionalJSCSSForm.php` — the editors; route gated by `administer site configuration`.

Security posture: this is intentional admin-only code injection. Gated by `administer site configuration` (a user who already has effective code access). Not a vulnerability, but note: output files are world-readable in public://, and the JS/CSS is emitted verbatim — only grant to trusted operators.
