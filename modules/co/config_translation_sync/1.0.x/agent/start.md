<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Translation Sync (config_translation_sync) — agent index

info.yml name **Config Translation Sync**, installed version **1.0.2**. Copies translated
configuration (`language.<langcode>.<config_name>` overrides) from the config **sync** storage
into the **active** storage, so config translations aren't lost or left stale when config is
deployed. Package `Config`. Core `^10 || ^11 || ^12`. Depends on core **`config_translation`**.
License GPL-2.0-or-later.

Primary entry point is the Drush command `config:resync-translations` (alias `crst`), run
on demand or in a deploy script. The module also ships a config-import event subscriber intended
to re-sync automatically after every `drush cim` — but see the wiring note below: **it is not
registered as a service in 1.0.2, so the automatic path is inert as shipped**; `crst` is the
working path. A settings form stores the default language + exclusion lists. Single-purpose
module; all logic lives in one service — no subdocs needed.

## What it provides (from source)

- **Service** `config_translation_sync.syncer` → `Services\ConfigTranslationSyncer`
  (implements `ConfigTranslationSyncerInterface`). Constructor deps: `config.factory`,
  `language_manager`, `config.storage` (active), `config.storage.sync`, dedicated logger channel
  `config_translation_sync`.
  - `sync(array $include_patterns = [], array $exclude_patterns = [], ?string $langcode = NULL): void`
    — the only public method. Resolves excludes (arg → `excluded_configs` setting), builds the
    config list via `filterConfigs()` (sync storage `listAll()`, then include/exclude patterns),
    resolves target langcodes (arg CSV → `enabled_languages` setting → all
    `language_manager` languages), then for each config×lang calls `syncConfig()`.
  - `syncConfig()`: for key `language.<langcode>.<config_name>`, if it `exists()` in sync
    storage and the read data is non-empty and `!==` active data, `activeStorage->write()`s it and
    logs an info message. The write goes straight to the active config storage service (`config.storage`).
  - `applyPatterns()`: wildcard `*` only, via `preg_quote()` then `\*`→`.*` (no arbitrary regex).
- **Event subscriber** `EventSubscriber\ConfigImportSubscriber` on `ConfigEvents::IMPORT`
  (`onPostImport`): merges the `update` + `create` changelists and calls `syncer->sync($changed)`
  when non-empty. **Wiring gap (verified in 1.0.2):** this class is NOT declared in
  `config_translation_sync.services.yml` and carries no `event_subscriber` tag — Drupal never
  instantiates it, so the event never fires and the "automatic sync on every config import" is
  inert as shipped. The class is effectively dead code until a maintainer adds the service
  definition. Use `drush crst` to get the sync behavior.
- **Drush command** `Drush\Commands\ConfigTranslationSyncCommands::resyncTranslations`,
  name `config:resync-translations`, alias `crst`. Options: `--config-names` (CSV of names/patterns,
  → include), `--exclude` (CSV, → exclude), `--langcode` (CSV, → target langs). Each CSV is
  `explode(',')` + `trim`.
- **Settings form** `Form\ConfigTranslationSyncSettingsForm` (`ConfigFormBase`) at
  route `config_translation_sync.settings` → `/admin/config/development/config-translation-sync`,
  permission **`administer config translation sync`**. Fields: `enabled_languages`
  (checkboxes of `language_manager` languages) and `excluded_configs` (textarea, one pattern per
  line). Editable config object: `config_translation_sync.settings`.
- **Permission** `administer config translation sync` (`.permissions.yml`).
- **Config** `config_translation_sync.settings` — keys `enabled_languages` (sequence of langcodes)
  and `excluded_configs` (sequence of config names/patterns). Schema in `config/schema/`.
- **Menu link** under `system.admin_config_development`.
- No `.module`, no `.install`, no hooks, no entities, no plugin types.

## Behavior notes

- The sync direction is always **sync dir → active** for `language.*` translation overrides. It
  never writes to the sync directory and never touches non-`language.*` config.
- Precedence: an explicit arg (include/exclude/langcode) overrides the stored setting; empty
  include = all configs in sync storage; empty langcode + empty `enabled_languages` = all site
  languages.
- If no config matches, logs a notice and returns (no-op).
- Include/exclude patterns are matched against **sync storage** names, and only translation
  overrides that already exist in sync storage are copied.

## Usage & manual guides

- CLI/deploy usage and examples → [../usage.md](../usage.md)
- Human setup guide → [../human-docs/index.md](../human-docs/index.md)
