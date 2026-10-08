# Configuring Role Access Control

RAC has **no settings page of its own** — `rac.info.yml` sets `configure: adva.settings`. You wire
up role access through ADVA's settings plus a field, and (optionally) the `rac_relations` form.

## Where configuration lives

| Surface | Location | Gated by |
| --- | --- | --- |
| Enable a RAC provider on an entity type / field | ADVA settings, `/admin/config/people/adva` (route `adva.settings`) | ADVA's own permission |
| "Enable Role Access Control on this field" checkbox | Field storage edit form (`field_storage_config_edit_form`) | field admin perms (`administer <type> fields`) |
| Update-by-related-role grid | `/admin/config/people/rac/relations` (route `rac_relations.settings`) | `administer rac_relations` |

## Turning it on (typical flow)

1. Add an **entity-reference field** whose target type is `user_role` (a "Role" reference) to the
   bundle you want to protect (node, paragraph, etc. — any entity type with an ADVA consumer).
2. On the field's storage edit form RAC injects a **Role Access Control** details group with the
   checkbox *"Enable Role Access Control on this field."* (form key `rac_enabled`). Saving stores a
   field-storage third-party setting: namespace `rac`, key `enabled` (bool). This checkbox only
   appears when the field's host entity type is served by a RAC consumer
   (`_rac_get_supported_entity_types()`) and the target type is `user_role`.
3. Go to `adva.settings` and enable the desired RAC provider (`rac`, `rac_typed`, and/or
   `rac_relations`) for that entity type, choosing which operations (view/update/delete) the field's
   referenced roles grant. ADVA persists this as per-provider `enabled_fields` config on the
   `access_consumer` config entity — this is what actually activates the grants.
4. **Rebuild node access** after changing configuration on an existing site, e.g.
   `drush php:eval 'node_access_rebuild();'`.

> Note: within RAC's own shipped code the `rac.enabled` third-party setting is written by the form
> but only read by helper functions that no hook invokes in 2.2; the operative on/off switch for
> grants is ADVA's per-field `enabled_fields` config (set in step 3), not the checkbox alone.

## The `rac.settings` config object

`config/install/rac.settings.yml`:

```yaml
update_unpublished: 1
```

- `update_unpublished` (bool, default `1`/TRUE) — intended to control whether update grants extend to
  unpublished content. Read by `_rac_update_unpublished()` in `rac.module`. The value is migrated onto
  each field's `unpublished` config by update hook `rac_update_8101`; ADVA reads that per-field flag,
  so `rac.settings` acts as the install-time default. No `config/schema` is provided for this object.

Set it via drush or PHP:

```bash
drush config:set rac.settings update_unpublished 0
```

```php
\Drupal::configFactory()->getEditable('rac.settings')->set('update_unpublished', FALSE)->save();
```

## `rac_relations` settings form

Submodule `rac_relations` adds route `rac_relations.settings` (`/admin/config/people/rac/relations`,
menu link "Role Access Relations" under the People admin index), rendered by
`RoleAccessControlRelationsForm`. It is a role-by-role grid: each row is an editor role, each column a
target role; ticking a cell grants that editor role the permission to update content owned by the
target role. On submit it grants/revokes the `RAC update <target_role_id>` permission on each role
(admin/superuser roles are shown disabled and skipped). Requires `administer rac_relations`.
