DevUtils is a Drupal developer-tools module providing Drush commands to list entity UUIDs and delete unused files, plus a service for importing specific module configuration.

---

DevUtils ships no admin UI, routes, or permissions. It exposes two Drush commands and one autowired service. `drush devutils:uuid <entity-type> [<filter>] [--label]` prints the UUIDs of entities of a supported type (node, media, file, term, block_content, menu_link_content, paragraph), optionally narrowed by bundle/menu and optionally prefixed with the entity label. `drush devutils:clear-files` loads every managed file and deletes those whose `file.usage` record count is zero. The `devutils.update_import` service (`Drupal\devutils\ConfigImport::import()`) reads named config objects from a target module's `config/install` and `config/optional` directories and applies them to active storage through a `StorageComparer`/`ConfigImporter`, importing only the requested configs (or all of them) and their translation collections — intended for use from `hook_update_N()` to roll out configuration changes. The commands operate on live site data and are meant for developers/site builders with shell access; run them in development environments and back up before clearing files.

---

- List all node UUIDs: `drush devutils:uuid node`.
- List UUIDs for a single content type: `drush devutils:uuid node page`.
- List UUIDs with each entity's label as a comment prefix: `drush devutils:uuid node page --label`.
- Enumerate media UUIDs across all bundles: `drush devutils:uuid media`.
- Enumerate media UUIDs for one bundle: `drush devutils:uuid media image`.
- List every managed file's UUID: `drush devutils:uuid file`.
- List taxonomy term UUIDs for a vocabulary: `drush devutils:uuid term tags`.
- List all taxonomy term UUIDs: `drush devutils:uuid term`.
- List block_content (custom block) UUIDs by block type: `drush devutils:uuid block basic`.
- List menu link UUIDs within a menu: `drush devutils:uuid menu_link main`.
- List paragraph UUIDs by paragraph type: `drush devutils:uuid paragraph text`.
- Capture a stable UUID list for migrations or config that references specific entities.
- Diff UUIDs between two environments to confirm content parity after a sync.
- Delete all managed files that no longer have any usage records: `drush devutils:clear-files`.
- Reclaim disk space from orphaned uploads left behind after content deletion.
- Clean up test/fixture files in a scratch environment before a fresh import.
- Import a single config object shipped by a module from an update hook: `\Drupal::service('devutils.update_import')->import('my_module', ['my_module.settings']);`.
- Import several named config objects from a module in one update step by passing an array of names.
- Re-apply all of a module's `config/install` and `config/optional` configuration: `\Drupal::service('devutils.update_import')->import('my_module');`.
- Roll out new configuration (with its translations) added by a module release without a full config sync.
- Log import progress via the `devutils` logger channel while a `hook_update_N()` runs.
- Script UUID exports and file cleanup as part of a CI or deployment maintenance step.
