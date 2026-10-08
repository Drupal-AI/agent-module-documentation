# CKEditor Tooltips — agent index

A CKEditor 5 plugin that lets editors attach a **Tippy.js** tooltip to selected text (or insert an
"i" icon), plus a global settings form for tooltip appearance/behaviour. Depends on core `ckeditor5`.
Config UI at `/admin/config/content/ckeditor-tooltips` (`configure: ckeditor_tooltips.settings`).
No Drush. **No config schema file** (known TODO).

- **The settings form: every Tippy option key, defaults, how the plugin/format wiring works, and the
  front-end attach flow** → [configure/settings.md](configure/settings.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- CKEditor5 plugin id `ckeditor_tooltips_ckeditor_tooltip`, toolbar item `CkeditorTooltip`
  (`ckeditor_tooltips.ckeditor5.yml`); build artifact `js/build/CkeditorTooltip.js`.
- Tooltip markup: `<span data-tippy-content ...>` (allowed elements added to the format).
- `hook_page_attachments_alter()` always loads library `tippyjs` (Tippy 6.3.7 + Popper, bundled in
  `js/vendor`) and sets `drupalSettings.ckeditor_tooltips`.
- Defaults in `config/install/ckeditor_tooltips.settings.yml`; `allow_html`, `interactive` default 1.
