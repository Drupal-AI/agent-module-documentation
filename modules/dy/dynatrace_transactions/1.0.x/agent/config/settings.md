<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings: limiting which roles are used

Source: `src/Form/DynatraceTransactionsConfig.php` (extends `ConfigFormBase`),
`config/install/dynatrace_transactions.config.yml`, `config/schema/dynatrace_transactions.schema.yml`.

## Install / enable

Standard contrib install (no dependencies): `drush en dynatrace_transactions`. Then configure at
`/admin/config/development/dynatrace-transactions`.

## Route & access

- Route id `dynatrace_transactions.config` → `/admin/config/development/dynatrace-transactions`,
  form `Drupal\dynatrace_transactions\Form\DynatraceTransactionsConfig`, `getFormId()` =
  `dynatrace_transactions_config`.
- Requirement: **`_permission: 'administer site configuration'`** (core admin permission).
- Menu link under *Configuration → Development* (`dynatrace_transactions.links.menu.yml`, weight 10).

## The form

- One field: **`transaction_roles`** — a `checkboxes` element titled *"Limit Roles"*. Options are all
  `user_role` entities (label as text), loaded via `entity_type.manager`.
- Description: *"Leave blank for all roles. Transactions will be tagged with the user's highest weight
  role (lowest in this list)."* Reorder roles at `/admin/people/roles`.
- The form also builds an unused `$data_options` (`id` / `roles`) array that is not rendered — dead
  code, no effect.

## Config object `dynatrace_transactions.config`

- Single key `transaction_roles`: a map of role-machine-name → value (`checkboxes` stores checked
  roles as their own id, unchecked as `0`/`"0"`).
- Install default (all disabled):

```yaml
transaction_roles:
  anonymous: "0"
  authenticated: "0"
  administrator: "0"
```

- Schema type is `config_object` with `transaction_roles` a `sequence` of `string`.

## Behavior of the setting

- The event subscriber does `array_filter($config->get('transaction_roles'))` to keep only enabled
  (truthy) roles. **If the result is empty (nothing checked), ALL system roles are considered** — so
  the default install and an all-unchecked form both mean "every role is eligible for the suffix".
- Checking specific roles narrows the suffix to just those; a visitor whose roles don't intersect the
  enabled set is tagged `(other)`. Only the single highest-weight matching role is appended.

## Save behavior

`submitForm()` iterates every submitted value, skips form-internal keys (`_core`, `submit`,
`form_build_id`, `form_token`, `form_id`, `op`), and writes each remaining value to the editable
config with `$config->set($key, $value)->save()`, then calls `parent::submitForm()`. In practice the
only real field is `transaction_roles`.
