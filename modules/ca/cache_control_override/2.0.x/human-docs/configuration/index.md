# Configuration

Cache Control Override works the moment you enable it — everything on this page is
**optional tuning**. There is **no admin form**: the module ships a single
configuration object, `cache_control_override.settings`, which you edit with Drush
(or a config file). It holds just two values, a floor and a ceiling, that clamp the
max‑age the module advertises.

## The shipped defaults

```yaml
max_age:
  minimum: 0    # floor; 0 = no floor (clamping off)
  maximum: -1   # ceiling; -1 = no ceiling (clamping off)
```

With these defaults the module only *propagates* the real bubbled max‑age — it does
not shrink or grow it. You change them only when you want to enforce limits.

## The two settings

| Setting | What it does | Turn it off with |
|---|---|---|
| **`max_age.minimum`** | A **floor**. When a page's bubbled max‑age is greater than `0`, the module raises it to at least this many seconds. Use it so a badly behaved bit of content can't drop a whole page's edge TTL below a value you're comfortable with. | `0` |
| **`max_age.maximum`** | A **ceiling**. When a page's bubbled max‑age is greater than `0`, the module lowers it to at most this many seconds. Use it so no page is ever cached longer than your purge/invalidation tooling can guarantee. | `-1` |

Important details:

- The clamps only apply when the bubbled max‑age is **greater than 0**. A bubbled
  `0` is always passed through as `max-age=0` (and the page is kept out of the
  internal page cache). A page whose cacheability is fully **permanent** is left
  entirely alone and keeps the site‑wide page‑cache max‑age.
- The module treats a missing value as "no clamp", so deleting a key has the same
  effect as setting it to its "off" value.

## Setting the values with Drush

```bash
# read the current settings
drush config:get cache_control_override.settings

# never cache a dynamic page for less than 5 minutes at the edge
drush config:set cache_control_override.settings max_age.minimum 300 -y

# never advertise more than one hour
drush config:set cache_control_override.settings max_age.maximum 3600 -y

# back to "propagate only, no clamping"
drush config:set cache_control_override.settings max_age.minimum 0 -y
drush config:set cache_control_override.settings max_age.maximum -1 -y
```

Or from PHP:

```php
\Drupal::configFactory()->getEditable('cache_control_override.settings')
  ->set('max_age.minimum', 300)
  ->set('max_age.maximum', 3600)
  ->save();
```

## The other setting that matters

Remember the module never raises a response above what core produced. Core's page
cache max‑age must be non‑zero for any `max-age` directive to exist:

```bash
drush config:get system.performance cache.page.max_age
drush config:set system.performance cache.page.max_age 900 -y
```

If `cache.page.max_age` is `0`, no `max-age` directive is generated and this module
has nothing to clamp.

## Verifying the effect

```bash
curl -sI https://example.ddev.site/ | grep -i cache-control
```

Expect `cache-control: public, max-age=<bubbled value>` on pages whose cacheability
is not permanent (now respecting your floor and ceiling), and `max-age=0` on pages
that bubbled an uncacheable max‑age.
