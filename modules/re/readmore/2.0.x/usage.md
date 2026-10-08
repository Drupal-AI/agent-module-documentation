Readmore adds a single field formatter (`readmore`) for text fields that displays a trimmed preview with client-side *Read more* / *Read less* toggle links.

---

The module provides one plugin, `ReadmoreFormatter` (`@FieldFormatter id="readmore"`), for the core
`text`, `text_long`, and `text_with_summary` field types. You select it on an entity's *Manage display*
tab (or in Views). Formatter settings (config schema `field.formatter.settings.readmore`) are:
`trim_length` (default 500 chars — text shorter than this is shown untouched), `trim_on_break` (cut at a
`<!--break-->` delimiter instead of the length), `show_readmore`, `show_readless`, `ellipsis` (append
`…`), and `wordsafe` (truncate on a word/tag boundary). At render time `viewElements()` truncates via the
helper `readmore_truncate_string()` — a wordsafe truncator that prefers to cut at `</p>`, `<br>`, or
sentence boundaries and honors `<!--break-->`; it also bails out (returns text unchanged) if the field's
text format contains the legacy `php_code` filter and the text has `<?`. Output uses a `readmore`
theme hook (`templates/readmore.html.twig`) with a `.readmore-summary` + `.readmore-text` div pair, and
attaches the `readmore/readmore` library (jQuery + CSS) that toggles between the two. There is no admin
settings page, no permission, and no Drush command — it is purely a display formatter.

---

- Show a trimmed teaser of a Body field with a *Read more* link that expands it inline (no page reload).
- Add an accompanying *Read less* link to collapse the expanded text again.
- Trim a long-text field to a fixed character count (e.g. 300 characters).
- Trim at an editor-placed `<!--break-->` marker instead of a character count.
- Append an ellipsis (`…`) to the trimmed preview.
- Truncate on a word boundary so the preview doesn't cut mid-word.
- Truncate on an HTML tag/paragraph boundary (`</p>`, `<br>`) to avoid broken markup.
- Use the formatter on a `text_with_summary` (Body) field.
- Use the formatter on a `text_long` field.
- Use the formatter in a View's field configuration by choosing the *Readmore* formatter.
- Provide expandable descriptions on teaser/card listings.
- Show truncated comment or review bodies with an expand toggle.
- Give FAQ answers a collapsed preview with a *Read more* toggle.
- Present long product descriptions collapsed by default on listing pages.
- Configure per-view-mode trimming (short trim on teaser, full text on default).
- Toggle whether the *Read more* link is shown at all (preview-only, no expand).
- Toggle whether the *Read less* link is shown when expanded.
- Style the summary/full-text blocks via the `.readmore-summary` / `.readmore-text` classes.
- Override the `readmore` theme hook / `readmore.html.twig` template in a theme.
- Leave `trim_length` blank/large to effectively disable trimming for a given display.
- Provide a lightweight expand/collapse without a heavier JS accordion module.
