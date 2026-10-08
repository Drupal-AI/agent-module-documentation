# Service: domain_access_logo

Service id `domain_access_logo` → `Drupal\domain_access_logo\DomainAccessLogo`
(`domain_access_logo.services.yml`, class in `src/DomainAccessLogo.php`).

Constructor arguments: `@config.factory`, `@domain.negotiator`,
`@file_url_generator`, `@entity_type.manager`.

## `getActiveDomainLogo(): string`

Resolves the logo for the currently active domain and returns its absolute URL, or
an empty string if none applies. Logic:

1. Get the active domain from `domain.negotiator` (`getActiveDomain()`); return `''`
   if there is no active `DomainInterface`.
2. Read `logos.<active_domain_id>` from `domain_access_logo.settings`; return `''` if
   no file id (`$logo[0]`) is set.
3. Load that file id from the `file` storage; return `''` if it is not a
   `FileInterface`.
4. Return `$fileUrlGenerator->generateAbsoluteString($file->getFileUri())`.

## Use it

```php
/** @var \Drupal\domain_access_logo\DomainAccessLogo $svc */
$svc = \Drupal::service('domain_access_logo');
$url = $svc->getActiveDomainLogo(); // absolute URL string, or '' when unset.
if ($url !== '') {
  // e.g. render your own logo element with this URL.
}
```

The module itself calls this from `domain_access_logo_preprocess_block()` to swap
the core branding block's logo — see [../theme/logo-swap.md](../theme/logo-swap.md).
The service is the intended integration point if you need the active domain's logo
elsewhere (a custom block, a template preprocess, etc.).
