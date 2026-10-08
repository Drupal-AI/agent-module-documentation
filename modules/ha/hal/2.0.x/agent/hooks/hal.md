# Hooks — `hal.api.php`

Two alter hooks let you rewrite the URIs HAL puts in an entity's `_links`. Both receive the
URI by reference plus the serializer/normalizer `$context`, and fire during serialize,
deserialize, normalize and denormalize.

## `hook_hal_type_uri_alter(&$uri, $context = [])`

Alters the **type** URI — the one identifying a resource's bundle (the `type` link).

```php
function mymodule_hal_type_uri_alter(&$uri, $context = []) {
  if (!empty($context['mymodule'])) {
    $base = \Drupal::config('hal.settings')->get('link_domain');
    $uri = str_replace($base, 'http://mymodule.domain', $uri);
  }
}
```

## `hook_hal_relation_uri_alter(&$uri, $context = [])`

Alters a **relation** URI — the per-field link identifying what a field represents.

```php
function mymodule_hal_relation_uri_alter(&$uri, $context = []) {
  if (!empty($context['mymodule'])) {
    $base = \Drupal::config('hal.settings')->get('link_domain');
    $uri = str_replace($base, 'http://mymodule.domain', $uri);
  }
}
```

Use these for cross-site canonicalization (rewriting the host in link URIs) or to align URIs
with an external schema. For wholesale changes to how URIs are generated, decorate the link
manager instead — see [../extend/hal.md](../extend/hal.md). The single-domain case is covered
by the `hal.settings:link_domain` config value (or `setLinkDomain()`) without a hook.
