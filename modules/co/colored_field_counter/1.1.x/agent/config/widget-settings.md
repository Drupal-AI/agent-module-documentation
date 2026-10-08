<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget settings, threshold math & JS behaviour

There is **no admin settings page**. Every option is a Field API **widget setting**, configured at
`admin/structure/…/form-display` (Manage form display) by choosing a Colored Field Counter widget
and expanding its settings gear. Values are stored in the entity-form-display config of that bundle.
The counter markup is emitted as `#field_suffix`; the dynamic values reflected into it are
integer-cast counts, generated uuids, or `t()`-placeholder strings, and core applies its standard
admin markup filtering to any `#field_suffix` before output.

## Simple family (`BaseSimpleTrait`)

`defaultSettings()`: `char_reco = 60`, `char_margin_min = 10`, `char_margin_max = 10`.

`settingsForm()` fields (all `#type => number`):

| Setting | Bounds | Meaning |
|---------|--------|---------|
| `char_reco` | min 1, `#required`; `#max` = field `max_length` when defined | Recommended char count; counter turns red beyond it |
| `char_margin_min` | 0–100 | Lower margin %: point at which the counter turns orange |
| `char_margin_max` | 0–100 | Upper margin %: hard input lock as a % above `char_reco` |

`makeAttachement()` threshold math (empty margins fall back to 10, empty reco to 60):

```
orange = reco * (100 - min) / 100      // counter turns orange above this
red    = reco                          // counter turns red above this
lock   = reco * (100 + max) / 100      // element['#maxlength'] = (int) lock
```

Emits `drupalSettings.counter[uuid] = { orange, red }` and a `#field_suffix`
`<div class="counter" id="{uuid}"><span class="incochars"></span>/{reco} characters (recommended
value)<span class="incoerror">…too long…</span></div>`. `{reco}` is `(int)`-cast; the "too long"
message is a `t()` string.

**`simple_wysiwyg_summary`** overrides these with a per-group form: separate `summary_wrapper` and
`full_wrapper` setting groups (each with its own `char_reco`/margins, defaulting to 255), and the
summary group is skipped when the field's `display_summary` is FALSE. Note: for WYSIWYG fields the
`#maxlength` lock has no effect (CKEditor manages the textarea), matching the module's own docs.

## Complex family (`BaseCplxTrait`)

`defaultSettings()`: one empty `color_settings` row (`color/low/max` all `''`) plus `optimal_size = ''`.

`settingsForm()` builds:
- `optimal_size` (`#type => textfield`) — target char count for "optimal" render; defaults to 255
  (long) or the field `size` (short) when unset.
- A **3-row table** (`buildTable()`) with columns **Color** (`select`: Green/Orange/Red), **Low Limit**
  and **Max limit** (`textfield`). Row 0's `low` is disabled and shown as "Empty" (= 0); row 2's `max`
  is disabled and shown as "Field Max size" (= field max). A `processed_text` "How to configure"
  notice explains that limits may be absolute numbers or `NN%` of the field max/optimal size.

`makeAttachement()` resolves each row into numbers via `getNbChar()`:
- `%` values → `max_size * NN / 100`, rounded (floor for `max`, ceil for `low`); `max_size` is 255
  for short fields or `optimal_size`/1 000 000 for long.
- "Empty"/`0` low → `0`; "Field Max size"/`-1` max → 255 (short) or 1 000 000 (long).

Emits `drupalSettings.cplx_counter[uuid] = [ {color, low, max}, … ]` and a `#field_suffix` counter
div. For short fields the div shows `/255 max characters` and an `.incooptim` span
"The optimal size is {optimal_size} characters." (rendered through a `t()` `@nb` placeholder). For
long fields it shows `/{optimal_size} characters (recommended value)`. `settingsSummary()` /
`formatLine()` render a human-readable recap of each row.

**`cplx_wysiwyg_summary`** again splits into `summary_wrapper` / `full_wrapper` groups (each an
`optimal_size` + 3-row table), skipping the summary group when `display_summary` is FALSE.

## JavaScript counters

Two `Drupal.behaviors` — `simple_counter` (`js/counter.js`) and `counter_cplx`
(`js/counter-cplx.js`) — share the same structure:

- On attach, walk `div.counter, div.wysiwyg-counter`, find the paired input/textarea, compute the
  count and colour once; then bind `keyup` on `input.counter, textarea.counter`.
- Count = `value.replace(/(<([^>]+)>)/gi, "").length` (tags stripped) `+` newline count. An
  `isAltKey()` guard ignores non-printing keys (except Delete/46).
- CKEditor 4: on `CKEDITOR instanceReady`, bind the editor `key` event and recount from
  `editor.getData()`. CKEditor 5: bind `keyup` on `.ck-content.ck-editor__editable` and recount
  from the editable's HTML.
- `color()` writes the number with jQuery **`.text()`** (not `.html()`), toggles the `.incoerror`
  (and cplx `.incooptim`) span's `display`, and sets the parent colour with `.css("color", …)` using
  only the fixed keywords `red` / `orange` / `green` / `#333`. Simple JS compares the count to the
  `orange`/`red` numbers from `drupalSettings`; cplx JS selects the matching `[low, max]` row's
  colour (defaulting to green).
