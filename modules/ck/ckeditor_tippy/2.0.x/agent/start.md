<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Tippy Tooltip — agent index

CKEditor 5 button that wraps text/images in a `<tippy>` element rendered as a Tippy.js/Popper
tooltip on hover. Depends on `ckeditor5`. Global options at `/admin/config/content/ckeditor-tippy`
(no `configure` in info.yml; permission `administer ckeditor tippy`).

- **Enable it on a format, the settings-form options, the filter, the dialog, allowed elements** →
  [configure/settings.md](configure/settings.md)

Key facts:
- CKEditor 5 plugin `tippyTooltip.TippyTooltip` (def `ckeditor_tippy.ckeditor5.yml`,
  PHP `Plugin/CKEditor5Plugin/TippyTooltip`). Allowed elements: `<span>`,
  `<tippy>`, `<tippy data-tippy-content class="tippy-tooltip-text">`, `<img data-tippy-content>`.
- Dialog route `ckeditor_tippy.tippy_tooltip_dialog` `/ckeditor_tippy/dialog/tippy/{editor}`
  (`TooltipEditorDialog`), `_custom_access` = `use text format {editor}`. Emits `data-title`/`data-text`;
  runs `check_markup()` on the tooltip text when a value/format is supplied.
- Filter plugin `tippy_filter` (TYPE_MARKUP_LANGUAGE) attaches `ckeditor_tippy/tippyjs` + Popper
  (`popper_local` if `libraries/popperjs/dist/umd/popper.min.js` exists, else `popper_remote`) only
  when the text contains `</tippy>`.
- Settings form `CkeditorTooltipSettingsForm` → `ckeditor_tippy.settings`: `follow_cursor`,
  `prevent_overflow`, `placement`, `fallback_placement`, `interactive`. Route
  `ckeditor_tippy.settings` (`_permission: administer ckeditor tippy`).
- Ships CKEditor4→5 upgrade mapping (`Plugin/CKEditor4To5Upgrade/TippyTooltip`).
