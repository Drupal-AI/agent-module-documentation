# libraries — agent start

Generic handling of external (JS/CSS/PHP) libraries for Drupal. Libraries are typed classed
objects discovered from JSON/YAML definitions and loaded via the `libraries.manager` service.
No admin UI/configure route; behavior is set in config + code. Modules request a library with a
`library_dependencies:` key in their `.info.yml`.

- Use/load libraries programmatically (`libraries.manager` + discovery services) → [api/library-manager.md](api/library-manager.md)
- Add a library type / locator / version-detector plugin → [plugins/plugin-types.md](plugins/plugin-types.md)
- Alter registered types/locators/detectors; legacy `hook_libraries_info` → [hooks/hooks.md](hooks/hooks.md)
- Definition discovery config (remote registry URLs, local path, global locators) → [configure/definitions.md](configure/definitions.md)
- Legacy Drush command → [drush/commands.md](drush/commands.md)
