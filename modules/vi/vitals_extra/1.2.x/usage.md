<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vitals extras adds four read-only checks to the Vitals health-check framework: update status, environment indicator, development modules left enabled, and mail configuration.

---

Install it with `composer require drupal/vitals_extra` and `drush en vitals_extra` (the **Vitals** module, 2.2 or higher, is a required dependency and provides the plugin type, the settings page, and the reporting endpoint). This module adds no page or configuration of its own; instead you enable its checks individually on the Vitals settings page at `/admin/config/services/vitals`, and their results appear in Vitals' own token-protected JSON output at `/vitals/{token}`, keyed by plugin id. The four checks are: **`update_status`** — the core update-check interval plus the list of addresses that receive update notifications (also reading Symfony Mailer's update policy when that module is present) and a boolean saying whether any address is set; **`environment_indicator`** — the current environment `name` (from the Environment Indicator module's config) and `release` (from its state value), so staging can be told apart from production; **`dev_modules`** — booleans for whether **devel**, **stage_file_proxy** (with an origin set), **shield** (enabled), and **reroute_email** (or **symfony_mailer_reroute**) are actually active, which is why the module ships under `package: Security`; and **`mail`** — the effective mail `provider` and `transport`, resolved across mailsystem, symfony_mailer, swiftmailer, smtp, and phpmailer_smtp. Each check simply reads config or state and returns a small array, so they are safe to enable and cheap to run from an external monitor.

---

- Add update-status, environment, dev-module, and mail checks to an existing Vitals install.
- Enable the four extra checks individually at `/admin/config/services/vitals`.
- Report the core update-check interval to an external monitor.
- List the e-mail addresses configured to receive update notifications.
- Confirm at least one update-notification address is set (`emails_status`).
- Include Symfony Mailer's update-policy recipients in the update check.
- Detect that the Devel module is enabled in production.
- Detect that Stage File Proxy is active with an origin configured.
- Detect that Shield is enabled.
- Detect that Reroute Email (or Symfony Mailer Reroute) is intercepting mail.
- Surface which environment name the Environment Indicator module is set to.
- Read the deployed release value from environment_indicator state.
- Tell staging apart from production in automated monitoring.
- Report the effective mail provider and transport of the site.
- Verify the site is configured to actually send mail (not the default sink).
- Feed all of the above into an ops dashboard as JSON.
- Standardise deployment-hygiene checks across a fleet of sites.
- Build a post-deploy or handover checklist from the check output.
- Extend the set with a custom `VitalsCheck` plugin by subclassing `VitalsExtraPlugin`.
