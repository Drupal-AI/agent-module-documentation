ECK Site Settings per Domain lets a settings bundle hold different field values on each domain by scoping every settings load and save to the active Domain module domain.

---

This submodule of ECK Site Settings integrates with the Domain module. Enable per-domain values on a settings bundle by ticking "Allow different settings per domain" on the ECK bundle edit form; the choice is stored as the bundle's third-party setting `eck_site_settings_domain.enabled`. When a domain-enabled bundle is created or updated, the module installs a required `field_domain_access` entity-reference field (targeting `domain`) on that bundle's entity type. From then on, whenever eck_site_settings loads or materialises the singleton for that bundle, this submodule injects the active domain: it adds `domain_id` to the load context (`hook_eck_site_setting_context_alter`, read from `domain.negotiator`'s active domain) and adds `field_domain_access = <domain_id>` to the load/create values (`hook_eck_site_setting_values_alter`). Because the repository query filters on those values, each domain gets its own settings entity for that bundle, created on first access. It ships no routes, controllers, permissions, or Drush commands — only two form/entity hooks, two alter hooks, a `FieldInstaller`, and an `EckBundleFormAlter`.

---

- Show a different contact address or phone number in a shared "Contact" settings bundle per domain.
- Give each domain its own homepage hero text/image from one settings bundle.
- Vary a global announcement banner's copy or on/off state between affiliate domains.
- Keep per-domain social links or tracking IDs in a single settings page definition.
- Let editors manage domain-specific footer content without duplicating bundles.
- Provide per-domain SEO defaults (meta description, share image) from one shared bundle.
- Enable per-domain values selectively — only the bundles you tick, others stay site-global.
- Read the active domain's variant automatically in Twig via `site_settings('general')` (no extra args).
- Read the active domain's variant in PHP via `settings_repository->getSetting('general')`.
- Override the domain used for a load by passing/altering `context['domain_id']` before it defaults.
- Auto-provision the `field_domain_access` reference field on a bundle just by enabling the option.
- Migrate a bundle to per-domain by enabling the checkbox; existing/new domains get their own entity on first access.
- Combine with the parent module's tokens so `[eck_site_settings:settings-general:field_x]` resolves per domain.
- Scope marketing CTA text and target links per domain from one settings definition.
- Maintain per-domain legal/copyright text centrally while rendering the right one per site.
