# How the logo is swapped at render time

There is no theme negotiation and no config override. The module swaps the logo by
preprocessing the core branding block.

## The mechanism

`domain_access_logo.module` implements `hook_preprocess_HOOK` for blocks:

```php
function domain_access_logo_preprocess_block(&$variables) {
  if ($variables['base_plugin_id'] !== 'system_branding_block') {
    return;
  }
  $service = \Drupal::service('domain_access_logo');
  $file_path = $service->getActiveDomainLogo();
  if ($file_path !== '') {
    $variables['content']['site_logo']['#uri'] = $file_path;
  }
}
```

- It runs for every rendered block but returns immediately unless the block's
  `base_plugin_id` is `system_branding_block` (the core "Site branding" block that
  themes place to show the logo / site name / slogan).
- It asks the `domain_access_logo` service for the active domain's logo URL (see
  [../api/service.md](../api/service.md)).
- If a logo is configured for the active domain, it overwrites
  `$variables['content']['site_logo']['#uri']` with that file's absolute URL. The
  `site_logo` render element is the `image` produced by the branding block; only its
  `#uri` is replaced, so the theme's own markup/attributes are preserved.

## Consequences

- The swap only affects the **Site branding block**. A theme that prints the logo by
  some other means (e.g. hardcoded in a template, or a custom logo region) is not
  affected — use the service directly there.
- When no logo is set for the active domain, or there is no active domain, the
  service returns `''` and the block keeps the theme's default logo.
- The settings form invalidates the `system.site` cache tags on save, which is what
  the branding block is tagged with, so a new logo appears without a manual cache
  clear.
