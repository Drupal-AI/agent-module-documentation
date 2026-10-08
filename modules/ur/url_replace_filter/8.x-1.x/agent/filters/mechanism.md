<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# url_replace_filter — filter mechanism & configuration

Single plugin: `\Drupal\url_replace_filter\Plugin\Filter\UrlReplaceFilter`
(`src/Plugin/Filter/UrlReplaceFilter.php`), `id: url_replace_filter`,
`type: TYPE_TRANSFORM_IRREVERSIBLE`, default setting `replacements = ""`.

## The rewrite (`process($text, $langcode)`)
```php
$settings = unserialize($this->settings['replacements'], ['allowed_classes' => FALSE]);
foreach ($settings as $setting) {
  if (!empty($setting['original'])) {
    $pattern = '!((<a\s[^>]*href)|(<img\s[^>]*src))\s*=\s*"' . preg_quote($setting['original']) . '!iU';
    if (preg_match_all($pattern, $text, $matches)) {
      $replacement = str_replace('%baseurl', rtrim(base_path(), '/'), $setting['replacement']);
      foreach ($matches[0] as $key => $match) {
        $text = str_replace($match, $matches[1][$key] . '="' . $replacement, $text);
      }
    }
  }
}
return new FilterProcessResult($text);
```

Key facts:
- **Regex over the raw markup string**, not a DOM parse. `preg_quote($setting['original'])`
  escapes the needle, so the original string cannot inject regex metacharacters.
- **Only two attributes** are targeted: `href` on `<a>` and `src` on `<img>`. Nothing else
  (`<script src>`, `<link href>`, `<source srcset>`, CSS `url()`, inline `style`, link text) is
  touched.
- Pattern is `i` (case-insensitive) and `U` (ungreedy). Group 1 captures the tag-and-attribute
  prefix (`<a ... href` or `<img ... src`); the match ends at the start of the original URL. The
  span replaced is exactly `<PREFIX>="<ORIGINAL...` up to and including the original prefix, which
  is rewritten to `<PREFIX>="<REPLACEMENT`. The tail of the URL and the rest of the tag survive
  unchanged.
- `str_replace($match, ...)` is global, so an identical prefix appearing several times is rewritten
  everywhere in one pass.
- Rules run **in stored order**; place the most specific `original` first
  (`http://example.com/somepath/` before `http://example.com/`). Include matching trailing slashes
  in both fields to avoid partial-prefix surprises.

## `%baseurl`
In the replacement string only, `%baseurl` is expanded to `rtrim(base_path(), '/')` — the site's
base path with the trailing slash removed. On a root install `base_path()` is `/`, so `%baseurl`
becomes the empty string; on a subdirectory install it becomes e.g. `/drupal`.

## Storage & schema
- Settings are a **PHP-serialized array of `['original' => ..., 'replacement' => ...]` rows**,
  stored as one string in the per-format filter setting `replacements`.
- Both the settings form and `process()` unserialize with `['allowed_classes' => FALSE]`, so no
  object instantiation occurs during unserialization.
- Config schema (`config/schema/url_replace_filter.schema.yml`): `filter_settings.url_replace_filter`
  → `replacements` typed simply as `string`.

## Settings form (`settingsForm` / `settingsFormValidate`)
- Rendered as a `details` element themed by `url_replace_filter_settings_form`
  (`templates/url-replace-filter-settings-form.html.twig`) into an Original/Replacement table.
- Existing rows are shown; up to **3 empty rows** are appended each save so more rules can be added.
- `settingsFormValidate` (an `#element_validate` callback) drops rows where both fields are empty,
  re-serializes, and — if nothing is left — shows a warning suggesting the filter be removed from
  the format. `hook_requirements` (`url_replace_filter.install`) similarly warns if the module is
  enabled but no format uses the filter.

## Configuration access
- No module-defined permissions. Editing a format's filter settings requires the **core
  `administer filters`** permission, which core marks as security-sensitive / trusted-roles-only.
- `configure` link points at `filter.admin_overview` (`/admin/config/content/formats`).

## Filter ordering guidance
- The filter reads and rewrites existing `<a>`/`<img>` markup; it must run at a point where those
  elements are present and where any HTML-restricting filter (e.g. "Limit allowed HTML tags") has
  already run. It returns a bare `FilterProcessResult` and does not re-mark or re-open the text for
  further filtering — it neither strips nor adds tags, only rewrites a leading attribute-URL span.
