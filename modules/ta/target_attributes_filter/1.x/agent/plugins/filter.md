<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter plugin: `filter_target_attributes`

File: `src/Plugin/Filter/TargetAttributesFilter.php`
Class: `Drupal\target_attributes_filter\Plugin\Filter\TargetAttributesFilter`
Extends core `Drupal\filter\Plugin\FilterBase`, implements `ContainerFactoryPluginInterface`.

## Annotation

```
@Filter(
  id = "filter_target_attributes",
  title = @Translation("Add target attribute to links"),
  type = FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE,
  settings = {
    "filter_target_attribute" = "_self",
    "filter_target_method" = "all",
  }
)
```

- `TYPE_TRANSFORM_IRREVERSIBLE`: it rewrites the output markup (adds an attribute); the transform
  is not represented separately from the rendered result.
- Annotation defaults set `filter_target_attribute = _self` and `filter_target_method = all`. There
  is **no** `filter_target_replace` in the annotation.

## Dependency injection

- `create()` pulls `request_stack` from the container and passes it to the constructor, stored as
  `$this->requestStack`. Used only to read the site's HTTP host.

## `setConfiguration()`

```php
$this->settings += [
  'filter_target_attribute' => '_blank',
  'filter_target_method'    => 'all',
  'filter_target_replace'   => 1,
];
```

The `+=` only fills keys not already present. Because the annotation already supplies
`filter_target_attribute` (`_self`) and `filter_target_method` (`all`), those are **not**
overridden to `_blank` — the effective default target value is `_self`. The only key this line
actually introduces is **`filter_target_replace` = 1** (replace on by default).

## `settingsForm()`

Three elements bound to the three settings keys:

| Key | `#type` | Options / note |
| --- | --- | --- |
| `filter_target_attribute` | `select`, required | `_blank` (new window/tab), `_self` (same frame), `_parent` (parent frame), `_top` (full window) |
| `filter_target_method` | `radios`, required | `all` (All links), `internal` (Only internal links), `external` (Only external links) |
| `filter_target_replace` | `checkbox` | "Replace target attribute" — if checked, an existing `target` value is replaced |

Each `#default_value` reads from `$this->settings[...]`. The form is the standard per-text-format
filter settings section (no separate route).

## `process($text, $langcode): FilterProcessResult`

1. `$dom = Html::load($text)` — parses the fragment into a `DOMDocument` (**DOM-based, not regex/string
   building**).
2. `$internalHost = $this->requestStack->getMainRequest()->getHttpHost()` — the current request's
   host (e.g. `example.com`).
3. For each `<a>` in `$dom->getElementsByTagName('a')`:
   - **Replace guard:** `if (!filter_target_replace && $link->hasAttribute('target')) continue;` —
     when replace is off, links that already carry `target` are left untouched.
   - **Href guard:** `if ($href = trim($link->getAttribute('href')))` — links with an empty or
     whitespace-only `href` fall through and are skipped.
   - **Host:** `parse_url($href)`, then
     `preg_replace('/^www\./i', '', $url['host'] ?? $internalHost)` — strips a leading `www.` and
     defaults to the request host when the URL has no host component (so relative/anchor links are
     treated as internal). The `www.` strip is applied to the parsed link host only; the comparison
     is against the raw `$internalHost`, so a request host that itself carries `www.` will not
     equal a `www.`-stripped link host.
   - **Scope:** `internal` → `continue` when `$host !== $internalHost`; `external` → `continue`
     when `$host === $internalHost`; `all` → never continues.
   - **Apply:** `$link->setAttribute('target', $this->settings['filter_target_attribute'])`.
4. Returns `new FilterProcessResult(Html::serialize($dom))`.

## Notes for agents

- The filter only ever sets `target`. It does **not** add `rel="noopener"`/`rel="noreferrer"`, does
  not strip or alter `href`, and does not touch any other attribute or tag.
- Attribute values come from the fixed admin-chosen select value, and reading/writing/serializing
  goes through the DOM API + `Html::serialize`, matching core's own filter handling.
- Ordering matters: to add targets to sanitized markup, run this filter **after** core's "Limit
  allowed HTML tags" filter in the text format's filter order.
- `parse_url()` on a malformed `href` can return `false`; `$url['host'] ?? $internalHost` then
  yields the request host (link treated as internal). No fatal, just the internal-scope path.
