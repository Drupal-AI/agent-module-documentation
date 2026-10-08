# Configuration

There are two things to manage: the **exclusion list** on the settings page, and the
**per‑bundle permissions** you grant to roles.

## The settings page

Go to **Configuration → Entity Bundle Permissions**
(`/admin/config/entity-bundle-permissions`), gated by the **Administer entity bundle
permissions** permission. It has a single setting:

- **Ignored entity types** — a multiselect of the content entity types the module
  should **leave alone**. Anything listed here is skipped entirely: no per‑bundle
  permissions are generated for it, and its entities aren't gated. The list only
  offers entity types that would otherwise qualify (content entity types that have
  bundles). Use it to keep types like users, taxonomy terms, or media out of the
  access control if you only want to gate, say, nodes.

**Saving the form has a useful side effect:** it revokes any bundle permissions that
no longer exist from every role — for example permissions for a type you just added
to the ignored list, or for a bundle that was deleted. (Changing the setting with
Drush does *not* trigger that cleanup, so resave the form if you need stale
permissions purged.)

## The generated permissions

For every applicable content entity type, the module generates one permission per
bundle, named like:

```
entity_bundle_permissions access <entity_type> <bundle>
```

For example `entity_bundle_permissions access node article`,
`entity_bundle_permissions access media image`, or
`entity_bundle_permissions access block_content basic`. Grant these to roles on the
normal **People → Permissions** page.

### Remember the "restrict only" rule

Each permission is purely restrictive. Its own description says granting it gives **no
additional access** — it only stops being a blocker. So:

- A role **with** the permission for a bundle → access is decided by the normal rules
  (core permissions, node grants, and so on).
- A role **without** it → **every** operation (view, edit, delete) on that bundle is
  **forbidden**, overriding any permissive grant from another module.

The net effect is a strict allow‑list: after enabling the module, a role reaches a
bundle only if you've granted it that bundle's permission (or the type is in the
ignored list).

## Granting via Drush

If you prefer the command line:

```bash
drush role:perm:add editor 'entity_bundle_permissions access node article'
drush role:perm:remove anonymous 'entity_bundle_permissions access node private_note'
```

You can also read or set the exclusion list directly:

```bash
drush config:get entity_bundle_permissions.settings ignored_entity_types
```

(Remember: if you set it via Drush, resave the settings form to clean up any now‑stale
permissions on your roles.)
