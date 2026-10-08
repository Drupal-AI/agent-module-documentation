# Altering the hreflang tags

Hreflang defines **no module-specific hooks or API** (there is no `hreflang.api.php` and no
service you call). It builds tags in `hreflang_page_attachments()` from the core language
manager's language-switch links, so you customize the output with two **core** hooks in a
site-specific custom module.

## `hook_language_switch_links_alter()`

Hreflang derives its per-language tags from
`$language_manager->getLanguageSwitchLinks(LanguageInterface::TYPE_INTERFACE, $url)`. Altering
those links changes the hreflang tags (add, remove, or repoint a language before the tags are
built).

```php
function mymodule_language_switch_links_alter(array &$links, $type, Url $url) {
  // Drop a language from the hreflang set.
  unset($links['de']);
  // Or repoint one language's URL.
  // $links['fr']['url'] = Url::fromUri('https://fr.example.com/page');
}
```

## `hook_page_attachments_alter()`

Runs after Hreflang has added its `html_head_link` entries, so you can inspect and modify the
already-generated tags on `$attachments['#attached']['html_head_link']`.

```php
function mymodule_page_attachments_alter(array &$attachments) {
  foreach ($attachments['#attached']['html_head_link'] as $key => $link) {
    $tag = $link[0] ?? [];
    if (($tag['rel'] ?? '') === 'alternate' && ($tag['hreflang'] ?? '') === 'x-default') {
      // e.g. remove or rewrite the x-default tag.
      unset($attachments['#attached']['html_head_link'][$key]);
    }
  }
}
```

Each Hreflang entry is a single-element array whose value has keys `rel` (`alternate`),
`hreflang` (a langcode or `x-default`), and `href` (an absolute URL).
