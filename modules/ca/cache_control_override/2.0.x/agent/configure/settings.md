<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — `cache_control_override.settings`

There is **no admin form** (`configure` is `null` in the info file, and there is no
routing file). Everything lives in one simple config object.

## Shipped defaults

`config/install/cache_control_override.settings.yml`:

```yaml
max_age:
  minimum: 0
  maximum: -1
```

Schema (`config/schema/cache_control_override.schema.yml`): a `config_object` with a
`max_age` mapping of two integers, `minimum` and `maximum`.

| Key | Meaning | Disable it with |
|---|---|---|
| `max_age.minimum` | **floor** applied with `max($minimum, $maxAge)` when the bubbled max-age is `> 0` | `0` |
| `max_age.maximum` | **ceiling** applied with `min($maximum, $maxAge)` when the bubbled max-age is `> 0` | `-1` (`Cache::PERMANENT`) |

The clamps only apply when the bubbled max-age is strictly greater than `0`. A bubbled `0`
is passed through as `max-age=0`; a bubbled `-1` skips the whole override.
`cache_control_override_update_8101()` writes exactly these "clamping off" values on sites
upgrading from 1.x.

## Read and write it

```bash
drush config:get cache_control_override.settings

# never cache a dynamic page for less than 5 minutes at the edge
drush config:set cache_control_override.settings max_age.minimum 300 -y

# never advertise more than one hour
drush config:set cache_control_override.settings max_age.maximum 3600 -y

# back to "propagate only, no clamping"
drush config:set cache_control_override.settings max_age.minimum 0 -y
drush config:set cache_control_override.settings max_age.maximum -1 -y
```

From PHP:

```php
\Drupal::configFactory()->getEditable('cache_control_override.settings')
  ->set('max_age.minimum', 300)
  ->set('max_age.maximum', 3600)
  ->save();
```

Note the module reads the values with `ConfigFactory::get()->get('max_age.minimum')` and
treats `NULL` as "no clamp", so deleting a key is equivalent to disabling that clamp.

## The other setting that matters

The module never *raises* a response above what core produced; core's
`FinishResponseSubscriber` must already have set `public` **and** a `max-age` directive,
which it only does when `system.performance:cache.page.max_age` is non-zero:

```bash
drush config:get system.performance cache.page.max_age
drush config:set system.performance cache.page.max_age 900 -y
```

If `cache.page.max_age` is `0`, no `max-age` directive exists and this module does nothing.

## Verifying the effect

```bash
# anonymous request, look at the Cache-Control header
curl -sI https://example.ddev.site/ | grep -i cache-control
```

Expect `cache-control: public, max-age=<bubbled value>` on pages whose cacheability is not
permanent, and `max-age=0` on pages that bubbled an uncacheable max-age (those are also
denied by the page-cache policy, so they will not come from the internal page cache).
