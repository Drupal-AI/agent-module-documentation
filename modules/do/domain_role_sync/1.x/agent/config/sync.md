<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role-to-domain mapping and the sync hook

## Install & enable

```bash
composer require drupal/domain_role_sync   # 1.x dev branch; no stable release
drush en domain_role_sync -y               # also enables domain
```

Only dependency is the **`domain`** module. No permissions of its own, no Drush, no settings route.
The user side of the sync relies on Domain Access's user field **`field_domain_access`** (provided by
Domain Access), so a working Domain Access setup with that field on the user entity is assumed.

## Where the mapping lives

There is **no dedicated admin page**. The mapping is edited from the standard **Domain edit form**
(`/admin/config/domain/…/edit`), gated by Domain's own access control for editing domains.

`DomainRoleSyncHooks::formDomainEditFormAlter()` (attribute `#[Hook('form_domain_edit_form_alter')]`,
delegated from `domain_role_sync_form_domain_edit_form_alter` in the `.module`) adds:

```
$form['domain_role_sync'] = ['#type' => 'details', '#open' => FALSE,
  '#title' => 'Domain role synchronization'];
$form['domain_role_sync']['roles'] = ['#type' => 'checkboxes',
  '#title' => 'Roles to automatically assign to users affiliated with this domain',
  '#options' => <all user roles except authenticated/anonymous>,
  '#default_value' => $domain->getThirdPartySetting('domain_role_sync', 'roles') ?: []];
```

Role options come from `EntityTypeManager->getStorage('user_role')->loadMultiple()`, with the
`authenticated` and `anonymous` roles filtered out.

The submit handler `domain_role_sync_domain_entity_form_submit()` (in the `.module`, `array_unshift`-ed
onto `$form['actions']['submit']['#submit']`) stores the choice on the Domain config entity:

- non-empty selection → `$domain->setThirdPartySetting('domain_role_sync', 'roles', array_filter($values))`
- empty selection → `$domain->unsetThirdPartySetting('domain_role_sync', 'roles')`

## Config object & schema

The mapping is **third-party settings on the Domain config entity** (`domain.record.<id>`), not a
standalone config object. Schema — `config/schema/domain_role_sync.schema.yml`:

```yaml
domain.record.*.third_party.domain_role_sync:
  type: mapping
  mapping:
    roles:
      type: sequence
      sequence:
        type: string   # role machine name
```

Example fragment in an exported `domain.record.example_com.yml`:

```yaml
third_party_settings:
  domain_role_sync:
    roles:
      - brand_a_editor
      - brand_a_moderator
```

## What triggers a sync

`DomainRoleSyncHooks::userPresave()` — `hook_ENTITY_TYPE_presave` for the **user** entity
(attribute `#[Hook('user_presave')]`, delegated from `domain_role_sync_user_presave`). It runs on
**every user save** (create or update). Logic:

```php
foreach ($user->get('field_domain_access')->referencedEntities() as $domain) {
  $roles = $domain->getThirdPartySetting('domain_role_sync', 'roles');
  if (!is_array($roles)) { continue; }
  foreach ($roles as $role) { $user->addRole($role); }
}
```

So: for each domain the user is affiliated with (via `field_domain_access`), the domain's mapped roles
are **added** to the user. Because it runs at presave, the added roles are persisted with that save.

## Operating notes / limits

- **Additive only.** It calls `addRole()` and never `removeRole()`. Removing a domain affiliation does
  **not** revoke the roles it granted (README roadmap item).
- **One-directional.** Domain affiliation drives roles; gaining a role does not add a domain
  affiliation (roadmap item), despite the tagline saying "and vice versa".
- **Re-apply** by re-saving the affected users (for example after changing a domain's mapping).
- If `field_domain_access` is absent on the user entity, `$user->get('field_domain_access')` will not
  resolve — the field is expected to exist from a normal Domain Access install.
- Mapping changes are ordinary configuration, so they export/import cleanly with config management.
