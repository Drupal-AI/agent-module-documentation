# Building & manipulating a policy in code

## The `Csp` value object (`Drupal\csp\Csp`)
A mutable representation of one policy. Key methods:

```php
$policy = new \Drupal\csp\Csp();
$policy->reportOnly(TRUE);                        // report-only vs enforce
$policy->isReportOnly(): bool;

$policy->hasDirective('script-src'): bool;
$policy->getDirective('script-src'): array|bool;
$policy->setDirective('img-src', ['self', 'https://cdn.example.com']);  // replace
$policy->appendDirective('img-src', 'https://example.com');             // add source(s)
$policy->fallbackAwareAppendIfEnabled('img-src', $host); // add only if directive/fallback enabled
$policy->removeDirective('prefetch-src');

$policy->getHeaderName(): string;   // Content-Security-Policy[-Report-Only]
$policy->getHeaderValue(): string;  // the serialized directive string
(string) $policy;                   // same as getHeaderValue()
```
Useful constants: `Csp::POLICY_SELF` (`'self'`), `POLICY_NONE`, `POLICY_ANY` (`*`),
`POLICY_UNSAFE_INLINE`, `POLICY_STRICT_DYNAMIC`, `POLICY_REPORT_SAMPLE`;
`Csp::DIRECTIVES` (name → schema type) and `Csp::DIRECTIVES_FALLBACK`.

## `PolicyHelper` service (`csp.policy_helper` / `Drupal\csp\PolicyHelper`)
Convenience methods that respect directive fallbacks:
```php
$helper = \Drupal::service('csp.policy_helper');
$helper->appendNonce($policy, 'script-src', $fallback);          // allow this request's nonce
$helper->appendHash($policy, 'script-src', 'sha256', $fallback, $b64hash);
$helper->requireUnsafeInline($policy, 'style-src', 'elem');
```

## Nonces
Per-request nonce services let you allow specific inline scripts/styles without
`unsafe-inline`:
- `csp.nonce` (`Drupal\csp\Nonce`) — `hasValue()`, `getValue()`, `getSource()` (the
  `'nonce-…'` source expression).
- `csp.nonce_builder` (`Drupal\csp\NonceBuilder`) — `getPlaceholderKey()`, `renderNonce()`
  (a render array that emits the nonce and adds it to `drupalSettings`).

## Auto-discovered library hosts
`csp.library_policy_builder` (`LibraryPolicyBuilder::getSources()`) scans enabled asset
libraries for external hosts and CSP metadata; results are cached and rebuilt on
`hook_rebuild` (cache clear). You rarely call this directly.
