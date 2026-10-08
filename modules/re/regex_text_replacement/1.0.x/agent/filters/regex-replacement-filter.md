<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter: Regex Text Replacement

Plugin ID `regex_text_replacement_regex_replacement`
(class `Drupal\regex_text_replacement\Plugin\Filter\RegexReplacementFilter`, extends
`FilterBase`). Type `TYPE_TRANSFORM_REVERSIBLE`, default weight `-10`. Single setting
`replacements` (a string), schema `filter_settings.regex_text_replacement_regex_replacement`.

## Enabling and configuring

There is no admin route of its own — the filter is configured per text format:

1. `admin/config/content/formats`, edit a text format.
2. Enable **Regex Text Replacement** (requires the `administer filters` permission).
3. In the filter's **Replacements** textarea, add one rule per line.

## Rule syntax

One rule per line, `pattern||replacement`:

- `pattern` is a complete PCRE pattern including delimiters and modifiers, passed
  verbatim as the first argument to `preg_replace`, e.g. `/<h2([^>]*)>(.*?)<\/h2[^>]*>/mi`.
- `replacement` is the replacement string. As a convenience, `(1)`, `(2)`, … are
  rewritten to PCRE backreferences `$1`, `$2`, … before the replace runs (via
  `preg_replace_callback('/\((\d*)\)/', …)`). So `<h3(1)>(2)</h3>` becomes
  `<h3$1>$2</h3>`.

Example (replace h1/h2 with h3):

```
/<h[1|2]([^>]*)>(.*?)<\/h[1|2][^>]*>/mi||<h3(1)>(2)</h3>
```

## Processing behaviour (`process()`)

- The `replacements` string is split on `"\n"`; each non-empty line is processed.
- A line without `||` is skipped and logged as a warning
  (`Skipping invalid replacement. Missing "||" separator`).
- `(n)` placeholders in the replacement are converted to `$n`. If that conversion
  returns `null`, the line is skipped and logged.
- `preg_replace($pattern, $replacement, $text)` is applied to the running `$text`.
  If it returns `null` (a PCRE error — bad pattern, backtrack limit hit, etc.) the
  line is skipped and logged with `preg_last_error_msg()`; otherwise `$text` is
  updated. Rules apply cumulatively, in listed order.
- Returns `new FilterProcessResult($text)`.

Because failures degrade to "no replacement" (logged, not thrown), a malformed
pattern will not white-screen the page; it silently leaves the text unchanged.

## Practical notes

- Being `TYPE_TRANSFORM_REVERSIBLE`, disabling the filter restores the original
  rendered output — the stored text is never modified.
- Weight `-10` makes it run early in the filter chain. If a replacement injects
  markup, ordering relative to "Limit allowed HTML tags" (filter_html) determines
  whether that markup is subsequently sanitised.
- The pattern is a raw PCRE string, so authors control delimiters and modifiers.
  The `/e` (PREG_REPLACE_EVAL) modifier no longer exists in PHP 7+, so a pattern
  cannot execute PHP; catastrophic backtracking on large content is the real
  operational risk.
