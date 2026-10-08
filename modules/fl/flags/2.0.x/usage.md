Renders flag icons for countries and languages via a CSS-sprite library, with a small mapping API (code → flag) and config entities to override which flag a code maps to. Submodules add field formatters/widgets and language-switcher flags.

---

The base Flags module provides a `flags` theme hook (`templates/flags.html.twig`) that turns a country or language code into an `<span class="flag flag-xx">` styled by the bundled `css/flag-icons.css` sprite. Rendering resolves a source-specific mapping service dynamically: `template_preprocess_flags()` calls `flags.mapping.{source}` (`flags.mapping.country` or `flags.mapping.language`), each an instance of `BaseMapping` that looks up override config entities and otherwise falls back to the code itself. Overrides are stored as `country_flag_mapping` / `language_flag_mapping` config entities (`source` code → `flag` code), letting you point, say, a language code at a specific territory's flag. `FlagsManager` supplies a translatable list of 250+ flag codes/names and an alter hook (`hook_flags_alter`) for the option lists; `FullLanguageManager` merges predefined and site-configured languages. The base module ships no UI and no field integration by itself — those come from four submodules: **flags_country** (formatter + select/autocomplete widgets for `country` fields), **flags_language** (formatter + widget for the core `language` field, plus flags on the language-switcher block/links), **flags_languagefield** (formatter + widget for the Language Field module), and **flags_ui** (admin CRUD for the mapping entities, `administer flag mapping` permission). Widgets that show flags in select options require the Select Icons module.

---

- Show a country's flag next to a country field value.
- Show a language's flag next to a language field value.
- Add flag icons to the core language switcher block and its links.
- Render a flag from a code anywhere in a template via the `flags` theme hook.
- Map a country/language code to a *different* territory's flag (e.g. `en` → GB or US).
- Provide flag-decorated select options for country/language fields (with Select Icons).
- Offer an autocomplete country widget that previews flags (flags_country).
- Serve flags as CSS sprites (no per-flag image requests) via `flag-icons.css`.
- Build a language menu with flags for a multilingual site.
- Override the default code→flag mapping through the Flags UI without code.
- Manage mapping overrides as exportable configuration across environments.
- Reuse the mapping API (`flags.mapping.country`/`language`) in custom render arrays.
- Get a canonical list of 250+ flag codes/names via `FlagsManager::getList()`.
- Alter the available flag list with `hook_flags_alter`.
- Attach the flags CSS library to arbitrary render output (`#attached['library'][] = 'flags/flags'`).
- Integrate flags with the contrib Language Field module (flags_languagefield).
- Display "flag before / after / instead of" the label via formatter output-format settings.
- Restrict who can edit flag mappings with the `administer flag mapping` permission.
- Seed language-to-flag defaults for locales whose code differs from the flag/territory code.
- Add flag styling to custom widgets by reusing `getOptionAttributes()` CSS classes.
