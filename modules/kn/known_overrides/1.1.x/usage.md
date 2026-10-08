<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Known Overrides reports which configuration values are being overridden by `settings.php`, comparing them against a `$knownOverrides` global the developer declares.

---

Configuration overrides in `settings.php` are how a Drupal site differs per environment — a development mail transport, a disabled cache, a different API endpoint, a search server pointing at a local instance — and they work invisibly by design, which is exactly the problem: the configuration UI shows the stored value while the site runs on the overridden one, so an administrator changes a setting, sees it saved, and nothing happens. There is no settings form; you use the module by editing a settings file (`settings.php`, `settings.local.php`, or `settings.local.includes.php`): make sure `$settings['knownOverrides']` exists, then append each overridden config name, e.g. `$settings['knownOverrides'][] = 'mail_safety.settings';` (an entry may instead be an array carrying a `path` to scope a warning to specific admin pages). With that in place the module warns and highlights each overridden field — disabled, with its live overridden value shown — directly on the relevant config form, adds a warning on path-scoped admin pages, and renders a consolidated two-column diff (stored **Editable** vs live **Overridden**) at `/admin/reports/known-overrides`, showing only the keys that differ. Access to that report is gated by the `known overrides report` permission, marked `restrict access: true`, so grant it only to trusted roles — an override report is a map of how this environment differs from the codebase. Version **1.1.0** on core `^10 || ^11`, with `no_cache: TRUE` on the route so the report always reflects live state.

---

- Declare which config values settings.php overrides.
- See at a glance which config values settings.php is overriding.
- Explain why a saved setting has no effect.
- Highlight overridden fields directly on their config form.
- Show the live overridden value next to a disabled field.
- Audit an inherited site's overrides.
- Compare expected (declared) versus actual overrides.
- Diagnose a configuration mystery.
- Document environment differences.
- Find a platform-injected override.
- Support a deployment review.
- Check overrides after a migration.
- Verify a development environment's settings.
- Identify unexpected overrides.
- Support a troubleshooting session.
- Review overrides before a release.
- Confirm a feature flag is set via settings.php.
- Explain a config import conflict.
- Onboard onto an unfamiliar site.
- Audit a multidev environment.
- Restrict the override report to trusted roles.
