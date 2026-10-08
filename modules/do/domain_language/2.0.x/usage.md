<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Language adds a *Languages* operation to each Domain Access domain, letting you pick that domain's default language and the subset of site languages it offers. It works entirely through config overrides — no new entity types, no schema.

---

Given a multilingual site running Domain Access, each domain normally shares the site's default language and every enabled language. This module adds a per-domain form at `/admin/config/domain/language/{domain}/edit` (linked as the *Languages* row operation on the domain list) with two controls: a **default language** select and an **allowed languages** checkbox set. Saving writes `default_langcode` into `domain.config.{domain}.system.site` (deleting the key when you choose *Site's default language*) and the allowed set into `domain.language.{domain}.language.negotiation` (the chosen default is always force-added). Enforcement happens in three places. First, `DomainLanguageOverrider` — a `config.factory.override` service at priority −140 — rewrites `language.negotiation` for the active domain so `url.prefixes` and `url.domains` only contain allowed languages, and delegates `system.site` to `domain_config`'s overrider; both branches are skipped for users holding `bypass language restrictions`. Second, a service provider swaps core's `language.default` service for the module's `LanguageDefault`, which resolves the default language from `domain.config.{domain}.system.site` (reading config directly to dodge an infinite loop through its own overrider) and resets the language manager and translation service to match. Third, `hook_language_switch_links_alter()` intersects the interface language switcher's links with the allowed set, so disallowed languages disappear from the switcher block. The module ships one permission, `bypass language restrictions` (restrict access), no config schema, and no Drush commands.

---

- Give a country-specific domain its own default language (e.g. `fr` on the .fr domain).
- Offer only French and German on a European domain while the main site keeps all languages.
- Hide irrelevant languages from the language switcher on a per-domain basis.
- Run one Drupal install serving several single-language brand sites.
- Keep an English-only microsite on a multilingual platform.
- Prevent a domain's URL language prefixes from resolving to languages it does not serve.
- Let editors preview all languages on every domain via the bypass permission.
- Set a domain's default language without touching the global site default.
- Revert a domain to the site default language by picking *Site's default language*.
- Add a new market by cloning a domain and choosing its language subset.
- Restrict a staging domain to one language to simplify QA.
- Serve a regional domain whose default differs from its allowed extras.
- Coordinate with `domain_config` so language and other per-domain settings live together.
- Drive the per-domain settings from configuration in code (`drush cset` on the two config keys).
- Audit which languages each domain currently exposes by reading `domain.language.*` config.
- Keep interface translation aligned with the domain default via the swapped `language.default` service.
- Remove per-domain overrides cleanly (the form deletes empty config objects instead of leaving stubs).
- Prevent unexpected negotiation overrides by having the form strip `url.prefixes`/`url.domains` from `domain.config.*.language.negotiation`.
- Use one codebase for country sites that each need a different fallback language.
- Combine with Domain Access content rules so both content and language are domain-scoped.
