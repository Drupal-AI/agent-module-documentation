UI Patterns Extends adds an `extends:` key to UI Patterns pattern definitions so one pattern can inherit the fields, settings and variants of another, avoiding copy-paste across similar components.

---

The module implements `hook_ui_patterns_info_alter()`: for every pattern definition that carries an `extends` entry in its `additional` data, it runs `\Drupal\ui_patterns_extends\UIPatternsExtends`, which merges in the parent pattern's parts. `extends` is a list of references of the form `parent`, `parent.fields`, `parent.settings`, or `parent.fields.<name>` / `parent.settings.<name>`; a bare `parent` pulls in `fields`, `settings` and `variants`. Only parts the child does not already define are copied (child definitions win), fields via `getFields()`/`setFields()` and settings via the `additional['settings']` array. Parents are looked up by `yaml:<pattern>` in the definition list, resolved recursively so a parent that itself `extends` another is flattened first, and a `previousPatternNames` guard throws on circular `extends` chains. After merging, the `extends` key is stripped from the child's `additional`. There is no admin UI, config, permission, service or plugin type — it is a build-time definition alter. It depends on `ui_patterns` and on `token` (the sibling settings types this ecosystem uses accept tokens). Author `extends` directly in your pattern's `*.ui_patterns.yml` (or `settings.ui_patterns.yml`) file.

---

- Share a common set of fields across several card/teaser patterns by extending one base pattern.
- Inherit a base pattern's settings (modifier, attributes, url, etc.) into a derived pattern.
- Pull in only a parent's `fields` with `extends: [parent.fields]`.
- Pull in only a parent's `settings` with `extends: [parent.settings]`.
- Inherit a single named field from a parent with `extends: [parent.fields.image]`.
- Inherit a single named setting from a parent with `extends: [parent.settings.modifier]`.
- Build a base "layout" pattern and derive multiple concrete components from it.
- Override just one field/setting in the child while inheriting the rest from the parent.
- Compose a deep hierarchy where a child extends a pattern that itself extends a base.
- Keep component definitions DRY so a change to the base propagates to all children.
- Extend from multiple parents by listing several references in `extends`.
- Guarantee circular inheritance is caught at build time (exception on recursion).
- Add variants to derived patterns while inheriting base fields.
- Migrate a set of near-duplicate patterns to a base + extenders structure.
- Reuse a design-system "primitive" pattern's fields in many higher-level patterns.
- Standardize settings across a component family without repeating YAML.
- Let a child pattern selectively add fields the base does not have while keeping inherited ones.
- Maintain a single source of truth for shared preview/field definitions.
