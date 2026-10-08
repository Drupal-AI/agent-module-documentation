<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a CKEditor 5 toolbar button that wraps selected text (or an image) in a `<tippy>` element carrying tooltip content, rendered on the front end as a Tippy.js/Popper tooltip shown on hover.

---

CKEditor Tippy Tooltip ships a CKEditor 5 plugin (`tippyTooltip.TippyTooltip`) whose toolbar button opens a dialog (`/ckeditor_tippy/dialog/tippy/{editor}`, `TooltipEditorDialog`) where the editor types the visible text and the tooltip text; on save it emits a `<tippy data-tippy-content="…" class="tippy-tooltip-text">` element (allowed elements also cover `<span>` and `<img data-tippy-content>`). A text-format **filter** (`tippy_filter`, "Insert Popper when tippy is present") attaches the Tippy.js and Popper libraries only to pages whose rendered text contains a `</tippy>` element, loading Popper from a local `libraries/popperjs` copy if present, otherwise from a CDN. A global settings form (`/admin/config/content/ckeditor-tippy`, `CkeditorTooltipSettingsForm`, permission `administer ckeditor tippy`) stores Tippy behaviour options — `follow_cursor`, `prevent_overflow`, `placement`, `fallback_placement`, `interactive` — in `ckeditor_tippy.settings`, which the front-end JS reads to initialise tippy instances. The dialog runs the tooltip text through `check_markup()` when a value/format pair is supplied. The module also provides CKEditor4→5 upgrade plugin mappings for migrating sites. To use it: enable the module, add the Tippy Tooltip button to a text format's CKEditor 5 toolbar, and enable the tippy filter on that format.

---

- Add hover tooltips to words or phrases directly from the CKEditor toolbar.
- Attach a tooltip to an inline image (`<img data-tippy-content>`).
- Give editors a dialog to enter both the visible text and the tooltip text.
- Render tooltips with the accessible, well-tested Tippy.js/Popper library.
- Load Tippy/Popper only on pages that actually contain a tooltip (via the filter).
- Self-host Popper from `libraries/popperjs` instead of the CDN.
- Set a default tooltip placement (top/right/bottom/left).
- Make tooltips follow the mouse cursor (both axes, horizontal, or vertical).
- Prevent tooltips from overflowing the viewport boundary.
- Prevent fallback placement flipping when the preferred side doesn't fit.
- Allow interactive tooltips whose content can be hovered and clicked.
- Provide inline glossary/definition popups in body content.
- Show contextual help or footnotes on hover without leaving the page.
- Standardise tooltip styling site-wide through one settings form.
- Migrate a CKEditor 4 tooltip setup to CKEditor 5 (upgrade plugin mapping).
- Gate tooltip configuration behind the `administer ckeditor tippy` permission.
- Restrict who can open the tooltip dialog to users of the relevant text format.
- Add tooltips inside any rich-text field using a tippy-enabled format.
- Keep markup clean: tooltips are a single semantic `<tippy>` element.
- Combine with allowed `<span>` tags for finer inline wrapping.
