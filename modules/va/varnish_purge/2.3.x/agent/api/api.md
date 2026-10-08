# Programmatic surface — Varnish Purger

You rarely call this module directly — Purge drives the purgers. But these classes are the
public building blocks.

## `VarnishPurgerSettings` config entity

`Drupal\varnish_purger\Entity\VarnishPurgerSettings` — `@ConfigEntityType(id =
"varnishpurgersettings", config_prefix = "settings")`, extends Purge's
`PurgerSettingsBase`. One entity per configurable purger instance; config name is
`varnish_purger.settings.<instance-id>`.

```php
use Drupal\varnish_purger\Entity\VarnishPurgerSettings;

// Load the settings for a given purger instance id.
$settings = VarnishPurgerSettings::load($instance_id);
$settings->hostname;          // e.g. 'localhost'
$settings->request_method;    // 'BAN' | 'PURGE'
$settings->invalidationtype;  // 'tag' | 'url' | 'wildcardurl' | 'everything' | ...
$settings->headers;           // array of ['field' => ..., 'value' => ...]
$settings->save();
```

Exported keys: `id, name, invalidationtype, hostname, port, path, request_method, scheme,
verify, headers, body, body_content_type, runtime_measurement, timeout, connect_timeout,
cooldown_time, max_requests, http_errors`.

## `VarnishPurgerBase` (extend to build a purger variant)

`Drupal\varnish_purger\Plugin\Purge\Purger\VarnishPurgerBase` (abstract, extends Purge's
`PurgerBase`). Injects `http_client` (Guzzle) and `token`. Helpers a subclass uses inside
`invalidate()`:

- `getUri(array $token_data)` → `"{scheme}://{hostname}:{port}{path}"` with `path`
  token-replaced.
- `getOptions(array $token_data)` → Guzzle options (`http_errors`, `connect_timeout`,
  `timeout`, `headers`, and `verify` when https). `getHeaders()` lower-cases header names and
  token-replaces values; always sets a `user-agent`.
- `getCooldownTime()`, `getIdealConditionsLimit()` (= `max_requests`), `getTimeHint()`,
  `getTypes()` (= `[invalidationtype]`), `hasRuntimeMeasurement()`, `delete()` (deletes the
  settings entity).

`VarnishPurger` and `VarnishBundledPurger` are the two concrete subclasses (see
[../plugins/purgers.md](../plugins/purgers.md)); `ZeroConfigPurger` extends Purge's
`PurgerBase` directly instead.

## Services used (not provided)

The module registers **no services of its own**. It consumes core `http_client`, `token`,
and Purge's `purge.purgers` / `purge.invalidation.factory`.
