# Configure splits

The split collection at `/admin/config/development/configuration/config-split`:
![Configuration Split list](../../../../../../../screenshots/config_split/2.0.x/list.png)

Each split is a `config_split` config entity (`config_split.config_split.<id>`, schema
`config/schema/config_split.schema.yml`). Manage at
`/admin/config/development/configuration/config-split` (collection route
`entity.config_split.collection`); add/edit form `ConfigSplitEntityForm`.

Entity fields:

| Key | Type | Meaning |
|---|---|---|
| `id` / `label` | string | Machine name / human label. |
| `description` | label | What this split is for. |
| `status` | bool | Whether the split is active (can be overridden per environment). |
| `weight` | int | Order splits are applied. |
| `storage` | string | Where split config lives: `folder`, `collection`, or `database`. |
| `folder` | string | Filesystem path for the split's config (when `storage: folder`). |
| `stackable` | bool | Allow this split to combine with other active splits. |
| `no_patching` | bool | Disable partial-split patch/merge behavior. |
| `module` | sequence | Modules whose config is split out (map of name→weight). |
| `theme` | sequence | Themes whose config is split out. |
| `complete_list` | sequence | Config names fully removed from main sync ("complete" split). |
| `partial_list` | sequence | Config names kept in sync but overridden here as a patch ("partial" split). |

- **Complete split**: config listed here (or belonging to a split module) is removed from the
  main export and stored only in the split — the module/config is absent on environments where
  the split is inactive.
- **Partial split**: base config stays in the main sync; only the per-environment differences
  are stored as a patch and merged on import.
- Per-split operations (own routes/forms): **Activate**, **Deactivate**, **Import**, **Export**,
  plus **Enable/Disable** (toggle `status` only) and a **diff** viewer.
- Splits integrate automatically with core `config:import`/`config:export` via
  `SplitImportExportSubscriber`; you normally just run the standard sync commands.
