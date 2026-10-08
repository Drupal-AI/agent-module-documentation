<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CKEditor Tippy Tooltip

## Enable on a text format

1. Enable the module (depends on `ckeditor5`).
2. On a text format's editor config (`/admin/config/content/formats/manage/<format>`), drag the
   **Tippy Tooltip** button into the CKEditor 5 toolbar.
3. Ensure the format's **Limit allowed HTML tags** filter permits the tippy elements (from
   `ckeditor_tippy.ckeditor5.yml`): `<span>`, `<tippy>`,
   `<tippy data-tippy-content class="tippy-tooltip-text">`, `<img data-tippy-content>`.
4. Enable the **"Insert Popper when tippy is present"** filter (`tippy_filter`) on the format so the
   Tippy.js/Popper libraries are attached to rendered content that contains a tooltip.

## The editor dialog

Button → `Drupal.ckeditor5.openDialog` → route `ckeditor_tippy.tippy_tooltip_dialog`
(`/ckeditor_tippy/dialog/tippy/{editor}`, `TooltipEditorDialog`). Access:
`use text format {editor}`. Two fields: **body text** (visible text; disabled/prefilled when text was
selected, max 2048) and **tooltip text** (hover content, max 2048). On save it returns an
`EditorDialogSave` with `data-title` and `data-text`; the tooltip text is passed through
`check_markup()` when submitted as a value/format pair.

## Global settings (`ckeditor_tippy.settings`)

Form `CkeditorTooltipSettingsForm`, route `ckeditor_tippy.settings`
(`/admin/config/content/ckeditor-tippy`, permission **`administer ckeditor tippy`**). Read by the
front-end JS to initialise tippy instances.

| Key | Type | Meaning |
|---|---|---|
| `follow_cursor` | radios | `Default`(0) / `initial` / `TRUE` (both axes) / `horizontal` / `vertical` — how the tooltip tracks the cursor. |
| `prevent_overflow` | checkbox | Keep the tooltip inside the viewport boundary. |
| `placement` | select | `top` / `right` / `bottom` / `left`. |
| `fallback_placement` | checkbox | Prevent flipping to the opposite side when the preferred side doesn't fit. |
| `interactive` | checkbox | Allow the tooltip content to be hovered/clicked without hiding. |

(No `config/schema` ships; the settings object is a plain `ConfigFormBase` config.)

## Library loading

`tippy_filter::process()` attaches `ckeditor_tippy/tippyjs` plus Popper — `ckeditor_tippy/popper_local`
when `libraries/popperjs/dist/umd/popper.min.js` exists, otherwise `ckeditor_tippy/popper_remote`
(CDN). Attachment only happens when the rendered text contains `</tippy>`, so tooltip assets stay off
pages that don't use them.
