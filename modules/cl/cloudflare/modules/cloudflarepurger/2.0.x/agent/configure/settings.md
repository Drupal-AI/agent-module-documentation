<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cloudflare Purger

Config object **`cloudflarepurger.settings`**. Settings form at
`/admin/config/services/cloudflare/purger` (permission `administer cloudflare`; the configure
route is the parent's `cloudflare.admin_settings_form`).

## Config keys

```yaml
cache_tag_excludelist: {}   # sequence of cache-tag prefixes to omit from the Cloudflare
                            # Cache-Tag header (and thus from tag-based purges)
```

Each entry is a **prefix** string, e.g. `config:`, `user:`, `http_response`. Tags whose name
starts with a listed prefix are excluded from the generated `Cache-Tag` header, so they never
trigger a Cloudflare purge — useful for high-churn or irrelevant tags.

## Set it in code

```php
$c = \Drupal::configFactory()->getEditable('cloudflarepurger.settings');
$c->set('cache_tag_excludelist', ['config:', 'user:'])->save();
```

Read: `\Drupal::config('cloudflarepurger.settings')->get('cache_tag_excludelist');`
or `drush config:get cloudflarepurger.settings cache_tag_excludelist`.

## Related, non-config knobs

- **Header byte limit:** service parameter `cloudflarepurger.cache_tag_header_limit` (255) — the
  max size of the `Cache-Tag` response header the generator will emit. It is a container
  parameter, not editable config.
- **Purger registration & processing:** done in the Purge module UI
  (`/admin/config/development/performance/purge`), where you add the `cloudflare` purger and
  configure queuers/processors. Credentials come from the base `cloudflare` module.
