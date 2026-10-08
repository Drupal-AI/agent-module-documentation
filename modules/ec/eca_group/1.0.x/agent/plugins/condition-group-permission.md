<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition: Group — current user has permission

- **Plugin ID:** `eca_group_current_user_has_group_permission`
- **Label:** "Group: current user has permission"
- **Class:** `Drupal\eca_group\Plugin\ECA\Condition\CurrentUserHasGroupPermission`
- **File:** `src/Plugin/ECA/Condition/CurrentUserHasGroupPermission.php`
- **Extends:** `Drupal\eca\Plugin\ECA\Condition\ConditionBase`
- **Attribute:** `#[EcaCondition(... description: 'Verifies if the current user has the given permission in a given group.', version_introduced: '1.0.0')]`

## What it does

Evaluates whether the ECA model's **current user** holds a chosen group
permission within a **given group**. Read-only: it computes a boolean, it does not
grant, revoke or change any membership, role or access.

## Context and configuration

- **Context definition:** `entity` → `EntityContextDefinition(data_type: 'entity:group', label: 'Group')`. The group to test is supplied from an ECA token/context.
- **Config key:** `permission` (string), default `''` (`defaultConfiguration()`).
- **Config schema:** `eca.condition.plugin.eca_group_current_user_has_group_permission` in `config/schema/eca_group.schema.yml` — extends `eca.condition.plugin` and adds the `permission` string mapping.

## `evaluate()` logic (source)

1. Starts from `AccessResult::forbidden()` (default = condition false).
2. Reads the group from context: `$group = $this->getValueFromContext('entity')`. If the value is scalar (an id), it loads it with `Group::load($group)`.
3. If `$group instanceof GroupInterface`, sets `$result = $group->hasPermission($this->configuration['permission'], $this->currentUser)` — delegates to Group's own permission logic for the current user.
4. Returns `$this->negationCheck($result)`, so ECA's standard "negate" toggle can invert the outcome. If no valid group resolves, the result stays forbidden (false).

## Configuration form

`buildConfigurationForm()` builds a required `select` named `permission`. It lists
every group permission by calling `group.permissions` service
(`GroupPermissionHandlerInterface::getPermissions(TRUE)`) and groups the options by
"<provider display name> : <section>", using `extension.list.module`
(`ModuleExtensionList::getName()`) for the provider label and `strip_tags()` on
each permission title. `submitConfigurationForm()` stores the selected value into
`$this->configuration['permission']`.

## Services used

Injected in `create()` from the container:

- `group.permissions` → `Drupal\group\Access\GroupPermissionHandlerInterface` (property `$permissionHandler`).
- `extension.list.module` → `Drupal\Core\Extension\ModuleExtensionList` (property `$moduleHandler`).

The module itself declares no `*.services.yml`; both are core/Group services.
