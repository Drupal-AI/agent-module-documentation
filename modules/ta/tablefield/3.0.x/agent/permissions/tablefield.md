# Permissions

Defined in `tablefield.permissions.yml`. The widget checks these per current user to decide
which controls to show; the export route requires `export tablefield`.

| Permission | Gates |
|---|---|
| `export tablefield` | The "Export Table Data" CSV link / `tablefield.export` route (also needs the field's `export` setting on and `view` access to the entity) |
| `rebuild tablefield` | The "Change number of rows/columns" rebuild control in the widget (enforced when a field's `restrict_rebuild` is on) |
| `import tablefield` | The "Import from CSV" file upload in the widget (enforced when `restrict_import` is on) |
| `paste tablefield` | The "Copy & Paste" import box in the widget |
| `addrow tablefield` | The "Add Row" button in the widget |
| `configure tablefield` | The global module settings form (`tablefield.admin` — CSV separator, default rows/cols) |

```
drush role:perm:add editor 'import tablefield'
```

Note: `export` route access also runs a custom check (`TablefieldController::access`) that
confirms the target field is a `tablefield` and the user has `view` access to the entity.
