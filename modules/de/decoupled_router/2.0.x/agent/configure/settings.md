<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure

Decoupled Router has **no admin form** (`configure` route is `null`). It ships one config
object, `decoupled_router.settings`, with a single key:

| Key | Type | Default | Effect |
|---|---|---|---|
| `absolute_resolved_urls` | boolean | `true` | When `true`, the `resolved` (and redirect) URLs in the response are absolute (`https://host/path`); when `false` they are site-relative (`/path`). The `entity.canonical` URL is always absolute. |

The config is fully validatable (`config/schema/decoupled_router.schema.yml`).

Read / change it with Drush:

```bash
# read
drush config:get decoupled_router.settings absolute_resolved_urls

# switch resolved URLs to relative (e.g. same-domain front end)
# NB: for a BOOLEAN key, pass 0/1 (or --input-format=yaml) — a bare `false`
# string is mis-parsed as TRUE by Drush config:set.
drush config:set decoupled_router.settings absolute_resolved_urls 0 -y            # false → relative
drush config:set --input-format=yaml decoupled_router.settings absolute_resolved_urls false -y  # equivalent
drush config:set decoupled_router.settings absolute_resolved_urls 1 -y            # true → absolute (default)
```

Or in code (most reliable):

```php
\Drupal::configFactory()->getEditable('decoupled_router.settings')
  ->set('absolute_resolved_urls', FALSE)->save();
```
