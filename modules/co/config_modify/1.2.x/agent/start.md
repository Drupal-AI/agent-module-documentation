# Config Modify — agent index

Lets a module declaratively modify *existing* config owned by others, via `config/modify/*.yml`
files applied when Drupal installs optional config. Developer/deployment tool: no UI, no
permissions, no routes. Depends on core `config` and contrib `update_helper`.

- **The `config/modify` file format (`dependencies` + `items`/CUD), when modifications run,
  the `config_modify.applied` tracker, service overrides** → [configure/modify-files.md](configure/modify-files.md)
- **Drush `config-modify:create` and `config-modify:pre-update`** → [drush/commands.md](drush/commands.md)

Key facts:
- Overrides core `config.installer` (`src/ConfigInstaller.php`) and `update_helper.updater`
  (`src/Updater.php`) via `ConfigModifyServiceProvider`.
- File name `<module>.<unique>.yml` in the module's `config/modify/`; keys `dependencies`
  and `items` (update_helper Config Update Definition: `add`/`change`/`delete`).
- Applied files recorded in config object `config_modify.applied`; skipped during config sync.
- Not compatible with other modules that replace the `ConfigInstaller` class (throws).
