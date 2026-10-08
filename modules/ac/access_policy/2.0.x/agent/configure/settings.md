# Configure Access Policy

The base `access_policy` module has **no settings form** (`configure: null`). All configuration is
done through **config entities** (`access_policy`) plus one settings **config object**
(`access_policy.settings`). The admin forms are provided by the **`access_policy_ui`** submodule
(enable it: `drush en access_policy_ui`); its collection route is
`entity.access_policy.collection` at `/admin/people/access-policies`.

## The `access_policy` config entity

One entity per policy (`config_prefix: access_policy`, id `access_policy.access_policy.<id>`).
Exported keys (schema in `config/schema/access_policy.schema.yml`, entity class
`Drupal\access_policy\Entity\AccessPolicy`):

| Key | Meaning |
|-----|---------|
| `id`, `label`, `description`, `weight` | Identity + ordering |
| `target_entity_type_id` | Entity type this policy controls (e.g. `node`, `media`) |
| `access_rules` | Ordered list of access-rule plugin configs (the rules that grant/deny at access-check time) |
| `access_rule_operator` | `AND` / `OR` — how the access rules combine |
| `selection_rules` | Selection-rule plugin configs (decide which entities the policy auto-applies to under the `dynamic` strategy) |
| `selection_rule_operator` | `AND` / `OR` for selection rules |
| `selection_set` | Names of the selection sets this policy belongs to |
| `operations` | Per-operation map `{op: {permission: bool, access_rules: bool, show_column: bool}}` — which of `view`, `view_unpublished`, `view_all_revisions`, `update`, `delete`, `manage_access` gate on a permission and/or on access rules |
| `http_403_response` | `{plugin_id, settings}` — the access-denied behaviour (default plugin `message`) |
| `type`, `query` | Policy type marker; whether the policy participates in DB query alters (listing/JSON:API filtering) |

Each entry in `access_rules` / `selection_rules` is a mapping:
`{id, group, plugin_id, field, entity_type, operator, settings, required}`.

## The `access_policy.settings` config object

Per-entity-type behaviour (schema `access_policy.settings`, service
`access_policy.entity_type_settings` → `EntityTypeSettings::load($entity_type_id)`):

```yaml
entity_type_settings:
  default:
    selection_strategy: dynamic          # 'dynamic' (ABAC auto-assign) or 'manual' (Access tab)
    selection_strategy_settings: {}      # strategy options (dynamic_assignment, allow_empty,
                                         #   enable_selection_page, show_operations_link,
                                         #   enable_policy_field, ...)
    selection_sets: {}                   # named groups: {id: {id, label}}
```

`default` is a fallback; add a key per entity type id (e.g. `node:`) to override.

## Selection strategy

- **`dynamic`** — traditional ABAC: policies are auto-assigned to an entity based on their
  `selection_rules` when the entity is saved. `dynamic_assignment` = `on_create` | `on_save` |
  `on_change` controls when re-evaluation runs (`AccessPolicySelection::assignPolicyOnUpdate`,
  `shouldUpdateAccessPolicy`). Some entity types (e.g. paragraphs) support only this mode.
- **`manual`** — authors pick the policy from an **Access** tab
  (`/{entity}/{id}/access`, route `entity.<type>.access_policy_form`).

## Set config via Drush / PHP

```bash
# Enable the UI, then create policies through /admin/people/access-policies.
drush en access_policy access_policy_ui -y

# Switch the node selection strategy to manual (document-style Access tab):
drush cset access_policy.settings entity_type_settings.node.selection_strategy manual -y
```

```php
// Create a policy that restricts node view to matching department (illustrative).
$policy = \Drupal\access_policy\Entity\AccessPolicy::create([
  'id' => 'department',
  'label' => 'Department match',
  'target_entity_type_id' => 'node',
  'access_rule_operator' => 'AND',
]);
// Access rules are added via the access_rule handler manager (getHandler + addHandler),
// see plugins/plugins.md; the raw config shape is shown in the table above.
$policy->save();
```

When a policy is saved for a new target entity type, the module installs the `access_policy` base
field on that type, rebuilds routes, and clears field/views caches
(`access_policy_access_policy_insert()` / `_update()`).

## Runtime, in brief

- `hook_entity_access` → `AccessPolicyEntityAccessControlHandler::access()` →
  `AccessPolicyValidator::validate()`. Policies assigned to the entity are OR'd: access is granted
  if **any** assigned policy passes. A policy passes when the account holds the operation's
  per-policy permission (when `operations.<op>.permission`) **and** the access rules evaluate true
  (when `operations.<op>.access_rules`), unless the account has `bypass <id> access rules`.
- No assigned policy, or entity type not access-controlled → the module stays out of the way
  (`AccessResult::neutral()`), deferring to core/other modules.
- Listings, entity-reference selects and Views are filtered by `AccessPolicyQueryAlter` via
  `hook_query_alter` / `hook_views_query_alter` on the `<entity_type>_access` query tag.
