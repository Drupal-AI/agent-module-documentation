# UI Patterns Extends — agent index

Adds an `extends:` key to UI Patterns definitions so one pattern **inherits** another's fields,
settings and variants. Pure build-time definition alter (`hook_ui_patterns_info_alter`); no UI,
config, permission, service or plugin. Depends on `ui_patterns` and `token`.

- **`extends` syntax, what merges, recursion & override rules** → [configure/extends.md](configure/extends.md)

Key facts:
- Trigger: an `extends` entry in a pattern's `additional` data (i.e. in its `*.ui_patterns.yml`).
- Class `\Drupal\ui_patterns_extends\UIPatternsExtends`; child definitions always win over parent.
- Reference forms: `parent` (fields+settings+variants), `parent.fields`, `parent.settings`,
  `parent.fields.<name>`, `parent.settings.<name>`.
- Circular `extends` chains throw an exception; `extends` is removed from the child after merge.
