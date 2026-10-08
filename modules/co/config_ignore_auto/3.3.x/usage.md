Config Ignore Auto watches for configuration that gets edited on a running site and automatically adds each changed config object to Config Ignore's ignore list, so those live edits are protected from being overwritten on the next config import.

---

An extension of Config Ignore, this module is inactive until you switch its `status` on (typically via `$config['config_ignore_auto.settings']['status'] = TRUE;` in settings.php on production). Once active, a config CRUD event subscriber (`ConfigIgnoreAutoEventsSubscriber`) listens for `ConfigEvents::SAVE`/`DELETE` (and their in-collection variants); when a config object actually changes (it diffs current vs. original to skip no-op saves) it appends that config name to `ignored_config_entities` in the module's own settings and writes it straight to config storage. A `hook_config_ignore_ignored_alter` implementation then feeds those names into Config Ignore for the configured `direction_operations` (any of import/export × create/update/delete). It deliberately does **not** auto-ignore during config sync (`isConfigSyncing()`), during module install/uninstall, or while the site is in maintenance mode (so database updates that change config are not captured) — instead it warns on config forms in maintenance mode. A whitelist (default `core.extension`) lists config that must never be auto-ignored, and the module always force-ignores its own `ignored_config_entities` list. The settings UI lives at Configuration synchronization → Ignore Auto (permission `import configuration`), and it integrates with Domain Config UI by disallowing its own settings there. The main use case is client-managed sites where end users edit views/webforms/blocks and you want those edits preserved automatically.

---

- Automatically preserve editor-made changes to Views on the next config import.
- Protect webforms clients build in the UI from being reverted by deployments.
- Keep block/block-layout edits made on production out of harm's way during config sync.
- Turn the whole feature on only in production via a settings.php override.
- Choose exactly which sync directions/operations the auto-ignores apply to (import vs export, create/update/delete).
- Prevent database updates (hook_update_N) that change config from being auto-ignored by using maintenance mode.
- Whitelist specific config names (e.g. `core.extension`) so they are never auto-ignored.
- Show a status message each time a config object is auto-added to the ignore list.
- Review and prune the auto-generated ignore list from the settings form.
- Avoid manually maintaining long Config Ignore patterns for client-editable config.
- Stop content-editors' menu or taxonomy config tweaks from being clobbered on deploy.
- Keep third-party module settings that admins changed on the live site.
- Combine with Config Ignore's own manual patterns for a hybrid ignore strategy.
- Disable auto-tracking temporarily while keeping already-ignored items ignored (toggle `status`).
- Integrate cleanly with Domain Config UI (its own settings are excluded there).
- Detect real changes only (no-op form submits that change nothing are skipped).
- Audit which live edits diverged from code by inspecting the accumulated ignore list.
- Safely run `drush cim` on client sites without reverting in-UI configuration work.
- Scope ignoring to export operations to keep local exports from dropping production edits.
- Reset tracking by clearing `ignored_config_entities` when you have merged edits back to code.
