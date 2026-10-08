Features packages site configuration into installable "feature" modules so a bundle of related config (content types, fields, views, permissions, etc.) can be exported to code, moved between sites, and reverted back to a known state.

---

Features groups configuration objects into **packages** (feature modules) using a pipeline of **assignment method** plugins (`Plugin/FeaturesAssignment`: base, core, alter, exclude, dependency, forward_dependency, existing, namespace, packages, optional, profile, site) that decide which config belongs to which package, then writes them out with **generation method** plugins (`Plugin/FeaturesGeneration`: `write` to the filesystem, `archive` to a downloadable tar). The behavior of the pipeline is stored in a `features_bundle` config entity (a "bundle" namespaces a set of features and holds per-assignment settings); a `default` bundle ships in `config/install`. The central `features.manager` service (`FeaturesManager`) builds the config collection, initializes packages, and detects **overrides** (active config that differs from what is exported) and **missing** config; `features_assigner` runs the assignment plugins and `features_generator` runs generation. Drush commands (`features:export`, `features:import`, `features:diff`, `features:status`, `features:list:packages`, `features:components`, `features:add`, `features:import:all`) drive the whole cycle from the CLI, and the optional **Features UI** submodule provides the `/admin/config/development/features` screens. Features depends on the **Config Update** module for diffing and reverting config. Note that on modern Drupal, core's own configuration sync (CMI) plus **Config Split** is often the preferred way to move whole-site config between environments; Features is best when you want to bundle a reusable, distributable feature (e.g. for a distribution/profile) rather than sync an entire site. Config exported by Features lives in each feature module's `config/install` (and `config/optional`) directory, so it installs like any other module's default config.

---

- Package a set of related config (a content type plus its fields, form/view displays, and a view) into one installable feature module.
- Export site configuration to code with `drush features:export` so it can be committed to version control.
- Re-apply (revert) exported config back onto a site with `drush features:import` after it drifts.
- See exactly what active config differs from a feature's stored config with `drush features:diff`.
- Check current Features status, active bundle, and enabled assignment methods with `drush features:status`.
- List all generate-able packages and their override/state with `drush features:list:packages`.
- List which configuration components exist and whether they are already exported with `drush features:components`.
- Add specific config items to an existing feature package with `drush features:add`.
- Bulk-revert every overridden installed feature at once with `drush features:import:all`.
- Bundle reusable functionality for a Drupal distribution or install profile (export with `--add-profile`).
- Create a `features_bundle` to namespace one client's or product's features separately from another's.
- Tune which config types are treated as "core"/"site"/"base" so machine-specific config is not exported.
- Exclude designated site-specific configuration (like the `features_bundle` entity itself) from packages.
- Strip UUIDs, `_core`, and user permissions from exported config via the `alter` assignment method.
- Assign config to packages automatically by module namespace so `mymodule.*` lands in `mymodule`.
- Detect configuration overrides in a CI check to fail a build when config in code and the database diverge.
- Generate a downloadable tar archive of feature modules (archive generation method) instead of writing to disk.
- Move a curated feature (e.g. an "Article" content model) from a staging site to production as a module.
- Programmatically build packages and detect overrides from custom code via the `features.manager` service.
- Implement a custom assignment method plugin to control how your project's config is grouped into packages.
- Implement a custom generation method plugin to write packages to a non-default destination.
- Track config that is "missing from active" (exists in code but not installed) to spot incomplete deployments.
- Package optional config into `config/optional` so it installs only when its dependencies are met.
- Ship a feature module that other modules can depend on to pull in a whole configuration bundle.
- Review and edit which config a feature contains through the Features UI edit screen before exporting.
- Compare Features to core CMI: use Config Split/CMI to sync a whole site, Features to distribute reusable bundles.
