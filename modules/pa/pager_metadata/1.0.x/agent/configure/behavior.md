# Pager metadata — behavior & the one setting

No admin form. All behavior is hook-driven and automatic once the module is enabled.

## The only setting (settings.php)

```php
// Default is TRUE. Set FALSE to stop rewriting the canonical link.
$settings['pager_metadata_alter_canonical'] = FALSE;
```

Read via `\Drupal\Core\Site\Settings::get('pager_metadata_alter_canonical', TRUE)`. There is no
config entity and no UI — this lives only in `settings.php`. When `FALSE`, the `rel="prev"`/`rel="next"`
links are still emitted; only the canonical rewrite is skipped.

## What each hook does

- `hook_page_attachments_alter()` — finds the `canonical_url` entry in `#attached['html_head']`,
  reads the current page via `\Drupal::service('pager.parameters')->findPage()`, and appends
  `?page=N` (for N > 0) to the canonical `href`. Adds cache context `url.query_args.pagers` so the
  canonical varies per page. Gated by the `pager_metadata_alter_canonical` setting.
- `hook_preprocess_pager()` and `hook_preprocess_views_infinite_scroll_pager()` — both call the
  internal `_pager_metadata_rels_to_head()`, which reads the pager's `items['previous']` and
  `items['next']` hrefs and injects `#attached['html_head_link']` entries with `rel => prev` / `next`
  built from the current route (`Url::fromRoute('<current>')`). A `page=0` query is stripped. Adds
  the `route.name` cache context.
- `hook_block_build_alter()` — for `views_block` blocks, sets `$build['#create_placeholder'] = FALSE`
  so the view (and its pager preprocess) renders in time to contribute to the `<head>` instead of
  being lazy-built after the head is sent.

## Install detail

`hook_install()` calls `module_set_weight('pager_metadata', 1)` (and `hook_update_8001` re-applies it)
so these preprocess/attachment hooks run after other modules'. No other setup is required.

## Verifying output

Load a listing page with a pager (e.g. `/some-view?page=1`) and inspect the HTML `<head>`: the
canonical should include `?page=1`, and `<link rel="prev">` / `<link rel="next">` should be present
according to available pager pages.
