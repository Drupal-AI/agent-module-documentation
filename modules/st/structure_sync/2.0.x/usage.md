Structure Sync exports content that behaves like configuration — taxonomy terms, custom (content) blocks, and menu links — into a `structure_sync.data` config object so it can be deployed between environments alongside the rest of your site config.

---

Drupal's configuration management (CMI) moves *configuration* between environments, but taxonomy terms, custom block content, and menu links are stored as *content* entities and therefore do not travel with `drush config:export`. Structure Sync bridges that gap: it reads those three content types and writes them into a single config object, `structure_sync.data`, which you then commit and deploy like any other config. On the target environment you import them back into real entities. Each of the three types (taxonomies, blocks, menus) has its own export and import, plus "export all" / "import all" shortcuts. Imports run in three styles — **safe** (only add what's missing, never update or delete), **full** (safe, plus update entities that already exist by UUID), and **force** (delete everything of that type first, then recreate from config) — so you can choose how aggressively the target should match the source. Everything is available both as admin screens under Admin → Structure → Structure Sync and as Drush commands (`export-taxonomies`, `import-menus`, `export-all`, etc.). Entities are matched by UUID so repeated imports are idempotent. A general settings screen toggles logging of the module's operations. Access to all screens is gated by the core `administer site configuration` permission; the module defines no permissions of its own.

---

- Deploy taxonomy terms created on staging to production without re-entering them by hand.
- Move custom (content) block bodies through your Git-based config deployment pipeline.
- Keep menu links in sync across dev, staging, and production environments.
- Export taxonomy terms, custom blocks, and menu links in one step with `export-all`.
- Import all three structure types on the target environment with `import-all`.
- Snapshot the current terms/blocks/menus into `structure_sync.data` config for versioning in Git.
- Seed a fresh environment's vocabularies with their terms after a `config:import`.
- Add only newly created terms to production using the "safe" import style (no updates, no deletes).
- Update already-deployed terms/blocks/menus in place using the "full" import style (matched by UUID).
- Rebuild a target environment's terms exactly to match source using the "force" import style (delete then recreate).
- Reproduce a site's main navigation menu structure on another install.
- Carry footer/utility menu links along with a config deployment.
- Include hand-authored custom block content (marketing copy, notices) in a repeatable deployment.
- Version-control content structure so a rollback restores terms/blocks/menus too.
- Script structure export/import inside a CI/CD deploy step via Drush.
- Automate a nightly export of content structure to config for backup.
- Bootstrap a new team member's local site with real terms, blocks, and menus from committed config.
- Migrate menu links and taxonomy terms when splitting or merging sites.
- Toggle logging of Structure Sync operations on the general settings screen.
- Keep imports idempotent (UUID-matched) so re-running an import does not duplicate entities.
- Restrict who can run sync operations via the core `administer site configuration` permission.
- Recover deleted terms by re-importing from the last exported `structure_sync.data`.
- Sync only one structure type (e.g. just menus) when that is all that changed.
- Fill the gap left by core CMI, which cannot move content entities between environments.
