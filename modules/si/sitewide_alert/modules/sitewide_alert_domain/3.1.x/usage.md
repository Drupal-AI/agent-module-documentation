<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Experimental submodule of Sitewide Alert. Adds Domain support so a sitewide alert can be scoped to specific domains on a multi-domain install, using the Domain Access Entity module.

---

`sitewide_alert_domain` integrates Sitewide Alert with the contrib Domain project. It decorates the parent module's alert manager service (`sitewide_alert.sitewide_alert_manager`) with `SitewideAlertDomainManager`, which filters the alerts returned for a request by the current negotiated domain. It depends on `sitewide_alert`, `domain`, and `domain_entity`, and requires that Domain Access and Domain Access Entity be installed and configured first. After enabling, you configure domain support for the `sitewide_alert` entity type at `/admin/config/domain/entities` (per the Domain Access Entity docs) and then expose the Domain Access field on the sitewide alert form. The submodule is flagged experimental by its maintainers. It adds no permissions, no config form, and no schema of its own — only the per-domain filtering behavior.

---

- Show an alert only on one domain of a multi-domain (Domain Access) install.
- Run different announcement banners per affiliate/brand domain from one Drupal site.
- Scope an emergency notice to the specific domain it affects.
- Restrict a promotional banner to a single storefront domain.
- Combine domain scoping with the parent module's scheduling so a per-domain alert also auto-expires.
- Reuse existing alert entities but limit their audience by domain.
- Filter the alert JSON feed by the current negotiated domain automatically.
- Add a Domain Access field to the alert form for editors to pick domains.
- Keep unrelated domains free of another domain's alerts.
- Layer domain targeting on top of the parent's page-path visibility rules.
- Manage per-domain alerts without duplicating the whole alert configuration per site.
- Support brand-specific messaging on a shared multi-domain platform.
- Show a domain-specific maintenance banner while leaving other domains unaffected.
- Coordinate a network of sites so each domain surfaces only its own announcements.
- Let a single editorial team publish targeted alerts across many domains from one place.
- Roll out a per-domain legal or compliance notice on a multi-domain estate.
- Test alert content on a staging domain before showing it on the production domain.
