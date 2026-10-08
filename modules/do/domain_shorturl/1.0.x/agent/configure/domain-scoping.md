<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain scoping (domain_shorturl)

## Requirements
Enable with `shorturl`, `domain`, and `domain_redirect`. Short-URL nodes gain `field_shorturl_domain`.

## Settings
`/admin/config/domain/shorturl` (`administer shorturl`): `counter_scope` = `per_domain` (separate auto-increment counter per domain) or `global`.

## Behaviour
- **Slug uniqueness:** validated per `(domain_id, language)`; the base module's global validator is removed and replaced (`DomainShortUrlFormHooks::validateSlugUniqueness`).
- **URL building:** `DomainAwareShortUrlManager::buildFullUrl()` uses the assigned domain's hostname + prefix; `getUrlOptions()` passes the domain to `Url::fromRoute()`.
- **Redirects:** `syncRedirects()` sets `domain_id` on all redirects for the node; `redirect_response_alter` adds header `X-Shorturl-Domain-Id`.
- **Resolution:** `resolveNodeBySlug()` scopes by active domain, falling back to global lookup.
- **Form:** domain selector filtered to the user's `field_domain_access` unless they have `create shorturl on any domain`.

## Permissions
- `administer shorturl` — settings form.
- `create shorturl on any domain` — pick any domain regardless of domain_access.
