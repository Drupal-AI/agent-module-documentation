<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Markdown editor (ckeditor5_markdown_editor) — agent index

Activates CKEditor 5's `markdown-gfm` JS plugin so a text format's editor outputs GitHub-Flavored Markdown instead of HTML. Conversion is client-side; the module does no server-side Markdown-to-HTML rendering (pair with `markdown_easy` filter or `markdown_field_formatter` for output).

- **Version dir:** 1.0.x (installed 1.0.0-beta3)
- **Core:** `^10 || ^11`
- **Dependency:** `ckeditor5` (core module)
- **License:** GPL-2.0-or-later
- **No routes, no controllers, no permissions of its own.**

## What it provides

- **CKEditor 5 plugin** `ckeditor5_markdown_editor_markdown_gfm` — defined in `ckeditor5_markdown_editor.ckeditor5.yml`; loads JS plugin `markdownGfm.Markdown`, class `MarkdownOutputSettings`. Adds a per-format "Markdown output" checkbox; active only when `markdown_output: true` (plugin condition `requiresConfiguration`).
- **Config plugin class** `Plugin/CKEditor5Plugin/MarkdownOutputSettings` — configurable CKEditor 5 plugin; stores boolean `markdown_output` in the editor entity's plugin settings.
- **Drush commands** `ckeditor5_markdown_editor:install` and `:update` — download markdown-gfm build into `/libraries/ckeditor5/plugins/markdown-gfm`.
- **Service** `ckeditor5_markdown_editor_cli_commands` (`Command/CliCommandWrapper`, args: `library.discovery`, `http_client`, `config.factory`) — fetch/extract logic used by the Drush commands.
- **Config object** `ckeditor5_markdown_editor.settings` (`ckeditor_version`, `plugins_version_installed`) — version pins for asset detection.
- **Hooks** (`.module`): `hook_library_info_build()` builds a JS library per plugin; `hook_library_info_alter()` attaches the plugin lib to core CKEditor when any format enables it; `hook_ckeditor5_plugin_info_alter()` hides the plugin + logs an error if files missing; `.install` `hook_requirements()` reports install/version status.
- **Static helper** `AssetManager` — plugin/version detection, npm registry URL builders, library paths.

## Solution docs

- [config/settings.md](config/settings.md) — enabling Markdown output per text format, the plugin config, config objects & schema.
- [commands/drush.md](commands/drush.md) — install/update Drush commands, AssetManager, download/version detection, hooks.
