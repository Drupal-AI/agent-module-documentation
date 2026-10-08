# Structure Sync Drush commands

Defined in `src/Commands/StructureSyncCommands.php` (registered via `drush.services.yml`).
Every command operates on the `structure_sync.data` config object: **export** writes current
entities into it; **import** reads it back into entities. Import commands take a style choice.

| Command | Aliases | Action |
|---|---|---|
| `export:taxonomies` | `et`, `export-taxonomies` | Export taxonomy terms → config |
| `import:taxonomies` | `it`, `import-taxonomies` | Import taxonomy terms from config |
| `export:blocks` | `eb`, `export-blocks` | Export custom blocks → config |
| `import:blocks` | `ib`, `import-blocks` | Import custom blocks from config |
| `export:menus` | `em`, `export-menus` | Export menu links → config |
| `import:menus` | `im`, `import-menus` | Import menu links from config |
| `export:all` | `ea`, `export-all` | Export taxonomies + blocks + menus |
| `import:all` | `ia`, `import-all` | Import taxonomies + blocks + menus |

## Import style option

Import commands accept `--choice=<style>` where style is `full`, `safe`, or `force`. If omitted,
the command prompts interactively.

- `safe` — only add missing entities; no updates or deletes.
- `full` — safe, plus update existing entities (matched by UUID).
- `force` — delete all entities of that type, then recreate from config (destructive).

```bash
# Export everything on the source environment
drush export-all

# ...commit structure_sync.data.yml, deploy, then on the target:
drush config:import -y            # brings structure_sync.data across (if using config sync)
drush import-taxonomies --choice=full
drush import-all --choice=safe    # add-only import of all three types
```

`import-all` simply runs the three per-type imports in order (taxonomies, blocks, menus) with the
same style; `export-all` runs the three exports. Each command is guarded by
`@validate-module-enabled structure_sync`.
