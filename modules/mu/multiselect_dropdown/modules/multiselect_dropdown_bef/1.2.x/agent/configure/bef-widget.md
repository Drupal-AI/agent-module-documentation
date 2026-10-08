<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown BEF widget — configuration

## Making it available
On the exposed filter:
1. Expose the filter and enable **"Allow multiple selections"** (`expose.multiple`).
2. For a **taxonomy term** filter (`TaxonomyIndexTid`), also set the filter's *Selection
   type* to **Dropdown** (`type == 'select'`).
3. In the display's **Exposed Form** settings, use **Better Exposed Filters**; the
   "Multiselect Dropdown" widget then appears as a filter widget option for that filter.

`isApplicable()` enforces the rules above (BEF base applicability + `expose.multiple`; the
taxonomy `select`-type check for `TaxonomyIndexTid`).

## Options (`defaultConfiguration()` + `buildConfigurationForm()`)
Inherits the parent widget label/search settings, then adds:
- `label_aria` (required), `label_none`, `label_all`, `label_single`, `label_plural`
  (required label set; note `label_none` defaults to the all-label since in views "no
  selection" usually means "all").
- `label_select_all`, `label_select_none` — blank = omit those buttons.
- `label_close` — close button text (button always has an aria-label even if blank).
- `label_submit` — in-dialog submit button; blank = omit.
- `label_clear` — clear button; blank = omit.
- `search_title`, `search_title_display`, `search_placeholder`,
  `search_character_threshold` — search field (display/threshold shown only when
  `search_title` filled).
- `modal_type` (required radios) — `breakpoint` / `dialog` / `modal`
  (`Drupal\multiselect_dropdown\ModalType`).
- `modal_breakpoint` (number) — px width; visible/required only when `modal_type` is
  `breakpoint`.
- `default_open` (checkbox) — open on page load; visible only when `modal_type` is `dialog`.
- `persist_open` (checkbox) — keep the dialog open when the exposed form submits via AJAX.

## How it renders (`exposedFormAlter()`)
- Resolves the exposed/grouped identifier, then sets the form element:
  `#type = 'multiselect_dropdown'`, removes `#size`, sets `#hierarchy` (flattening options
  with `BetterExposedFiltersHelper::flattenOptions()` when hierarchical), and copies every
  `label_*` / `search_*` config onto the element.
- `#modal_breakpoint` = the integer breakpoint when `modal_type` is `breakpoint`, otherwise
  the `modal_type` string ('dialog'/'modal').
- Sets `#default_open` and `#persist_open`, and attaches `multiselect_dropdown/views`.
- A preprocess hook adds `data-multiselect-dropdown-persist-open` when persist-open is on and
  swaps in a views-specific wrapper aria-label (space to toggle, enter to submit, shift+enter
  to submit and jump to results).
