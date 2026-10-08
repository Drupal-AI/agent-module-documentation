<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Theme Switch gives each Domain Access domain its own front-end and admin theme, from a single form listing every domain. In 3.x it stores nothing of its own — it writes per-domain `system.theme` overrides into the config collection managed by Domain Configuration.

---

The module is a single form (`/admin/config/domain/domain_theme_switch/config`, route `domain_theme_switch.settings`, permission `administer domains`) plus two small hook classes. The form loads every `domain` entity via `loadMultipleSorted()` and renders one fieldset per domain containing an **Enable theme override** checkbox and two selects — **Site theme for domain** and **Admin theme for domain** — populated from `theme_handler->listInfo()`, with the defaults falling back to the site-wide `system.theme` values read straight from `config.storage`. Saving delegates to `domain.config_factory_override`: enabling an override calls `getOverrideEditable($domain_id, 'system.theme')->set('default', …)->set('admin', …)->save()`, and unchecking calls `getOverride(...)->delete()`. The presence of the override row — not its contents — is what the module treats as "override enabled", which matters because `domain_config` 3.x writes diff-based overrides: if the chosen theme happens to equal the baseline the row is stored empty (`{}`) yet still counts as active, and both `buildForm()` and `submitForm()` deliberately use `StorageInterface::exists()` so the two halves agree. Because the actual theme switching is performed by `domain_config`'s standard config override service, no theme negotiator is involved and nothing needs `domain_config_ui`. Two update hooks handle the 2.x→3.x transition: `update_10001()` migrates the old `domain_theme_switch.settings` keys (`{domain}_site`, `{domain}_admin`) into per-domain overrides and deletes the old config object, and `update_10002()` revokes the obsolete `domain administration theme` permission that 2.x defined, silencing the "non-existent permissions assigned to the role" warning. An `update_requirements` hook blocks database updates when `domain_config` is not enabled.

---

- Give each country or brand domain its own front-end theme from one Drupal install.
- Run a differently branded microsite on a second domain without a separate codebase.
- Use a distinct admin theme on an internal/staff domain.
- Keep the default theme on the main domain and override only the secondary ones.
- Preview a new theme on a staging domain before rolling it out site-wide.
- Give a campaign domain a seasonal theme for a limited period.
- Let a partner domain use a white-label theme while sharing all content.
- Switch a domain back to the site default by unchecking its override.
- See at a glance which domains have a theme override and which inherit.
- Set both site and admin theme per domain in one submit.
- Migrate 2.x per-domain theme settings into Domain 3.x overrides automatically.
- Clean up the obsolete `domain administration theme` permission left by 2.x.
- Drive per-domain themes from configuration in code by writing `domain_config` overrides directly.
- Avoid writing a custom theme negotiator for a multi-domain site.
- Keep theme overrides in the same config collection as other per-domain settings.
- Prevent a botched update by having the module block updates when `domain_config` is missing.
- Deploy per-domain theme choices between environments as ordinary config.
- Give a mobile-oriented domain a lighter theme than the main site.
- Test an accessibility-focused theme on one domain only.
- Roll a redesign out one domain at a time.
