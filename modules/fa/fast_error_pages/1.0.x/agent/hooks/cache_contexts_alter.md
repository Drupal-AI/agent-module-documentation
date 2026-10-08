<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_fast_error_pages_cache_contexts_alter`

Adds parts to the cache id under which a fetched error page's metadata is stored and looked up.
By default the cid is **the bare status code** (`404`, `403`), so every 404 shares one cache
entry — one page is served to everyone. On a multilingual or multi-domain site you must append a
discriminator or the wrong language/domain page will be served.

```php
function hook_fast_error_pages_cache_contexts_alter(array &$cid_parts): void {
  if (\Drupal::languageManager()->isMultilingual()) {
    $cid_parts[] = \Drupal::languageManager()->getCurrentLanguage()->getId();
  }
  if (\Drupal::moduleHandler()->moduleExists('domain')) {
    $domain = \Drupal::service('domain.negotiator')->getActiveDomain();
    if ($domain) {
      $cid_parts[] = $domain->id();
    }
  }
}
```

## Behaviour

- Invoked as `$module_handler->alter('fast_error_pages_cache_contexts', $cid_parts)` in **both**
  subscribers: the exception subscriber (where `$cid_parts` starts as `[$status_code]`, then
  `cid = implode(':', $cid_parts)`) and the store subscriber (where it starts as `[]`, then
  `cid = implode(':', array_merge([$code], $cid_parts))`).
- **Only ever append** to `$cid_parts`; do not read or depend on existing contents — the array is
  seeded differently in the two call sites, so appended parts must be positionally consistent (the
  status code is always prepended by the caller, never something you rely on inside the hook).
- Whatever you add must be deterministic per request so the write-side (store) cid and the
  read-side (serve) cid match; otherwise a stored entry is never found and the module falls back to
  core.
