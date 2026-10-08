<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Site Settings lets a Domain-module multisite override core site settings — site name, slogan, email, default front page, and 403/404 error pages — per domain, so each domain presents its own identity from one Drupal install.

---

Built on the Domain module (`domain` + `domain_config`), it adds an admin screen at `admin/config/domain/domain_site_settings` listing every domain with an edit form. Saved values are stored in the single config object `domain_site_settings.domainconfigsettings`, flat-keyed by domain id (`<domain_id>.site_name`, `.site_slogan`, `.site_mail`, `.site_frontpage`, `.site_403`, `.site_404`). A `config.factory.override` service resolves the active domain through `domain.negotiator` and swaps those values into `system.site` at request time, so visiting each domain serves that domain's name, slogan, From-email, front page, and error pages. Access is governed by the single `domain site settings` permission. Upstream now considers the project obsolete in favor of Domain Config / Domain Config UI.

---

- Set a distinct site name per domain.
- Set a distinct slogan per domain.
- Use a different From email address per domain.
- Give each domain its own default front page.
- Serve a domain-specific 403 (access denied) page.
- Serve a domain-specific 404 (not found) page.
- Run several brands from a single Drupal install.
- Override core `system.site` values per active domain.
- Present distinct site identities on each hostname.
- List all configured domains from one admin screen.
- Edit any domain's basics from a single form.
- Keep one codebase serving many domain identities.
- Match the site's From email to each domain.
- Point each domain at its own homepage node or view.
- Configure per-domain error-page routing.
- Fall back to global `system.site` values until a domain is customized.
- Restrict who can edit domain site settings via one permission.
- Delegate per-domain branding to a chosen role.
- Support a multi-brand or affiliate-site setup.
- Vary site name and slogan by domain for theming.
- Manage per-domain configuration without a separate install.
- Set per-domain settings programmatically via the config API.
- Resolve settings automatically from the negotiated active domain.
