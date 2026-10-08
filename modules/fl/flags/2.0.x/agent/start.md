# Flags — agent index

Renders country/language flag icons via a CSS sprite, with a code→flag mapping API and override
config entities. Base module has no UI and no field integration — those live in four submodules.
No `configure` route on the base module, no Drush. Provides the `administer flag mapping` permission
and config schema for the two mapping entities.

- **The `flags` theme hook, the mapping services/API, `FlagsManager`, mapping config entities, `hook_flags_alter`** → [api/mapping.md](api/mapping.md)

Submodules (own docs):
- `flags_country` → [../../modules/flags_country/2.0.x/agent/start.md](../../modules/flags_country/2.0.x/agent/start.md)
- `flags_language` → [../../modules/flags_language/2.0.x/agent/start.md](../../modules/flags_language/2.0.x/agent/start.md)
- `flags_languagefield` → [../../modules/flags_languagefield/2.0.x/agent/start.md](../../modules/flags_languagefield/2.0.x/agent/start.md)
- `flags_ui` → [../../modules/flags_ui/2.0.x/agent/start.md](../../modules/flags_ui/2.0.x/agent/start.md)

Key facts:
- Theme hook `flags` (`flags.module`): vars `code`, `source` (`country`|`language`), `tag`,
  `attributes`. `template_preprocess_flags()` resolves `flags.mapping.{source}` dynamically and
  throws `InvalidArgumentException` for an unknown source. Output classes `flag flag-<mapped>`.
- Services: `flags.mapping.country`, `flags.mapping.language` (both `BaseMapping`), `flags.manager`
  (`FlagsManager`, 250+ codes), `flags.language_helper` (`FullLanguageManager`).
- Mapping override config entities `country_flag_mapping` / `language_flag_mapping`
  (`source` → `flag`); `BaseMapping::map()` returns the override flag or the lowercased input code.
- CSS library `flags/flags` (`css/flag-icons.css` sprite).
