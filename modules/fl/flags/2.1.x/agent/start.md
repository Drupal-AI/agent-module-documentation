# Flags — agent index

Renders country/language flag icons via a CSS sprite, with a code→flag mapping API and override
config entities. Base module has no UI and no field integration — those live in four submodules.
No `configure` route on the base module, no Drush. Provides the `administer flag mapping` permission
and config schema for the two mapping entities.

2.1.x is a compatibility release: `core_version_requirement` is now `^11.3 || ^12` (Drupal 11.3+ /
12; 2.0.x still allowed 9/10) and the `.info.yml` `package` is `Field types`. Mechanism is unchanged
from 2.0.x. Hook implementations live in OOP hook classes (`#[Hook]` attributes) with a `#[LegacyHook]`
shim for `flags_theme`; `flags_language` switcher/block hooks live in `FlagsLanguageHooks`.

- **The `flags` theme hook, the mapping services/API, `FlagsManager`, mapping config entities, `hook_flags_alter`** → [api/mapping.md](api/mapping.md)

Submodules (own docs):
- `flags_country` → [../../modules/flags_country/2.1.x/agent/start.md](../../modules/flags_country/2.1.x/agent/start.md)
- `flags_language` → [../../modules/flags_language/2.1.x/agent/start.md](../../modules/flags_language/2.1.x/agent/start.md)
- `flags_languagefield` → [../../modules/flags_languagefield/2.1.x/agent/start.md](../../modules/flags_languagefield/2.1.x/agent/start.md)
- `flags_ui` → [../../modules/flags_ui/2.1.x/agent/start.md](../../modules/flags_ui/2.1.x/agent/start.md)

Key facts:
- Theme hook `flags` (`FlagsHooks::theme`, exposed via `flags_theme`): vars `code`, `source`
  (`country`|`language`), `tag` (default `span`), `attributes`. `flags_preprocess_flags()` resolves
  `flags.mapping.{source}` dynamically and throws `InvalidArgumentException` for an unknown source.
  Output classes `flag flag-<mapped>` on an empty `<tag>`; template attaches `flags/flags`.
- Services: `flags.mapping.country`, `flags.mapping.language` (both `BaseMapping`), `flags.manager`
  (`FlagsManager`, 250+ codes), `flags.language_helper` (`FullLanguageManager`).
- Mapping override config entities `country_flag_mapping` / `language_flag_mapping`
  (`source` → `flag`); `BaseMapping::map()` returns the override flag (lowercased) or the
  lowercased/trimmed input code.
- CSS library `flags/flags` (`css/flag-icons.css` sprite, `flag-icons.png`).
