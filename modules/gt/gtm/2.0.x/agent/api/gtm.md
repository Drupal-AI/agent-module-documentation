# GTM — insertion mechanism & config access

The module has no services or public API of its own. Its behavior is procedural code in
`gtm.module`: two page hooks plus one helper that read `gtm.settings` and attach the
container snippet.

## Container-ID helper

- **`gtm_get_google_tag(): ?string`** — reads `google-tag` from `gtm.settings`, runs it
  through `preg_replace('/[^a-zA-Z0-9\-]/', '', ...)`, and returns the sanitized ID — or
  `NULL` if the value is missing, non-string, or empty after sanitizing. Both hooks call
  this, so the head script and the iframe use the same cleaned ID.

## Hooks that inject the snippet

- **`gtm_page_attachments(array &$page): void`** — implements `hook_page_attachments()`.
  Adds the head part as an inline `<script>` under `$page['#attached']['html_head']` with the
  key `gtm` (defensively initializing `#attached`/`html_head` first). The script bootstraps
  `window.dataLayer` and loads `https://www.googletagmanager.com/gtm.js?id=<container>`. The
  container ID comes from `gtm_get_google_tag()`. This is where the uid-1 exclusion
  (`admin-disable`) is applied.
- **`gtm_page_top(array &$page_top): void`** — implements `hook_page_top()`. Adds the body
  part as a hidden `<iframe>` (`html_tag`, `#noscript => TRUE`) pointing at
  `https://www.googletagmanager.com/ns.html?id=<container>`, keyed `gtm` in `$page_top`. It
  also uses `gtm_get_google_tag()`, but does **not** apply the uid-1 exclusion.

Both hooks gate on `enable` + a non-null `gtm_get_google_tag()` + the admin-route condition
(see [configure/gtm.md](../configure/gtm.md)).

## Read the config in code

```php
$config = \Drupal::config('gtm.settings');
$container_id = $config->get('google-tag');   // raw stored value, e.g. 'GTM-ABCD123'
$enabled      = (bool) $config->get('enable');
$on_admin     = (bool) $config->get('admin-pages');
$skip_admin_u = (bool) $config->get('admin-disable');
```

## Write the config in code

```php
\Drupal::configFactory()->getEditable('gtm.settings')
  ->set('google-tag', 'GTM-ABCD123')
  ->set('enable', 1)
  ->set('admin-pages', 0)
  ->set('admin-disable', 1)
  ->save();
```

No config schema ships, so store the flags as integers `0`/`1` (matching
`config/install/gtm.settings.yml`).
