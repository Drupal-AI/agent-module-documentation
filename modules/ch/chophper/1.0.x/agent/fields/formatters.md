<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Chophper trimmed formatters

## Install & enable

```bash
composer require drupal/chophper   # pulls code-atlantic/chophper ^1.0
drush en chophper -y
```

Depends only on core **`text`** plus the Composer library `code-atlantic/chophper`. No
sub-modules, no permissions, no Drush commands, no site-wide config form.

## The two plugins

Both live in `src/Plugin/Field/FieldFormatter/` and use the PHP-attribute `#[FieldFormatter(...)]`.

| Plugin id | Label | Class (extends core) | Field types |
|---|---|---|---|
| `chophper_trimmed` | Trimmed (Chophper) | `ChophperTrimmedFormatter` (`TextTrimmedFormatter`) | `text`, `text_long`, `text_with_summary` |
| `chophper_summary_or_trimmed` | Summary or trimmed (Chophper) | `ChophperSummaryOrTrimmedFormatter` (`TextSummaryOrTrimmedFormatter`) | `text_with_summary` |

`chophper_trimmed` always truncates. `chophper_summary_or_trimmed` renders the field's manual
summary if `$item->summary` is non-empty, and only truncates `$item->value` when there is no
summary.

## Enable on a field

UI: *Structure → (entity/bundle) → Manage display* → pick a formatted-text field → set its
format to **Trimmed (Chophper)** or **Summary or trimmed (Chophper)** → click the gear to set the
options below.

Drush / config equivalent:

```bash
drush cset core.entity_view_display.node.article.teaser \
  content.body.type chophper_trimmed -y
drush cr
```

## Settings

From `defaultSettings()` (merged over the parent core formatter's settings):

| Setting key | Default | Meaning |
|---|---|---|
| `trim_length` | `600` (core default) | Maximum number of **units** to display; the unit is set by `truncate_by`. The core "trimmed limit" field, relabeled and with its `#field_suffix` removed. |
| `truncate_by` | `words` | Unit of truncation: `words`, `chars`, `sentences`, or `blocks` (top-level block elements). Select list. |
| `ellipsis` | `…` | String appended to truncated output. Free-text field. |
| `preserve_words` | `FALSE` | When truncating by `chars`, avoid splitting mid-word. No effect for other units. |

`settingsSummary()` adds "Truncate by: …", "Ellipsis: …" and (when set) "Preserve words" to the
Manage-display summary line. Config **schema** for these keys is in
`config/schema/chophper.schema.yml` (both types inherit `field.formatter.settings.text_trimmed`
and add `ellipsis`, `truncate_by`, `preserve_words`).

### Example view-display config

```yaml
# core.entity_view_display.node.article.teaser
content:
  body:
    type: chophper_trimmed
    label: hidden
    settings:
      trim_length: 40
      truncate_by: words
      ellipsis: ' …'
      preserve_words: false
```

## How rendering works (from source)

`viewElements()` builds one render element per field item:

```php
$elements[$delta] = [
  '#type'   => 'processed_text',   // core runs the text-format filters on this
  '#text'   => $item->value,
  '#format' => $item->format,
  '#langcode' => $item->getLangcode(),
];
```

It then merges the element type's default info (`elementInfo->getInfo('processed_text')`, giving
the standard `processed_text` pre_render that applies the filters) and **appends** its own
`preRenderSummary` callback, stashing the settings on the element (`#chophper_ellipsis`,
`#chophper_truncate_by`, `#chophper_preserve_words`, `#text_summary_trim_length`).

Because the callbacks run in order, the text format's filters execute **first**, and only then:

```php
public static function preRenderSummary(array $element): array {
  $element['#markup'] = Full::truncate(
    (string) $element['#markup'],
    (int) $element['#text_summary_trim_length'],
    [
      'ellipsis'      => $element['#chophper_ellipsis'],
      'truncateBy'    => $element['#chophper_truncate_by'],
      'preserveWords' => $element['#chophper_preserve_words'],
    ],
  );
  return $element;
}
```

`Chophper\Full::truncate()` parses the (already filtered) HTML with a DOM/HTML5 parser
(`Masterminds\HTML5` / `DOMDocument`) and re-serializes a balanced, truncated fragment — that is
the reason to use this over a naive substring: tags stay closed.

`chophper_summary_or_trimmed::viewElements()` differs only in that it sets `#text` to
`$item->summary` and skips the truncation callback when a summary is present.

## Notes / caveats

- Truncation happens **after** the text format runs, so the format's allowed-HTML / XSS filtering
  still applies, and the truncated string is placed back into `#markup` (still subject to core's
  renderer handling of `#markup`).
- `Full::$ellipsable_tags` (p, ul/ol/li, div, header, article, nav, section, footer, aside,
  dl/dt/dd) are where an ellipsis may be injected; `truncateBy: blocks` counts these block-level
  elements.
- `preserve_words` is only consulted for `truncateBy: chars`; for words/sentences/blocks it is
  ignored.
- Presentation-only: no routes, permissions, services, hooks, install steps or config objects
  beyond the per-display formatter settings.
