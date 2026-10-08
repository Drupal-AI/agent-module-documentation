<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories gives Drupal Media entities a folder structure backed by a taxonomy vocabulary: every term is a directory, term nesting is folder nesting, and a `directory` base field on each media item records where it lives.

---

The base module is deliberately small. `hook_entity_base_field_info()` adds a `directory` entity-reference base field to the `media` entity type, targeting `taxonomy_term` through the module's own selection handler `media_directory:default` (`DirectorySelection extends TermSelection`), whose option labels are indented with `−` characters to render the tree in a plain select. Which vocabulary counts as "the folders" is a single config value: `media_directories.settings` → `directory_taxonomy`; a second key `all_files_in_root` decides whether the Root directory shows only unfiled media (default) or everything. The settings form at `/admin/config/media/media_directories` (route `media_directories.config_form`, permission *administer site configuration*) can also create a new vocabulary inline, and flushes all caches whenever the vocabulary changes because the base field definition depends on it. For Views the module registers a filter (`media_directory`, class `MediaDirectory extends ManyToOne`) and a contextual filter/argument (`media_directory`, class `MediaDirectoryArgument`) on `media_field_data.directory`, both of which special-case the "Root" value: `MediaDirectoryRoot::VALUE` is `-1` (not `0`, which Views treats as empty) and the query becomes `directory IS NULL`, optionally OR-ed with `IS NOT NULL` when `all_files_in_root` is on. `hook_install()` injects that exposed `directory` filter into core's `media_library` view (default, widget and widget_table displays) and the `media` admin view, and `hook_uninstall()` removes it again. A `hook_media_presave()` guard nulls out any directory target id `<= 0` so the sentinel root value is never stored. Everything visual — the Vue.js browser, the CKEditor integrations, AI alt text, inline image resizing and the legacy embed shim — lives in the seven submodules.

---

- Organise a large media library into nested folders instead of one flat list.
- Give editors a "Directory" select on every media edit form.
- Filter core's Media Library by directory while embedding media into content.
- Add a directory column/filter to the `/admin/content/media` overview.
- Use an existing taxonomy vocabulary (e.g. "Assets") as the folder tree.
- Create the folder vocabulary inline from the module's own settings form.
- Treat the Root directory as an "unfiled inbox" showing only media with no directory.
- Flip `all_files_in_root` so Root instead shows every media item on the site.
- Build a custom View of media filtered by a chosen directory term.
- Build a directory-scoped page with the `media_directory` contextual filter (pass `-1` for Root).
- Restrict a media reference field to media from one department's folder via a View.
- Move media between folders by changing the `directory` field value.
- Query media by directory programmatically with `$query->condition('directory', $tid)`.
- Report on how many media items live in each folder.
- Give each site section its own media folder while keeping one media library.
- Mirror an existing file-system folder layout in the media library.
- Let permissions on the directory vocabulary control who sees which folders (with a taxonomy access module).
- Translate folder names by making the directory vocabulary translatable.
- Rename or re-parent a folder by editing/moving the taxonomy term — all media follow automatically.
- Bulk-assign a directory to many media items with Views Bulk Operations.
- Add a directory facet to a media search.
- Keep the directory field out of a form display where editors shouldn't set it.
- Migrate legacy asset folders by importing terms and setting `directory` during migration.
- Use the `media_directory:default` selection handler on your own entity reference field to get the same indented tree widget.
- Layer the Vue browser (`media_directories_browser`) on top for drag-and-drop folder management.
