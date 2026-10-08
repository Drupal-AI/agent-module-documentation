Language Neutral URL Aliases decouples Drupal's URL aliases from the language system, forcing every path alias to be saved as language-neutral (`langcode` = `und` / `LANGCODE_NOT_SPECIFIED`) so the same alias works regardless of the active or content language.

---

Drupal core stores each URL alias against a language and resolves aliases per the current language, which surprises site owners who expect aliases to be global. This module removes that coupling in three coordinated pieces. (1) A **service decorator** (`language_neutral_aliases.repository_decorator`, decorating `path_alias.repository` at priority 9) overrides the repository lookups — `preloadPathAlias()`, `lookupBySystemPath()`, `lookupByAlias()`, `pathHasMatchingAlias()` — to always query with `LANGCODE_NOT_SPECIFIED` instead of the request language. (2) `hook_entity_type_alter()` swaps the `path_alias` entity's **storage class** to `NeutralPathAliasStorage`, whose `create()`/`save()` force the alias entity's `langcode` to `und`, and swaps the **list builder** to `NeutralPathAliasListBuilder`, which only lists neutral aliases. (3) `hook_module_implements_alter()` makes this module's `entity_type_alter` run last (so it wins over `path`) and unsets `path`'s `entity_translation_create` hook, preventing core from creating a separate alias per translation. The net effect: new aliases are always neutral, and any pre-existing non-neutral aliases become effectively hidden (they won't resolve, won't appear on node edit, and won't show in the alias admin list) until the module is uninstalled — the README recommends cleaning out or bulk-updating legacy aliases (`UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';`) for permanent use. There is no admin UI, no `configure` route, no permissions, no config, and no Drush; the "URL alias" field on translatable content must not be translated. It depends only on `path_alias`.

---

- Make URL aliases global so `/about` works the same in every site language.
- Stop Drupal from resolving a different alias per interface/content language.
- Give a multilingual site the intuitive "one alias per page" behaviour site owners expect.
- Avoid duplicate or conflicting aliases created per translation.
- Ensure a translated node keeps a single shared alias across all its translations.
- Prevent core from auto-generating a separate alias when a translation is created.
- Save every new path alias as language-neutral (`langcode = und`) automatically.
- Hide legacy language-specific aliases without deleting them (reversible by uninstalling).
- Convert an existing site to global aliases by bulk-updating `path_alias.langcode` to `und`.
- Keep the URL aliases admin list showing only the neutral aliases that actually apply.
- Simplify Pathauto-generated aliases so patterns don't need language tokens.
- Reduce editor confusion where the same page had different aliases per language.
- Serve the same clean URL to visitors regardless of their chosen language.
- Make alias lookups language-independent for menu links and internal links.
- Support a language-negotiation setup (e.g. domain/prefix) while keeping aliases shared.
- Migrate from per-language aliases to shared aliases as a policy change.
- Restore original per-language behaviour simply by uninstalling the module.
- Avoid writing custom code to normalise alias languages.
- Keep alias resolution consistent when content language differs from interface language.
- Ensure `pathHasMatchingAlias()` checks only neutral aliases (e.g. for routing).
- Prevent accidental translation of the "URL alias" field from splitting aliases.
- Standardise alias behaviour across a large multilingual editorial team.
