<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration (settings.php only)

The module has **no admin form, no config entity, no `config/schema`, and no permission**. All
tuning is via one `$settings['email_obfuscator']` array in `settings.php`, read at runtime with
`\Drupal\Core\Site\Settings::get('email_obfuscator')`. Both keys are optional.

## `ignored_routes` (array, default `[]`)

Route names (machine `_route`) that should NOT be obfuscated. Checked in
`EmailObfuscatorResponseFilter::onKernelResponse()` via `in_array($route, $ignored)`.

```php
$settings['email_obfuscator'] = [
  'ignored_routes' => [
    'rest.api_layout_footer.GET',
    'editor.link_dialog',
  ],
];
```

Per the README, if you run **CKEditor 4** add `editor.link_dialog` so the link dialog shows the
real address instead of an obfuscated one. (Admin routes are already skipped automatically via
`AdminContext::isAdminRoute()`, so admin-only routes need not be listed.)

## `use_datanosnippet` (bool, default `TRUE`)

Controls whether the injected hidden span carries the `data-nosnippet` attribute (keeps the
`!zilch!` placeholder text out of search snippets — officially honored only by Googlebot). Read as
`Settings::get('email_obfuscator')['use_datanosnippet'] ?? TRUE`. Set FALSE to omit it:

```php
$settings['email_obfuscator'] = [
  'use_datanosnippet' => FALSE,
];
```

## Automatic exclusions (not configurable)

Handled in code, no setting needed: admin/backoffice routes, Ajax webform submissions
(`form_id` starting with `webform`), emails inside HTML tags/attributes, and any address failing
`FILTER_VALIDATE_EMAIL`.

## Operating notes

- Obfuscation failures are logged to the `email_obfuscator` logger channel; on failure the
  original response is served unchanged.
- Effect is site-wide and immediate once enabled — there is nothing to configure per field, view
  or content type.
