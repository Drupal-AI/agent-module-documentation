# Drush commands — `features:*`

Defined in `src/Drush/Commands/FeaturesCommands.php` (registered via `drush.services.yml`,
service `features.commands`). Every command takes `--bundle=<machine_name>` to act within a
specific `features_bundle` namespace (default bundle if omitted).

| Command | Aliases | Purpose |
|---|---|---|
| `features:export [packages…]` | `fex`, `fu`, `fua`, `features-export` | Export the named packages (or all, after confirm) to feature modules on disk. `--add-profile` packages them into an install profile (requires a bundle set via `--bundle`). Uses the `write` generation method. |
| `features:import <feature[:component,…]>` | `fim`, `fr`, `features-import` | Import/revert a feature's config back onto the site (only overridden/missing components, or all with `--force`). Accepts `feature:config.name` pairs, comma-separated. |
| `features:import:all` | `fra`, `fia`, `fim-all` | Revert every installed feature that is currently overridden or missing config. |
| `features:diff <feature>` | `fd`, `features-diff` | Show the diff between active config and the feature's stored config. `--ctypes=` limits component types, `--lines=n` sets context lines. Red = code will overwrite active on import; green = active differs and export would update code. |
| `features:status [keys]` | `fs`, `features-status` | Show current bundle, export folder, and enabled assignment methods. |
| `features:list:packages [package]` | `fl`, `features-list-packages` | List all generate-able packages with status/version/state (Overridden, etc.), or list the config objects assigned to one package. |
| `features:components [patterns…]` | `fc`, `features-components` | List config components by source type. `--exported` / `--not-exported` filter by export state. Patterns support `*`/`%` wildcards. |
| `features:add <components…>` | `fa`, `fe`, `features-add` | Add specific config items to a (possibly new) feature package, then write it. |

## Typical cycle

```bash
drush features:status                 # what's enabled / active bundle
drush features:list:packages          # which packages exist and if overridden
drush features:diff my_feature        # what changed vs. code
drush features:export my_feature      # write active config into the module
# ... deploy code to another site ...
drush features:import my_feature      # apply the module's config onto that site
drush features:import:all             # revert every overridden feature at once
```

`features:import` throws if the target is not an installed feature module; `features:export`
prompts before overwriting an existing module directory.
