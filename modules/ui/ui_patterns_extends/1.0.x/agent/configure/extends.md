# Authoring `extends` in a pattern definition

The module only reacts to an `extends` key inside a pattern's definition (its `additional` data,
i.e. what you write in `*.ui_patterns.yml`). No admin UI — this is YAML you author.

## Syntax

```yaml
foo_base:
  label: Foo Base
  fields:
    title: { type: text, label: Title }
  settings:
    modifier: { type: textfield, label: Modifier }
  variants:
    blue: { label: Blue }

# Inherit fields + settings + variants from foo_base:
foo_complete:
  label: Foo Complete
  extends:
    - foo_base

# Inherit only settings:
foo_settings:
  extends:
    - foo_base.settings

# Inherit only fields:
foo_fields:
  extends:
    - foo_base.fields

# Inherit a single named setting:
foo_one_setting:
  extends:
    - foo_base.settings.modifier
```

## Reference forms

| `extends` entry | Copies from parent |
|---|---|
| `parent` | `fields`, `settings`, **and** `variants` |
| `parent.fields` | all fields |
| `parent.settings` | all settings |
| `parent.fields.<name>` | just that field |
| `parent.settings.<name>` | just that setting |

List several entries to extend from multiple parents.

## Merge rules (from `UIPatternsExtends::extends()`)

- **Child wins.** A field is copied only if the child doesn't already define it
  (`hasField($name) === FALSE`); a setting only if `additional['settings'][$name]` is unset.
- Parents are resolved by `yaml:<pattern>` key. If a referenced parent is missing, an exception
  is thrown (`Parent pattern lookup <pattern> failed.`).
- **Recursive.** If the parent itself has `extends`, it is flattened first, so grandparent parts
  flow through.
- **Recursion guard.** A `previousPatternNames` list detects cycles and throws
  `Pattern recursion found. …`.
- After processing, the `extends` key is unset on the child (`setAdditional()`).

Implemented as `hook_ui_patterns_info_alter()` — it runs when pattern definitions are built/altered,
not at request time for a rendered pattern. Clear caches after editing definitions.
