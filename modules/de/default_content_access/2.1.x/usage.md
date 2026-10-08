Default Content Access is a Drush add-on that carries a node's Content Access per-node grant settings along with the node when it is exported or imported by the Default Content module.

---

The Default Content module exports and imports content (typically nodes) as serialized files inside a module's `content/` directory, which is the standard way to ship default content, recipes, and content staging in Drupal. The Content Access module stores per-node view/update/delete grant overrides in the `content_access` database table. Out of the box those two do not talk to each other, so a node exported by Default Content loses its custom access grants on the target site. Default Content Access bridges the gap by subclassing Default Content's Drush export/import commands (`DefaultContentCommands`) with `DefaultContentAccessCommands`. On export it reads the `content_access` table for every exported node UUID and writes the grant blobs to an `access/node.json` file next to the exported content; on import it reads that file back, replaces the target site's `content_access` rows for those nodes and calls `node_access_rebuild()`. The module has no UI, no configuration, no permissions and no runtime hooks — it acts only when its two Drush commands are run. It requires PHP 8.1+, Default Content `^2.0` and Content Access `^2.0`.

---

- Keep per-node Content Access grants attached to nodes shipped as default content in a custom or install-profile module.
- Export a module's nodes together with their Content Access settings using `drush default-content-access:export-module <module>` (alias `dcaem`).
- Import those nodes and reapply their Content Access grants with `drush default-content-access:import-module <module>` (alias `dcaim`).
- Stage content between environments (dev → stage → prod) without losing per-node access overrides.
- Ship a Drupal recipe or install profile whose seeded nodes already carry the correct view/update/delete grants.
- Reproduce a bug that depends on specific per-node Content Access settings in a fresh environment.
- Version-control per-node access grants as a checked-in `access/node.json` alongside the `content/` export.
- Rebuild the node access grants automatically on import so the site's access tables stay consistent.
- Re-import updated access settings with the `--update-existing` flag to also update the underlying node content.
- Bootstrap a demo or QA site whose example content needs realistic access restrictions.
- Move editorial workflow content where certain nodes are restricted to specific roles or users.
- Package intranet or membership content whose visibility must survive a deployment.
- Synchronise access settings across a multisite fleet that shares a common content module.
- Snapshot a site's content-plus-access state for disaster-recovery or migration rehearsals.
- Include access grants when handing off a site build to another team or client.
- Guarantee that anonymous-hidden nodes stay hidden after content is imported into a new build.
- Automate content-and-access seeding from CI as part of a site install pipeline.
- Avoid manually re-entering Content Access grants for every node after a content refresh.
- Keep restricted content and its restrictions together as a single, portable artifact.
