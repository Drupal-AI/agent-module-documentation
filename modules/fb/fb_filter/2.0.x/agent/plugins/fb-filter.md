<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Facebook filter" text-format filter

## Install & enable

```bash
composer require drupal/fb_filter
drush en fb_filter -y
```

Only dependency is core **`filter`** (`fb_filter.info.yml`: `dependencies: - drupal:filter`). No
sub-modules, no permissions of its own, no services, no Drush commands.

## The plugin

`FbFilter` (`src/Plugin/Filter/FbFilter.php`) extends core `Drupal\filter\Plugin\FilterBase`. Its
`@Filter` annotation:

- `id = "fb_filter"`
- `title = @Translation("Facebook filter")`
- `description = @Translation("Convert Facebook #hashtags into links")`
- `type = Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` — a display-time
  transform; it changes rendered output only, never the stored source text.
- `settings = { "link_hashtags_target" = "none" }` — default value of the one setting.

Class constant: `FbFilter::SITE = 'https://www.facebook.com'` (the link base URL).

## Enable it on a text format

A filter has **no dedicated settings page**; you turn it on per text format.

UI path: *Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → **Configure** a format (e.g. *Basic HTML*) → under **Enabled
filters** tick **Facebook filter** → set the gear option below → check the **Filter processing
order** tab → **Save configuration**.

Because it re-introduces `<a>` markup, order it **after** core's *Limit allowed HTML tags* filter (so
the anchors it adds are not stripped or so the format policy is applied first as you intend). Content
in the format then has its `#hashtags` linked automatically on display.

## The one setting

`settingsForm()` builds a single select, `link_hashtags_target`:

| Value | Label | Effect |
|---|---|---|
| `none` | *No* (default) | Links open in the same tab (no `target`). |
| `_blank` | *Yes* | Adds `target="_blank"` to each hashtag link. |

Config schema `config/schema/fb_filter.schema.yml` types this as `filter_settings.fb_filter` →
`link_hashtags_target: string` with an `enum` of `none` / `_blank`. The value is stored in the text
format's own config (`filter.format.<id>.filters.fb_filter.settings`), like any other filter setting.

`tips($long)` returns *"Facebook #hashtags turn into links automatically."* for the editing help.

## The transform (`process()`)

```php
public function process($text, $langcode) {
  $target = '';
  if ('_blank' === $this->settings['link_hashtags_target']) {
    $target = ' target="_blank"';
  }
  $text = preg_replace(
    '/(^|\s)#(\w*[\p{M}\p{L}]+[\p{M}\p{L}]*)/u',
    '\1<a class="facebook-hashtag"' . $target . ' href="' . self::SITE . '/hashtag/\2">#\2</a>',
    (string) $text
  );
  return new FilterProcessResult($text);
}
```

- **Match:** group 1 is line start or a whitespace char; group 2 is the hashtag body —
  `\w*[\p{M}\p{L}]+[\p{M}\p{L}]*` (word chars plus Unicode letters/marks, so accented hashtags work).
  The `#` must contain at least one letter/mark, so a bare `#` or `#123`-only token is not matched.
- **Replacement:** the leading whitespace is preserved (`\1`), then a fixed anchor:
  `<a class="facebook-hashtag"[ target="_blank"] href="https://www.facebook.com/hashtag/<tag>">#<tag></a>`.
  The captured tag (`\2`) is used both in the `href` and as the visible link text.
- **Everything else** in `$text` is left as-is; the filter only inserts these anchors and does not
  touch existing markup. Output is wrapped in a `FilterProcessResult`.
- Inputs are only `$text` (the pipeline text) and `$this->settings` — no request or global data is
  read.

## Operating notes

- Style the links via the stable `.facebook-hashtag` class in your theme.
- Toggle the filter on/off per format to enable or stop hashtag linking without editing content.
- A unit test (`tests/src/Unit/FbFilterTest.php`) pins the exact output for `#hello`:
  `<a class="facebook-hashtag" href="https://www.facebook.com/hashtag/hello">#hello</a>`.
