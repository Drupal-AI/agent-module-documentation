<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unique Alias Checker (unique_alias_checker) — agent index

**Adds an entity-form validator that blocks node/taxonomy-term saves which would make Pathauto generate a duplicate URL alias.**

- **Version:** 1.5.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** `pathauto` (uses its alias cleaner, storage helper, uniquifier)
- **Configure route:** `unique_alias_checker.settings` → `/admin/config/unique_alias_checker/unique_alias_checker_settings` (permission: `Administer pathauto`)
- **Settings keys:** `error_msg` (custom validation message), `exclude_bundles` (entity-type → bundle → excluded map)
- **How it hooks in:** `hook_form_node_form_alter` / `hook_form_taxonomy_term_form_alter` add `unique_alias_checker_validate()` to `#validate` for `default`/`edit`/`quick_node_clone` operations
- **Logic:** validator runs only when `path[0][pathauto]` is checked; `unique_alias_checker` service `checkAlias($entity)` decides if the prospective alias already exists, then `setErrorByName('path', …)`
- **Service:** `unique_alias_checker` (`UniqueAliasChecker`)

**Security:** Only route is the admin settings form, gated by `Administer pathauto`. No anonymous, mutating, or external endpoints; no external HTTP calls. Purely an entity-form validation add-on.
