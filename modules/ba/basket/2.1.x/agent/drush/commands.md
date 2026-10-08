# Drush commands

Registered via `drush.services.yml` → `Drupal\basket\Commands\BasketCommands` (extends
`DrushCommands`). Both commands manage `.po` translation files for a Basket-ecosystem module and are
maintenance/build helpers, not runtime store operations.

| Command | Argument | What it does |
|---|---|---|
| `basket:po` | `$moduleName` (default `---`) | Rebuilds `translations/<project>.<langcode>.po` for the given module from the site's **translated** locale strings in that module's translation context. Deletes and recreates the module's `translations/` dir, then writes one `.po` per non-English enabled language using `PoStreamWriter` (header from the module's `project` + a plural-forms rule). The module's `.info.yml` must declare `project`. |
| `basket:po_update` | `$moduleName` (default `---`) | Imports the `.po` files under the module's `translations/` dir back into the site via the core locale batch (`locale_translate_batch_build` + `drush_backend_batch_process`). Requires the `locale` module. |

Both log via the `basket:po` / `basket:po_update` logger channels and error out if the module is not
enabled (or, for `po_update`, if `locale` is missing).

Examples:

```bash
drush basket:po basket_novaposhta        # export current translations to .po
drush basket:po_update basket_novaposhta # re-import the module's .po files
```

`data.json` `provides_drush_commands` is therefore `true`.
