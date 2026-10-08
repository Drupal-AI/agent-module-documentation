Synonyms Views Argument Validator adds a Views contextual-filter (argument) validator that accepts an entity's name or any of its synonyms and resolves it to the entity ID.

---

The submodule ships a Views argument-validator plugin `synonyms_entity` (a deriver produces one per
eligible entity type, subclassing core's `Entity` validator). In `validateArgument()` it first tries an
exact match on the entity's label column (access-checked entity query; `user` special-cased to `name`),
optionally restricted to selected bundles; failing that, it looks the argument up as a **synonym** via
`synonyms.provider_service->findSynonyms()`. On a match it rewrites `$this->argument->argument` to the
found entity ID so the rest of the View filters by ID as usual. An option **"Transform dashes in URL to
spaces"** (`transform`, default FALSE) converts dashes to spaces before matching, which is handy for
clean URLs. It inherits the core Entity validator's bundle/access options. Depends on `synonyms` + core
`views`. No config UI or permissions of its own — you select it on a View's contextual filter.

---

- Let a taxonomy/term contextual filter accept a synonym in the URL, not just the term name.
- Resolve `/glossary/United-States` to the term whose synonym is "United States".
- Accept an entity's alias in a path argument and map it to its ID.
- Transform dashed URL segments to spaces before matching (clean URLs).
- Restrict validation to specific bundles of the target entity type.
- Keep core access checks on the resolved entity (`accessCheck(TRUE)`).
- Fall back to synonym lookup only when the exact name doesn't match.
- Support user-name-or-synonym contextual filters.
- Build alias-friendly landing pages driven by Views arguments.
- Reuse existing Synonyms provider config for argument validation.
- Avoid custom code to accept alternate names in Views paths.
- Combine with the synonyms Views filter for full alias-aware Views.
- Validate arguments for any entity type that declares a label.
- Provide friendlier, memorable URLs backed by synonyms.
- Redirect/validate contextual filters without exposing raw entity IDs.
