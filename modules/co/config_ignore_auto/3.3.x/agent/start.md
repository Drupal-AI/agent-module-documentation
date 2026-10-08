# Config Ignore Auto — agent index

Extends [Config Ignore]. When active, it auto-adds any config object that gets edited on the live site to
the ignore list, protecting live edits from being overwritten on `drush cim`. Inactive by default
(`status: false`) — enable via UI or, on prod, `$config['config_ignore_auto.settings']['status'] = TRUE;`.

- **Settings keys, the events/hooks driving it, and the safety exclusions** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `config_ignore_auto.settings`: `status`, `show_message`, `ignored_config_entities` (auto-managed),
  `whitelist_config_entities` (default `[core.extension]`), `direction_operations`
  (`import_create|import_update|import_delete|export_*`).
- Settings route `config_ignore_auto.settings` →
  `/admin/config/development/configuration/ignore_auto` (permission `import configuration`).
- Event subscriber `ConfigIgnoreAutoEventsSubscriber` on `ConfigEvents::SAVE`/`DELETE` diffs current vs
  original and appends the changed config name (writes directly to config storage to avoid factory recursion).
- Does NOT auto-ignore during config sync, module (un)install, or maintenance mode; always ignores its own
  `ignored_config_entities`; feeds names to Config Ignore via `hook_config_ignore_ignored_alter`.
- No permissions of its own, no Drush commands, no plugins.
