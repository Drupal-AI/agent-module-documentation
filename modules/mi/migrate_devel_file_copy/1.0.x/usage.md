<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Devel FileCopy provides a single migrate process plugin, `file_copy_or_generate`, that behaves like core's `file_copy` but generates a placeholder file at the destination when the real source file cannot be found — handy for building a working environment from a database dump whose original files are unavailable.

---

The plugin (`FileCopyOrGenerate`) extends core `FileCopy` and simply delegates to the parent `transform()`. Only when the parent throws a "File … does not exist" `MigrateException` (or the source is a non-local URI) does it fall back: if the destination already exists it returns it; otherwise it ensures the destination directory is writable (creating it if needed) and generates a file based on the source's extension — a random image via `Random::image()` for jpg/jpeg/gif/png/bmp, or a tiny text file (four `*` characters) for txt/anything else. It is used exclusively from migration definitions (the process pipeline) and has no routes, controllers, forms, services, permissions or config — so there is no web-facing surface. The source and destination paths come from the migration YAML authored by the developer running the migration, not from untrusted request input, and writes go through core's `FileSystem::prepareDirectory`/`move`; there is no attacker-controlled path-traversal or arbitrary-write vector beyond what the migration author already controls. This is explicitly a development/testing aid, not intended for production content.

Typical use: swap `plugin: file_copy` for `plugin: file_copy_or_generate` on a file/image field's process step so missing binaries are replaced with placeholders and the migration completes.
---
- Replace `file_copy` with `file_copy_or_generate` in a migration process step.
- Complete a migration even when original source files are missing.
- Generate a random placeholder image for missing jpg/jpeg/gif/png/bmp sources.
- Generate a small placeholder text file for missing txt (or other) sources.
- Build a local dev environment from a DB dump without the original file tree.
- Preserve the original file extension on generated images (e.g. keep `.JPEG`).
- Reuse an already-present destination file instead of regenerating it.
- Auto-create the destination directory when it does not exist.
- Skip the row cleanly if a placeholder cannot be generated.
- Keep the same `source`/`destination`/`replace` arguments as core `file_copy`.
- Handle non-local source URIs by generating a destination file.
- Test image-style/derivative pipelines without real assets.
- Populate media/file fields for QA content.
- Avoid migration failures caused by 404 remote files during development.
- Stand up demo sites quickly from production data.
