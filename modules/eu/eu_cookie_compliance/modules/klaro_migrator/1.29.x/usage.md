A submodule of EU Cookie Compliance that migrates an existing EUCC configuration to the Klaro cookie‑consent module.

---

klaro_migrator is a helper submodule shipped with EU Cookie Compliance for sites that want to switch from EUCC to the Klaro module. It provides a migration form (`/admin/config/system/eu-cookie-compliance/klaro-migration`, permission `administer eu cookie compliance popup`) backed by a `KlaroMigrationManager` service that reads the current EUCC settings and cookie categories and creates the equivalent Klaro configuration. It depends on both `eu_cookie_compliance` and the contributed `klaro` module. It is intended as a one‑time transition aid rather than an ongoing feature, so you enable it, run the migration, review the resulting Klaro config, then uninstall it. No new permissions, config schema, or plugin types are added.

---

- Migrate EU Cookie Compliance settings to the Klaro module in one step.
- Move existing EUCC cookie categories over to Klaro services/purposes.
- Reduce manual re‑entry when adopting Klaro on an established site.
- Preview the mapping from EUCC config to Klaro before committing.
- Provide a starting Klaro configuration derived from your current banner setup.
- Transition a site from the older EUCC UX to Klaro's consent manager.
- Keep consent‑management continuity while changing modules.
- Run the migration from an admin form without writing code.
- Use the `KlaroMigrationManager` service programmatically from custom code.
- Enable temporarily as a one‑off migration tool, then uninstall.
- Standardise multiple sites on Klaro after starting with EUCC.
- Avoid rebuilding cookie categories by hand in Klaro.
- Support a staged rollout: migrate config, verify, then switch the active banner.
- Help agencies hand off sites already configured for GDPR consent.
- Bridge EUCC and Klaro during an incremental compliance upgrade.
