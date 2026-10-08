<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Sync Autoclean is an experimental add-on that automatically runs Tome's unused-file cleanup (the equivalent of `drush tome:clean-files`) every time Tome Sync exports content or config, so stray files never get committed.

---

Normally you remove orphaned file exports by hand with `drush tome:clean-files`. Tome Sync Autoclean does it automatically: it registers a single event subscriber (`ExportEventSubscriber`) on Tome Sync's `tome_sync.export_content` event, and after content/config is exported it deletes any exported files that are no longer referenced by config or content (reusing Tome Sync's `CleanFilesTrait`, `ContentIndexerTrait`, and the `tome_sync.file_sync` service). It has no configuration, no permissions, no routes, and no Drush command — enabling the module is the entire setup. It is explicitly experimental and can cause data loss: for example, uploading a file at `/node/1/edit` without saving and then saving `/node/2/edit` would delete the unsaved file, and it can break revision reverts if a file was removed. Use it only if you frequently add/remove files while editing and are tired of accidentally committing unused files. To stop the behavior, uninstall the sub-module.

---

- Automatically delete unused exported files whenever Tome Sync exports content or config.
- Avoid accidentally committing stray/unused files to your content repository.
- Replace manual `drush tome:clean-files` runs with automatic cleanup on export.
- Keep the Tome files export directory tidy during heavy content editing.
- Clean up files left behind when you remove an image/file from a node and re-save.
- Reduce noise in Git diffs from orphaned file exports.
- Enforce a "no unused files" invariant on every export for editorial teams.
- Pair with Tome Sync's automatic export so cleanup happens without any commands.
- Opt into aggressive cleanup only on environments where data loss is acceptable.
- Turn the behavior on by simply enabling the sub-module (no configuration needed).
- Turn the behavior off by uninstalling the sub-module.
- Run the same logic as clean-files but triggered by the export event, not manually.
- Keep static/flat-file deployments free of dead file assets.
- Trim unreferenced files as part of an automated content export pipeline.
- Prevent unused files from bloating the repository over time.
- Use on a scratch/editing environment where files churn frequently.
- Rely on Tome Sync's file-sync service and content index to decide what is unused.
- Avoid a separate cleanup step in CI by cleaning on export.
