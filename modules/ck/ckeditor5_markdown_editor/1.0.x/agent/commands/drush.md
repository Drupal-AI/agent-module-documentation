<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands & asset management

The markdown-gfm CKEditor plugin is a JS build that does not ship inside this module; it must be placed at `<docroot>/libraries/ckeditor5/plugins/markdown-gfm/build/markdown-gfm.js`. The Drush commands fetch it from the npm registry.

## Commands

Defined in `Command/Drush/CKEditorMarkdownEditorCommands` (tagged `drush.command` in `drush.services.yml`):

- `drush ckeditor5_markdown_editor:install` → `InstallCommand::execute()`
- `drush ckeditor5_markdown_editor:update` → `UpdateCommand` (an empty subclass of `InstallCommand`; behaves identically)

Both delegate to the `ckeditor5_markdown_editor_cli_commands` service (`Command/CliCommandWrapper`) via the `CKEditorCliCommandInterface` contract (`getInput`/`getIo`/`getMessage`/`confirmation`/`comment`). Command message strings come from `command/translations/en/ckeditor5_markdown_editor.install.yml` (loaded in `InstallCommand::setMessages()`).

## Download & install flow

`CliCommandWrapper` (constructed with `library.discovery`, `http_client` (Guzzle), `config.factory`):

1. `askToOverwritePluginFiles()` — unless `--yes`, prompts before overwriting an existing `/libraries/ckeditor5/plugins/` directory.
2. `overwritePluginFiles()` → `downloadCKEditorFull()`:
   - Resolves the target version via `AssetManager::getCKEditorVersion()`.
   - Metadata URL: `AssetManager::getNPMRegistryPackageUrl($version)` = `https://registry.npmjs.org/@ckeditor/ckeditor5-markdown-gfm/<version>`.
   - `getNPMRegistryDistUrl()` GETs that JSON and reads `dist.tarball` for the archive URL.
   - `downloadFile()` GETs the tarball with Guzzle `['sink' => <tmp .tgz>]` into `sys_get_temp_dir()`.
   - Extracts with core's `Drupal\Core\Archiver\Tar` into a temp dir.
3. `installCKEditorPlugin()` — `mkdir` + `Filesystem::mirror()` the extracted `package/` into `/libraries/ckeditor5/plugins/markdown-gfm` (overwrite honored per the prompt).
4. Writes `plugins_version_installed` into `ckeditor5_markdown_editor.settings` and runs `drupal_flush_all_caches()`.

All fetch URLs are hardcoded to the public npm registry (no request-derived input); Guzzle uses default (verified) TLS. This is an admin-only CLI operation.

## AssetManager (`src/AssetManager.php`)

Static helper; key methods:

- `getPlugins()` → `['markdown-gfm']` (the only plugin managed).
- `pluginIsInstalled($name)` / `pluginsAreInstalled()` — check `<docroot>/libraries/ckeditor5/plugins/<name>/build/<name>.js` exists.
- `getPluginsInstallStatuses()` — map of plugin → installed bool.
- `getCKEditorVersion()` — config `ckeditor_version` if set, else parse `core/core.libraries.yml` (`parseForCoreCKEditorVersion()`), else fallback `4.5.x` (`$libraryVersion`).
- `getPluginsInstalledVersion()` / `getPluginsVersion()` — from config `plugins_version_installed`, falling back to detected CKEditor version.
- `getCKEditorLibraryPluginPath()` (URL, `base_path().'libraries/ckeditor5/plugins/'`) / `getCKEditorLibraryPluginDirectory()` (absolute FS path).
- `getNPMRegistryPackageUrl()`, `getCKEditorDevFullPackageName()` — npm package name/URL builders.

## Status & runtime hooks

- `.install` `hook_install()` — warns (messenger) if plugin files are absent.
- `.install` `hook_requirements('runtime')` — status-report row "CKEditor Markdown plugin": `Installed` / `Missing plugins` (error) / `Mixed versions` (plugin build differs from core CKEditor version).
- `.module` `hook_ckeditor5_plugin_info_alter()` — if not all plugins installed, unsets the plugin definition and logs an error listing missing plugins.
- `.module` `hook_library_info_build()` — dynamically defines a JS library per plugin pointing at the on-disk build file (`type: external`, depends on `ckeditor5/ckeditor5`).

Helper `_ckeditor5_markdown_editor_get_install_instructions()` in `.module` builds the "run drush …" install/update message shown in warnings and the status report.
