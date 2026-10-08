# GTM — injection mechanism & config access

The module has no services or public API of its own. Its behavior is two procedural hooks in
`gtm.module` that read `gtm.settings` and attach the container snippet.

## Hooks that inject the snippet

- **`gtm_page_attachments(array &$page)`** — implements `hook_page_attachments()`. Adds the
  head part as an inline `<script>` under `$page['#attached']['html_head']` with the key
  `gtm`. The script bootstraps `window.dataLayer` and loads
  `https://www.googletagmanager.com/gtm.js?id=<container>`. The container ID is passed
  through `preg_replace('/[^a-zA-Z0-9\-]/', '', ...)` first. This is where the uid-1
  exclusion (`admin-disable`) is applied.
- **`gtm_page_top(array &$page_top)`** — implements `hook_page_top()`. Adds the body part as
  a hidden `<iframe>` (`html_tag`, `#noscript => TRUE`) pointing at
  `https://www.googletagmanager.com/ns.html?id=<container>`, keyed `gtm` in `$page_top`.

Both hooks gate on `enable` + `google-tag` + the admin-route condition (see
[configure/gtm.md](../configure/gtm.md)).

## Read the config in code

```php
$config = \Drupal::config('gtm.settings');
$container_id = $config->get('google-tag');   // e.g. 'GTM-ABCD123'
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
