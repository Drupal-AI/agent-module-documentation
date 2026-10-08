Features UI is the optional admin interface for the Features module, adding the screens at Admin → Configuration → Development → Features where you create, edit, export, diff, and download feature modules and configure bundles.

---

Features UI provides the browser front end for everything the Features module can do from Drush. The main page (`/admin/config/development/features`, route `features.export`, form `FeaturesExportForm`) lists generate-able packages with their state (Default, Overridden, …) and lets you select config and export or download feature modules. An **Edit** screen (`FeaturesEditForm`) lets you add or remove individual configuration items from a package before exporting, and a **Differences** screen (`FeaturesDiffForm`) shows the diff between active config and a feature's stored config. A set of **bundle assignment** forms under `/admin/config/development/features/bundle/...` (Configure Bundles, plus per-method Alter, Base, Core, Exclude, Optional, Profile, Site screens) edit the `features_bundle` config entity and its assignment-method settings. Downloads are served through the base module's `features.export_download` route as a tar archive (archive generation method). The module adds admin menu/tab/action links and a small amount of CSS/JS, but defines no config schema, permissions, plugin types, or Drush commands of its own — it depends on `features:features` and reuses core permissions (`export configuration` for viewing/exporting, `administer site configuration` for editing bundles and features). It is purely a convenience layer: on a code-first or CI workflow you can skip it entirely and use the `drush features:*` commands.

---

- Browse all generate-able feature packages and their override state in the UI.
- Export selected configuration into a feature module without touching Drush.
- Download a feature as a tar archive from the browser.
- Add or remove specific config items from a package on the Edit screen before exporting.
- Review the diff between active config and a feature's stored config visually (Differences tab).
- Create a brand-new feature via the "Create new feature" action link.
- Configure a `features_bundle` and its assignment settings through the Configure Bundles form.
- Adjust the Alter assignment method (strip core/uuid/user_permissions) in a bundle via its form.
- Tune Base, Core, and Site assignment types (which config types go into which package) in the UI.
- Configure the Exclude assignment to keep site-specific config out of packages.
- Set up Optional assignment so config is exported into `config/optional`.
- Configure Profile assignment to package config into an install profile.
- Spot overridden features at a glance so an editor knows what needs importing/reverting.
- Give non-CLI site builders a way to package configuration into modules.
- Demonstrate/teach how Features groups config by showing the live package assignments.
- Detect a feature's status via the AJAX `features.detect` endpoint used by the list form.
- Provide an admin landing tab under Configuration → Development for config packaging.
- Let a distribution author curate exactly which config ships in each feature module.
- Preview which components are already exported vs. not before generating a package.
- Hand off config-packaging to a client's admin without teaching them Drush.
