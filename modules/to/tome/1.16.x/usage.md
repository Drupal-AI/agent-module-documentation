<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome is a static site generator and flat-file content store for Drupal: it exports your whole site to static HTML for production and can keep all content, config, and files on disk as JSON so a site can be rebuilt from Git with no persistent database.

---

Tome is an umbrella module that installs two sub-modules that do the real work: **Tome Static** (`tome_static`) renders every public path of your Drupal site to static HTML with `drush tome:static`, and **Tome Sync** (`tome_sync`) serialises content, config, and files to a tracked directory (`../content`, config sync, `../files`) so the site can be reinstalled and re-imported with `drush tome:import`. Both share code via **Tome Base** (`tome_base`). Once Tome Sync is on, every content edit is automatically written back to the JSON content store, so the on-disk export stays in sync as you work locally. When the repository looks right you generate static HTML and upload it to any host — no PHP or database needed in production. Output locations are controlled by `settings.php` keys (`tome_content_directory`, `tome_files_directory`, `tome_static_directory`, `tome_sync_encoder`) rather than admin config. Optional add-on sub-modules cover cron-driven builds (`tome_static_cron`), longer-lived static caching (`tome_static_super_cache`), and automatic cleanup of unused file exports (`tome_sync_autoclean`). Tome exposes admin UIs under `/admin/config/tome`, but the Drush commands are the primary interface.

---

- Publish a Drupal site as static HTML and host it on Netlify, GitHub Pages, S3, or any static host.
- Remove the database and PHP from production entirely for a hardened, cheap, fast site.
- Store all content as JSON files in Git so content changes are code-reviewed like code.
- Rebuild a fresh site from scratch on any machine with `drush si` then `drush tome:import`.
- Do an initial export of an existing site's content, config, and files with `drush tome:export`.
- Generate the full static build for production with `drush tome:static --uri=https://example.com`.
- Preview the generated static site locally with `drush tome:preview`.
- Keep local content edits automatically exported to disk while editing, ready to commit.
- Move content between environments by committing and pulling the `../content` directory.
- Run a static build unattended on cron using the `tome_static_cron` sub-module.
- Keep Tome Static caches warm across normal cache clears with `tome_static_super_cache`.
- Export only paths matching a pattern with `drush tome:static --path-pattern=...`.
- Serve a decoupled/JAMstack front end from Drupal-managed static output.
- Give editors a normal Drupal editing experience while shipping a static production site.
- Version content, config, and files together in one repository for reproducible builds.
- Sync only what changed with `drush tome:import-partial` for faster incremental imports.
- Clean up unused exported files with `drush tome:clean-files`.
- Export or import a single entity with `drush tome:export-content` / `drush tome:import-content`.
- Choose JSON (default) or experimental YAML as the content encoder via `tome_sync_encoder`.
- Symlink or externalise the files directory using a custom `tome_sync.file_sync` service.
- Build a documentation or marketing site in Drupal and deploy it as flat files.
- Avoid database-driven production security surface by shipping only HTML/CSS/JS.
- Archive a site as a downloadable static snapshot via the Tome Static admin UI.
- Run content and static generation in separate processes for large sites (`--process-count`).
- Trigger custom logic during export/import via Tome Sync events, or alter the static build via Tome Static events.
