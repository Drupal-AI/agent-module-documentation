<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Making a library attachable — the `filter-selector-*` library-definition convention

The module's one extension point is a pair of keys you add to a library entry in any
`MODULE.libraries.yml` or `THEME.libraries.yml`. A library that carries one of them becomes
attachable by the "Library scanner" filter whenever content in a filtered format contains an element
matching the selector. Nothing else — no PHP, no config — is needed; the filter discovers the keys
on its own.

All logic lives in `src/Plugin/Filter/LibraryAttach.php`.

## The two keys

```yaml
# In my_module.libraries.yml
my_chart:
  js:
    js/chart.js: {}
  css:
    component:
      css/chart.css: {}
  filter-selector-css: 'table.chart, div.chart'   # CSS — converted to XPath internally

my_widget:
  js:
    js/widget.js: {}
  filter-selector-xpath: '//table[@class="widget"]'  # raw XPath — used verbatim
```

- `filter-selector-css` — a CSS selector (comma-separated groups allowed). Converted to XPath by
  `Symfony\Component\CssSelector\CssSelectorConverter::toXPath()` (`LibraryAttach.php:129`). This is
  why composer requires `symfony/css-selector`.
- `filter-selector-xpath` — a raw XPath expression, used exactly as written (`LibraryAttach.php:126`).
- **Precedence:** if a library defines both, `filter-selector-xpath` wins (`filter-selector-css` is
  only read in the `elseif`, `LibraryAttach.php:125-130`). A selector must be non-empty to register.

After adding or changing a selector, rebuild caches (`drush cr`) — the selector map is cached (see
below).

## How discovery works — `getLibrarySelectors()` (`LibraryAttach.php:109`)

1. Builds the extension list: `array_merge(['core'], $modules, [$active_theme])` where `$modules =
   array_keys($this->moduleHandler->getModuleList())` and `$active_theme =
   $this->themeManager->getActiveTheme()->getName()` (`LibraryAttach.php:118-120`).
2. For each extension, `$this->libraryDiscovery->getLibrariesByExtension($extension)` returns its
   parsed libraries; each entry is checked for the two keys.
3. Matches are stored in a flat map keyed by `"{extension}/{library_name}"`, e.g.
   `my_module/my_chart`, value = the XPath string.
4. The whole map is cached in `cache.data` under key `__METHOD__`
   (`Drupal\library_attach\Plugin\Filter\LibraryAttach::getLibrarySelectors`), `Cache::PERMANENT`,
   with the `library_info` cache tag (`LibraryAttach.php:135`) — so clearing library info (which core
   does on `drush cr`) also clears this map.

**Scope gotcha:** only `core`, **enabled** modules, and the single **active** theme are scanned. A
library declared in a base theme, in a disabled module, or in a theme that is not the one rendering
the page will NOT be discovered. Put the `filter-selector-*` key in the extension whose library you
actually want attached, and make sure that extension is enabled / active on the render.

## How matching works — `process($text, $langcode)` (`LibraryAttach.php:75`)

```php
$dom = Html::load($text);
$xpath = new \DOMXPath($dom);
foreach ($library_selectors as $library => $selector) {
  if ($xpath->query($selector)->count()) {
    $result->addAttachments(['library' => [$library]]);
  }
}
```

- The content HTML is parsed with `Html::load()` (needs `ext-dom`) and queried with `\DOMXPath`.
- Any non-zero match count attaches that library via `FilterProcessResult::addAttachments()`. The
  returned `FilterProcessResult` wraps the **unchanged** text — this filter adds attachments only, it
  does not rewrite content (despite the `TYPE_TRANSFORM_IRREVERSIBLE` type).
- The attachment name is the full `extension/library_name` map key, so the library resolves through
  Drupal's normal asset dependency/aggregation pipeline.
- Selectors come from library YAML (developer-controlled), never from the content, so the XPath
  expression is not attacker-influenced.

## Discoverability — `tips($long)` (`LibraryAttach.php:95`)

The filter's help text says it "scans HTML for relevant libraries." When `$long` is TRUE (the full
text-format tips page) it also appends the list of currently attachable library keys —
`implode(', ', array_keys($this->getLibrarySelectors()))` — a quick way to confirm your selector was
picked up.

## Minimal working example (from the test module)

`tests/modules/library_attach_test/library_attach_test.libraries.yml`:

```yaml
test-css:
  css:
    component:
      css/test.css: {}
  filter-selector-css: 'table.test1, table.test2, div.test3'
test-xpath:
  css:
    component:
      css/test.css: { }
  filter-selector-xpath: '//table[@class="test4"]'
```

Content containing `<table class="test1">…</table>` attaches `library_attach_test/test-css`; content
containing `<table class="test4">…</table>` attaches `library_attach_test/test-xpath`
(`tests/src/Kernel/LibraryAttachTest.php`).
