# Configure the Readmore formatter

Set on *Manage display* (`/admin/structure/types/manage/<bundle>/display`) or in a View's field: pick
**Readmore** as the formatter for a `text`, `text_long`, or `text_with_summary` field, then open the gear.

## Settings (config schema `field.formatter.settings.readmore`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `trim_length` | integer | `500` | Char count to trim to. Field text **shorter** than this renders untouched (no toggle). Blank/large ≈ no trim. |
| `trim_on_break` | boolean | `TRUE` | If `<!--break-->` is present in the text, cut there instead of at `trim_length`. |
| `show_readmore` | boolean | `TRUE` | Append a *Read more* link to the preview. |
| `show_readless` | boolean | `FALSE` | Append a *Read less* link to the expanded text. |
| `ellipsis` | boolean | `TRUE` | Append `…` after the trimmed preview. |
| `wordsafe` | boolean | `FALSE` | Truncate on a word / tag / sentence boundary rather than mid-character. |

Defaults come from `ReadmoreFormatter::defaultSettings()`. There is **no** global config page and **no**
`configure` route — everything is per-formatter-instance display config.

## Rendering behavior (`viewElements()`)

- Only fields where `mb_strlen($value) > trim_length` get trimmed + toggle links; shorter values render
  as plain `#markup`.
- Truncation is done by `readmore_truncate_string($text, $format, $size, $wordsafe, $use_break)` in
  `readmore.module`:
  - Honors `<!--break-->` (sets size to the delimiter offset) when `$use_break`.
  - `wordsafe` mode prefers to cut at `</p>`, then `<br />` / `<br>` (and `\n` if `filter_autop` is on),
    then sentence terminators (`. `, `! `, `? `, `。`, `؟`).
  - If a `php_code` filter format exists and the text contains `<?`, the text is returned **unchanged**.
- The preview and full text are wrapped by the `readmore` theme hook (`templates/readmore.html.twig`:
  `.readmore-summary` + `.readmore-text` divs). The `readmore/readmore` library (jQuery, `core/once`,
  CSS/JS under `assets/`) toggles visibility client-side.

## Theming

Override the `readmore` theme hook or copy `templates/readmore.html.twig` into your theme. Variables:
`summary` (trimmed markup incl. links/ellipsis) and `text` (full markup). Restyle via `.readmore-summary`,
`.readmore-text`, `.readmore-link`, `.readless-link`.

## Caveats (from README)

- Works on long-text fields, not short `text` in practice.
- In a View's Edit/Preview mode the *Read more* link may not stick (works on the live page).
