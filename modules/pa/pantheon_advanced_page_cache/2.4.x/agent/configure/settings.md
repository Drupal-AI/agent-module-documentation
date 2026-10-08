# Configuration

No admin form. Config object `pantheon_advanced_page_cache.settings` (schema
`config/schema/pantheon_advanced_page_cache.schema.yml`), defaults in `config/install`:

| Key | Default | Purpose |
|---|---|---|
| `surrogate_key_header_limit` | `25000` | Max byte length of the `Surrogate-Key` header. Only honored on **non-Pantheon** environments (when `$_ENV['PANTHEON_INFRASTRUCTURE_ENVIRONMENT']` is unset). Valid range 0–25000. |
| `override_list_tags` | `false` | Legacy 1.x behavior: rename `_list` cache tags to `_emit_list` so list tags are not cleared by default. **Not recommended**; leave off. A null value is treated as TRUE for backwards-compat. |

## Setting values
Set via config import (`pantheon_advanced_page_cache.settings.yml`), `drush cset`, or override
in `settings.php`:

```php
$config['pantheon_advanced_page_cache.settings']['surrogate_key_header_limit'] = 20000;
```

Overriding the limit in `settings.php` is the documented way to shrink the header on local
environments (see the warning logged when the header is trimmed).
