<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ace_filter` text filter and `ace_formatter`

Two ways to *display* highlighted code (distinct from the editor plugin, which is for *editing*).

## `ace_filter` — `<ace>` tags in body text

Plugin `\Drupal\ace_editor\Plugin\Filter\AceFilter` (id `ace_filter`, type
`TYPE_MARKUP_LANGUAGE`). Enable it on a text format
(`filter.format.<format>.filters.ace_filter.status: true`). Then in content you wrap code:

```html
<ace syntax="php" theme="monokai">
&lt;?php echo "hello"; ?&gt;
</ace>
```

- `AceFilter::process()` finds every `<ace …>…</ace>` block (regex, dot-matches-newline),
  replaces it with a `<pre id="ace-editor-inline<uniqid>"></pre>`, and attaches
  `drupalSettings.ace_filter` describing each instance so the JS turns it into an Ace view.
- **Per-tag attributes override the filter's settings.** Any attribute you put on the `<ace>`
  tag (`theme`, `syntax`, `height`, `width`, `font_size`, `line_numbers`, …) is parsed by
  `tagAttributes()` and merged over the filter defaults for that one block. Values `1`/`0`/
  `TRUE`/`FALSE` are cast to int. Hyphens in attribute names become underscores.
- If the tag's `theme`/`syntax` names a real `ace_editor/theme.<x>` / `ace_editor/mode.<x>`
  library, it is attached; otherwise the default applies.

### Filter default settings

Defined in the `@Filter` annotation `settings` (independent of `ace_editor.settings`):

| Key | Default |
|---|---|
| `theme` | `cobalt` |
| `syntax` | `html` |
| `height` / `width` | `500px` / `700px` |
| `font_size` | `12pt` |
| `line_numbers` | `TRUE` |
| `show_invisibles` | `FALSE` |
| `print_margins` | `TRUE` |
| `auto_complete` | `TRUE` |
| `use_wrap_mode` | `TRUE` |

Stored in config at `filter.format.<format>.filters.ace_filter.settings.<key>`. Read:
```bash
drush cget filter.format.<format> filters.ace_filter.settings
```

## `ace_formatter` — read-only field display

Plugin `\Drupal\ace_editor\Plugin\Field\FieldFormatter\AceFormatter` (id `ace_formatter`).
- `field_types`: **`text_with_summary`, `text_long`** only.
- Renders each item as a `readonly` `<textarea>` inside `<div class="ace_formatter">`, attaching
  `ace_editor/formatter` and passing its settings as `drupalSettings.ace_formatter`.
- `defaultSettings()` seeds from `ace_editor.settings`; each display can override theme, syntax,
  height, width, font_size, line_numbers, print_margins, show_invisibles, use_wrap_mode.
- Set it on a view mode: `entity_view_display.<…>` → `content.<field>.type: ace_formatter`.

Both display paths need the Ace JS library present (see
[configure/setup.md](../configure/setup.md)).
