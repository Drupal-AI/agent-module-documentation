# How validation works

## Constraint attachment

`node_title_validation.module` defines `_node_title_validation_add_constraint(&$fields, $entity_type)`
which, for the `node` entity type, calls `$fields['title']->addConstraint('NodeTitleValidate', [])`.
It is invoked from two hooks (implemented as `#[Hook]` methods on
`Drupal\node_title_validation\Hook\NodeTitleValidationHooks`, with `#[LegacyHook]` procedural
wrappers):

- `hook_entity_base_field_info_alter()`
- `hook_entity_bundle_field_info_alter()`

So the constraint lives on the node title field definition and runs whenever entity validation runs
(node form submit, `$node->validate()`, JSON:API/REST writes, migrations that validate).

## The constraint + validator

- `Plugin/Validation/Constraint/NodeTitleConstraint.php` — an empty Symfony constraint with
  attribute `#[Constraint(id: 'NodeTitleValidate', ...)]`.
- `Plugin/Validation/Constraint/NodeTitleConstraintValidator.php` — the logic. `validate()`:
  1. Skips empty titles and non-node entities.
  2. Loads `node_title_validation.settings` → `node_title_validation_config`; returns if empty.
  3. Resolves the node's `type` and reads `content_types[<type>]`.
  4. Applies each rule, calling `$this->context->addViolation()` per failure (multiple violations
     can be added for one title).

### Blocklist matching detail

`exclude` is split on commas (and `\r\n` normalized to commas). Matching (`_node_title_validation_search_excludes_in_title()`):
- entries of length 1 (single characters) → matched with `str_contains()` anywhere in the title;
- entries longer than 1 char (words) → matched only as whole space-separated words.

The `comma` flag appends `,` to the exclude list. There are effectively two overlapping blocklist
passes in the validator (one via the helper, one inline), so a matched word may be reported by
either message.

### Uniqueness detail

For the per-type `unique` flag it runs
`\Drupal::entityTypeManager()->getStorage('node')->loadByProperties(['title' => $title, 'type' => $type])`.
If a match exists that is not the current node being edited, it adds a violation linking to the
existing node. The check is **always scoped to the node's own type**; the global `unique` config
key is not consulted here.

## Implementing / extending

There is no plugin type to implement. To add your own title rules you would write a separate
constraint/validator and attach it to the title field via your own
`hook_entity_base_field_info_alter()`. To bypass this module's rules for a specific type, leave that
type's `content_types` entry unset (or all rule values empty/zero).
