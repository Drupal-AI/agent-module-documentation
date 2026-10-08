CKEditor Tooltips adds a CKEditor 5 toolbar button that lets editors attach a Tippy.js tooltip to selected text (or insert a small "i" info icon), and a global settings form that controls how those tooltips look and behave on the front end.

---

The module registers a CKEditor 5 plugin (`ckeditor_tooltips_ckeditor_tooltip`, toolbar item `CkeditorTooltip`) built from the bundled `js/build/CkeditorTooltip.js`; you add its icon to a text format's active toolbar under *Text formats and editors*. Editors select text (or none, for a default icon) and enter tooltip content in a popup, which is stored as `<span>` markup carrying `data-tippy-content` / `data-tooltip-*` attributes (the format's allowed elements are extended to permit these spans). On the front end, `hook_page_attachments_alter()` unconditionally attaches the Tippy.js + Popper library (`tippyjs`, v6.3.7, bundled under `js/vendor`) and passes the global settings to `drupalSettings.ckeditor_tooltips`, where `js/ckeditor_tooltips.js` initialises Tippy on the tagged spans. The settings form (`ckeditor_tooltips.settings`, at `/admin/config/content/ckeditor-tooltips`, permission `administer ckeditor tooltips`) exposes Tippy options: `follow_cursor`, `prevent_overflow`, `allow_html` (default on), `interactive` (default on), `max_width` (500), `skidding`/`distance` offsets, `trigger` (click/mouseenter/manual/focus/focusin), `animations` (none/fade/scale), and `custom_styling` (skip the module's bundled CSS so a theme can style tooltips). Defaults ship in `config/install/ckeditor_tooltips.settings.yml`; note there is **no** config schema file (a known TODO). It depends on core `ckeditor5`.

---

- Add hover/click tooltips to rich-text content directly from the CKEditor toolbar.
- Attach an explanatory tooltip to a selected word or phrase in a body field.
- Insert a standalone "i" info icon with a tooltip where no text is selected.
- Provide inline glossary-style definitions for jargon inside articles.
- Show footnotes or asides as tooltips instead of cluttering the page.
- Configure whether tooltips appear on click, hover (mouseenter), focus, or manually.
- Make tooltips interactive so users can hover into them and click links inside.
- Have the tooltip follow the mouse cursor (x, y, both, or initial).
- Constrain tooltip width via the max-width setting.
- Fine-tune tooltip position with skidding/distance offsets.
- Prevent tooltips from overflowing the viewport boundary (Popper preventOverflow).
- Choose a tooltip animation (none, fade, or scale).
- Disable the module's bundled tooltip CSS to fully theme tooltips yourself (`custom_styling`).
- Give content editors a consistent tooltip UX across all formats that enable the button.
- Add contextual help text to form-like content or documentation pages.
- Provide accessible-on-focus tooltips by setting the trigger to `focus`/`focusin`.
- Localize tooltip content per node since it lives in the field's HTML.
- Use Tippy.js styling/animations without hand-wiring the library into a theme.
- Enable the tooltip button only on specific text formats (per-format toolbar control).
- Restrict who can change global tooltip behaviour via the `administer ckeditor tooltips` permission.
- Serve tooltips from the bundled Tippy/Popper vendor files (no external CDN).
