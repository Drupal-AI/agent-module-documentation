# Provider hook API — build a font provider

fontyourface has **no plugin type**. A font provider is a plain submodule that implements a
few hooks (discovered via `ModuleHandler::invokeAllWith`/`invoke`). The provider machine name
becomes the font `pid`. There is no `fontyourface.api.php`; these hooks are inferred from the
core code that invokes them and from the shipped provider submodules.

## `hook_fontyourface_api()`  (required to appear as a provider)
Return metadata announcing the provider. Its presence makes the module show up in the import
list and sets its module weight to 10. Example:
```php
function my_provider_fontyourface_api() {
  return ['version' => '3', 'name' => 'My Provider'];
}
```

## `hook_fontyourface_import($context = [])`  (required to import)
Called as a **Batch operation** (`FontSettingsForm::importFromProvider` →
`\Drupal::moduleHandler()->invoke($module, 'fontyourface_import', [$context])`) when the user
clicks "Import from <module>" or "Import all fonts". Use `$context['sandbox']` to page through
your source and `$context['finished']` (0→1) to drive the batch. For each font build a
`stdClass` and persist it with `fontyourface_save_font()`:
```php
function my_provider_fontyourface_import($context = []) {
  if (empty($context['sandbox'])) {
    $context['sandbox']['fonts'] = my_provider_fetch();      // your API call
    $context['sandbox']['progress'] = 0;
    $context['sandbox']['max'] = count($context['sandbox']['fonts']);
  }
  $font = $context['sandbox']['fonts'][$context['sandbox']['progress']] ?? NULL;
  if ($font) {
    fontyourface_save_font($font);      // $font->url/provider/name/css_family/css_style/css_weight/...
    $context['sandbox']['progress']++;
    $context['finished'] = $context['sandbox']['progress'] / $context['sandbox']['max'];
  }
  return $context;
}
```
The `$font_data` object read by `fontyourface_save_font()` may set: `url` (unique key),
`provider` (→ `pid`), `name`, `css_family`, `css_style`, `css_weight`, `foundry`,
`foundry_url`, `license`, `license_url`, `designer`, `designer_url`, `classification` (array
→ `font_classification` terms), `language` (array → `languages_supported` terms), and
`metadata` (array, serialized onto the entity — providers stash load-URL data here).

## `hook_fontyourface_font_css($font, $font_style, $separator)`  (optional)
Invoked by `fontyourface_font_css()` via `invokeAll`. Return a non-empty string to **override**
the default `font-family/font-style/font-weight` CSS for a font (e.g. providers that need a
different declaration). Return nothing to fall through to the default.

## Loading fonts at render time
Providers usually also implement `hook_page_attachments(&$page)`, reading the enabled fonts
from `drupal_static('fontyourface_fonts')`, filtering `$font->pid == 'my_provider'`, and
attaching a `<link>`/inline CSS to load them. Core moves `fontyourface` + provider
implementations of `page_attachments` last via `hook_module_implements_alter()`.
