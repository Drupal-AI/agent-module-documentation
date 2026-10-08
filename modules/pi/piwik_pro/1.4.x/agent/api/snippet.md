# Piwik PRO — snippet service & CSP subscriber

## `piwik_pro.snippet` (`PiwikProSnippet`)

Injects `config.factory`, `path_alias.manager`, `path.matcher`, `path.current`, `current_user`,
`entity_type.manager`, `current_route_match`, and the **optional** `@?csp.nonce_builder`.

```php
$snippet = \Drupal::service('piwik_pro.snippet')->getSnippet();
// string '<script ...>...</script>' if configured & visible, else NULL
```

- `getSnippet()` — returns the full `<script>` (with `nonce="…"` when `csp_nonce_enabled` and a
  nonce builder are available), or NULL.
- `getScript(string $nonce = '')` — builds the raw Piwik PRO container JS from `piwik_domain`,
  `site_id`, `data_layer`, plus cookie flags (`use_secure_cookies` → `;secure` and a
  `use_secure_cookies` push; `same_site_strict` → `;SameSite=Strict`). Returns NULL unless all
  of `data_layer`, `site_id`, `piwik_domain` are set **and** `isVisible()` is true.
- `isVisible()` = `getVisibilityPages() && getVisibilityRoles() && getVisibilityContentTypes()`
  (see configure/settings.md for the mode/list semantics). Each memoizes its result statically
  per request.

The snippet is added to page output by the module (hook in `piwik_pro.module`); you rarely call
the service directly, but it's available for custom placement.

## `piwik_pro.csp_alter_subscriber` (`PiwikProCspAlterSubscriber`)

Event subscriber that adjusts the Content-Security-Policy for the Piwik PRO snippet/domain.
Injects `config.factory` and the optional `@?csp.policy_helper`; a no-op when the CSP module
isn't installed.

## `PiwikProServiceProvider`

Registers/decorates services conditionally (e.g. wiring the optional CSP dependencies) so the
module degrades gracefully without the CSP module.
