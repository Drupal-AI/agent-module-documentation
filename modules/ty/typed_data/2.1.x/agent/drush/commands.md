# typed_data Drush commands

Provided by `src/Drush/Commands/TypedDataDrushCommands.php`. All are read-only introspection
helpers useful when developing against the Typed Data / data-fetcher APIs.

| Command | Aliases | Shows |
|---|---|---|
| `typed-data:entities` | `el`, `entity-list` | Available entity types |
| `typed-data:contexts` | `cl`, `context-list` | Available contexts |
| `typed-data:datatypes` | `tl`, `datatype-list` | Registered TypedData data types |
| `typed-data:datafilters` | `fl`, `datafilter-list` | Registered `typed_data_filter` (DataFilter) plugins |
| `typed-data:formwidgets` | `wl`, `formwidget-list` | Registered `typed_data_form_widget` plugins |

Example:
```
drush typed-data:datafilters   # or: drush fl
drush typed-data:datatypes     # or: drush tl
```
