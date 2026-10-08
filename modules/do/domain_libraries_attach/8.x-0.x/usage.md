<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attaches selected asset libraries from the site's default theme to specific Domain records, so each domain in a Domain-based multisite loads its own extra CSS/JS on front-end pages.

---

Domain Libraries Attach extends the Domain module. It discovers the asset libraries declared in the active (default) theme's `*.libraries.yml`, excludes the ones the theme already loads globally via its `*.info.yml`, and exposes the remainder as "extra" libraries you can assign per domain. An admin form (`/admin/config/domain/domain_libraries_attach`, one fieldset per domain record) stores the assignments in the `domain_libraries_attach.settings` config object, keyed by domain id. On every non-admin page request the module's `hook_page_attachments_alter()` asks `DomainLibrariesManager::getLibrariesForCurrentDomain()` which libraries belong to the currently negotiated active domain and merges them into `#attached['library']`, so the page loads exactly those additional assets for that domain. It ships no entities, plugins, permissions, Drush commands, or config schema; it reuses Domain's `administer domains` permission to gate the form.

---

- Load a different stylesheet on each domain of a Domain-based multisite from one shared codebase and theme.
- Give an affiliate/sister domain extra branding CSS without creating a separate theme per domain.
- Attach a domain-specific JavaScript widget (chat, analytics helper, promo banner) only on the domains that need it.
- Assign a "holiday" or seasonal library to one domain for a campaign, then unassign it afterward.
- Serve region-specific fonts or icon libraries to the domain that targets that region.
- Keep all domain variations in the theme's `*.libraries.yml` and toggle them per domain through the UI instead of editing templates.
- Attach a print-optimized or accessibility-focused library only on a particular domain.
- Layer a per-domain override library on top of the theme's global assets already loaded via `theme.info.yml`.
- Add a tracking-pixel or third-party embed library to a single domain for a partner site.
- Enable an A/B-test or experiment library on one domain while leaving the others untouched.
- Attach multiple extra libraries to one domain at once (the per-domain selector is multi-select).
- Roll out a new front-end feature domain-by-domain by assigning its library to one domain first.
- Provide a stripped-down asset set to a lightweight landing-page domain and the full set to the main domain.
- Centralize per-domain asset decisions in configuration so they can be exported/imported with the site config.
- Let a site builder (with `administer domains`) manage per-domain assets without touching code.
- Confirm which extra libraries a theme exposes by reading the option list the form builds from library discovery.
- Skip asset injection automatically on admin routes (the module intentionally does not attach on admin pages).
- Remove a library from a domain by deselecting it in that domain's fieldset and saving.
