<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `auto_link_formatter` field formatter

Source: `src/Plugin/Field/FieldFormatter/AutoLinkFormatter.php` — class `AutoLinkFormatter extends
Drupal\Core\Field\FormatterBase`.

## Plugin definition

```
@FieldFormatter(
  id = "auto_link_formatter",
  label = "Auto Link (Convert URLs to Links)",
  field_types = { "string", "text_long", "text", "string_long" }
)
```

So it appears in the *Format* dropdown on **Manage display** (and in Layout Builder block/field
settings) for any of those four field types.

## Install / enable

```
drush en auto_link -y
drush cr
```

Then on *Structure → Content types → … → Manage display* (or a Layout Builder field block), set an
eligible field's **Format** to *Auto Link (Convert URLs to Links)*.

## The one setting

`defaultSettings()` returns `['open_new_tab' => TRUE]` (plus parent defaults). `settingsForm()`
renders a single checkbox:

- **`open_new_tab`** (checkbox, *"Open links in new tab"*, default **TRUE**) — when on, generated
  anchors get `target="_blank"`. `rel="noopener noreferrer"` is emitted regardless.

`settingsSummary()` shows *"Opens links in a new tab."* or *"Opens links in the same tab."*.

The module ships **no config schema** for this setting; it is stored as formatter third-party-free
settings inside the entity view-display config (`core.entity_view_display.*`). An exported display
looks like:

```yaml
content:
  field_website:
    type: auto_link_formatter
    label: above
    settings:
      open_new_tab: true
    third_party_settings: {}
```

## How links are built (`viewElements()`)

For each item with a non-empty `$item->value`:

1. `preg_replace_callback` runs the pattern
   `/(?<!["\'])(?<!\])\b(?:https?:\/\/|www\.)[^\s<]+/i` over the value. The two look-behinds skip
   matches immediately preceded by a quote or a `]`; matching stops at the first whitespace or `<`.
2. In the callback, a match starting with `www.` is prefixed with `http://` to form the `href`.
3. It returns `<a href="{escaped-url}" {target}rel="noopener noreferrer">{escaped-original-match}</a>`
   where `{target}` is `target="_blank" ` only when `open_new_tab` is on. Both the href and the
   visible text are escaped with `htmlspecialchars($url, ENT_QUOTES, 'UTF-8')`.
4. The full string is passed through `nl2br($text, FALSE)` (XHTML off → `<br>`) to preserve line
   breaks, then returned as the formatter's rendered `#markup`.

## Operating notes / limits

- **Plain-text fields only make sense.** Because the regex stops at `<`, and the module targets
  string/text field types, it is intended for values without existing markup.
- **URL detection is greedy up to whitespace/`<`.** Trailing punctuation (`)`, `.`, `,`) inside a URL
  becomes part of the link; there is no trailing-punctuation trimming.
- **No caching metadata added** beyond core formatter defaults; output depends only on the stored
  value and the `open_new_tab` setting.
- No JavaScript or CSS library is attached — the `target`/`rel` attributes are inline in the markup.
- The declared `drupal:filter` dependency is not exercised in code; the formatter does not run the
  field's text format. It renders the raw stored value with only the URL-wrapping transformation
  applied.
