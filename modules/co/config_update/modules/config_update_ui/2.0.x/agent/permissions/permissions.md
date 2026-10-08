# config_update_ui permissions

From `config_update_ui.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `view config updates report` | Viewing the update report, diffs (routes `config_update_ui.report`, `.diff`) | |
| `revert configuration` | Reverting any config item to its default (`config_update_ui.revert`) | **restricted** — full control over site config |
| `delete configuration` | Deleting any config item (`config_update_ui.delete`) | **restricted** — destructive |

Both restricted permissions carry `restrict access: true` (security warning on the
permissions form). Grant only to trusted administrators. The import route
(`config_update_ui.import`) additionally requires core's `import configuration` permission.
