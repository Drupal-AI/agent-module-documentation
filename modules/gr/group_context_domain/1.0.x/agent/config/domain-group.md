<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assigning a group to a domain (permission, form, storage, validation)

There is **no settings form and no config object of its own**. A domain's group is stored as a
**third-party setting on the `domain` record** and edited inline on the domain edit form. All logic
lives in `group_context_domain.module`, the permission file, one validation constraint, and the
config schema.

## Install / enable

`ddev drush en group_context_domain -y`. Requires **group** and **domain** already present
(hard dependencies in `group_context_domain.info.yml`). Grant the permission below to the roles
that should be allowed to map domains to groups.

## Permission

`group_context_domain.permissions.yml` defines a single permission:

- **`set domain group`** — *"Allows you to assign a group entity to a domain entity. Requires that
  you have access to edit both the domain record and the group entity."* Not flagged
  `restrict access`, but effective use also requires domain-edit access (to reach the form) and
  group **update** access (to appear as an option). This is the only permission the module ships.

## The domain form (where the group is chosen)

`group_context_domain_form_domain_form_alter()` (hook_form_FORM_ID_alter for `domain_form`):

1. Adds cache context `user.permissions` to the form.
2. Returns early unless the current user has `set domain group` — no field is added otherwise.
3. Loads the `group` storage and runs
   `getQuery()->addMetaData('op', 'update')->accessCheck()->execute()`, then `loadMultiple()`, so
   **options are only groups the user may update**. Options are keyed by group **UUID**
   (`$group->uuid()` => `$group->label()`).
4. Adds `$form['group_uuid']` — a `select` titled *Group* with an empty option, default value
   `$domain->getThirdPartySetting('group_context_domain', 'group_uuid')`.
5. Registers entity builder `_group_context_domain_save_group_uuid` and validate handler
   `_group_context_domain_validate_group_uuid`.

**Save** (`_group_context_domain_save_group_uuid`): if a `group_uuid` value is present it does
`$entity->setThirdPartySetting('group_context_domain', 'group_uuid', $group_uuid)`; if empty it
`unsetThirdPartySetting(...)`. So selecting the empty option clears the mapping.

**Validate** (`_group_context_domain_validate_group_uuid`): runs
`$domain->getTypedData()->validate()` and, for any `DomainGroupUnique` violation, calls
`setErrorByName('group_uuid', ...)` so the uniqueness error attaches to the select.

## Storage & config schema

The value is a third-party setting on the domain config entity — no dedicated config object.
Schema in `config/schema/group_context_domain.schema.yml`:

```
domain.record.*.third_party.group_context_domain:
  type: mapping
  label: 'Group Context: Domain settings'
  mapping:
    group_uuid:
      type: uuid
      label: 'Group UUID'
```

Because it's a UUID (not a numeric group ID), the mapping survives config export/import across
environments where numeric IDs differ.

## Uniqueness constraint

`group_context_domain_entity_type_alter()` adds constraint `DomainGroupUnique` to the `domain`
entity type. Constraint plugin `src/Plugin/Validation/Constraint/DomainGroupUnique.php`
(`@Constraint(id="DomainGroupUnique", type="entity:domain")`), message *"The %group_label group is
already tied to another domain."*

Validator `src/Plugin/Validation/Constraint/DomainGroupUniqueValidator.php`
(`validate($domain, $constraint)`):

- Returns early if `$domain` is unset or has an **empty** `group_uuid`.
- Counts other domains with the same `group_context_domain.group_uuid`:
  `domain` storage `getQuery()->accessCheck(FALSE)->condition('third_party_settings.group_context_domain.group_uuid', $group_uuid, '=')->count()`,
  excluding the current domain when it isn't new (`condition('id', $domain->id(), '<>')`).
- If the count is `> 0`, loads the group by UUID and adds a violation at path
  `third_party_settings.group_context_domain.group_uuid` with `%group_label` set to the group's
  label.

This is what enforces the README's "one group per domain / one domain per group" limitation. The
`accessCheck(FALSE)` is scoped to a uniqueness **count** across domain records (the acting user is
already an editor of the domain form with `set domain group`); it is not an access-bypass on any
content route.

## Operate it

1. Enable the module; grant `set domain group` to the relevant role.
2. Edit a domain record (Domain module UI), choose a group in the **Group** select, save.
3. The domain now resolves to that group via the context and cache context
   ([api/context-provider.md](../api/context-provider.md)); the mapping is enforced unique.
4. To unassign, edit the domain and pick the empty option.
