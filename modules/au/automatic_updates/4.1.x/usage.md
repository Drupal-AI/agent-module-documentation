Automatic Updates safely updates Drupal core — either with a push-button "Update now" flow or as unattended background updates during cron — by staging the Composer change in a sandbox copy of the site (via core's Package Manager) before syncing it live. It also runs "Update readiness" checks that warn you when your environment can't safely apply updates.

---

Automatic Updates is the contrib home of Drupal's Automatic Updates Initiative and is slated to move into Drupal core. It builds on core's **Package Manager** module (a required dependency) to create a temporary sandbox copy of the site, apply the Composer change there, and commit it back to the live codebase, briefly entering maintenance mode during finalization. Core updates run one of three sandbox managers — `UpdateSandboxManager` (attended/push-button), `ConsoleUpdateSandboxManager` (the `auto-update` CLI tool), and `ExtensionUpdateSandboxManager` — all extending Package Manager's `SandboxManagerBase`. A `CronUpdateRunner` decorates core's `cron` service to launch unattended updates as a detached background process after normal cron tasks; its behavior is controlled by `automatic_updates.settings` (`unattended.level`: disable / security / patch, and `unattended.method`: web or console). Before any update, a suite of event-subscriber **validators** (version policy, requested-update, staged-projects, staged database updates, cron frequency, Windows, forbidden core changes, PHP extensions) block unsafe operations, and a `StatusChecker` runs periodic **readiness** checks whose results appear on the site status report and can be emailed during cron. Users manage everything from the core Update settings and reports pages (permission `administer software updates`) — the module has no permissions of its own. A now-obsolete sub-module, **Automatic Updates Extensions**, previously handled contrib module/theme updates; that functionality has since been folded into the main module. Because it only changes the project-level `composer.json` constraint for `drupal/core` (or `drupal/core-recommended`), updates stay Composer-compatible with the rest of the site.

---

- Apply a Drupal core patch or security release with a single "Update now" click.
- Enable unattended background core updates that run automatically during cron.
- Restrict unattended updates to security releases only (`unattended.level: security`).
- Allow all patch-level core updates unattended (`unattended.level: patch`).
- Disable unattended updates entirely while keeping the push-button flow (`unattended.level: disable`).
- Run unattended updates over the web (Automated Cron / `/system/cron`) or via the `auto-update` console command.
- See "Update readiness" warnings on the status report before an update fails.
- Get emailed when cron-time readiness checks fail (`status_check_mail`).
- Stage a core update in a sandbox copy so the live site stays online during preparation.
- Enter maintenance mode only briefly, during the final sync of the update.
- Update from the Available updates report (`/admin/reports/updates/update`).
- Preview and confirm a staged update on the "Ready to update" page before committing.
- Block downgrades, dev snapshots, and non-security/pre-release targets via version-policy validators.
- Prevent updates when the site is on an unsupported branch or Windows environment.
- Opt in to minor core updates with `allow_core_minor_updates`.
- Refuse to apply an update that includes staged database schema changes (StagedDatabaseUpdateValidator).
- Ensure only Drupal core (not stray packages) was changed in the sandbox before committing (StagedProjectsValidator).
- Warn when cron runs too infrequently for reliable unattended updates (CronFrequencyValidator).
- Run the update from the command line for CI/hosting workflows (`auto-update` binary).
- Use as a test-bed for the Automatic Updates feature that is slated for Drupal core.
- Add a custom Package Manager validator to enforce your own pre-update rules.
- Trigger readiness checks programmatically via the `StatusChecker` service.
- Set the port used for the update finalization sub-request (`cron_port`).
- Keep contrib/core update UX consistent with core's Update module (dependency).
