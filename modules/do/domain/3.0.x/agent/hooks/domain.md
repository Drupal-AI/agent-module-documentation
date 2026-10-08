<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks Domain invites (`domain.api.php`)

Implement these in a `.module` file or a `src/Hook/*` class (OOP hooks).

| Hook | When | Do what |
|---|---|---|
| `hook_domain_load(array $domains)` | Each domain record is loaded | Attach transient data with `$domain->addProperty($k, $v)`. |
| `hook_domain_request_alter(DomainInterface $domain)` | After the active domain is negotiated | Inspect `$domain->getMatchType()` (`DOMAIN_MATCHED_NONE/EXACT/ALIAS`); override match, or `$domain->setRedirect(301\|302)` to redirect. |
| `hook_domain_operations(DomainInterface $domain, AccountInterface $account)` | Building the admin domain list | Return keyed operations (`title`, `url`, optional `weight`/`query`) — how `domain_alias` adds its "Aliases" link. |
| `hook_domain_validate_alter(array &$error_list, $hostname)` | Validating a hostname on save | Push messages onto `$error_list` (by reference) to reject; empty/NULL = valid. Does **not** apply to alias records. |
| `hook_domain_references_alter(QueryInterface $query, AccountInterface $account, array $context)` | Building the domain reference list for a field | Add query conditions to limit selectable domains. `$context` has `entity_type`, `bundle`, `field_type` (`editor`/`admin`). Skipped for users with `administer domains`. |

Example — restrict which hostnames may be registered:

```php
function mymodule_domain_validate_alter(array &$error_list, $hostname) {
  if (!str_ends_with($hostname, '.example.com')) {
    $error_list[] = t('Only *.example.com subdomains may be registered.');
  }
}
```
