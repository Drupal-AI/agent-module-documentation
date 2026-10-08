# Configuration

Block Access has no settings form. You configure it entirely by granting its
permissions on **People → Permissions** (`/admin/people/permissions`).

## The permissions it adds

The module generates permissions **per content block type**, so the exact strings
depend on the block types you have. On a site with a `basic` block type, for
example, you'll see permissions named for `basic`. For each type you get:

| Permission | Status | What it allows |
|------------|--------|----------------|
| **Update own `<type>` block content** | active | Edit only the content blocks of that type the user created. |
| **Delete own `<type>` block content** | active | Delete only the content blocks of that type the user created. |
| **Create `<type>` block content** | deprecated (removed in 2.0.0) | Create blocks of that type — use core's *Create `<type>` block content* instead. |
| **Update any `<type>` block content** | deprecated (removed in 2.0.0) | Edit any block of that type — use core's *Edit any `<type>` block content*. |
| **Delete any `<type>` block content** | deprecated (removed in 2.0.0) | Delete any block of that type — use core's *Delete any `<type>` block content*. |

The **own**‑scoped permissions are the ones core does not provide, and the reason
to use this module. Add a new content block type and its permissions appear
automatically (clear caches if you don't see them right away).

## A typical author workflow

To let a role create and manage its own blocks of a given type without touching
site configuration, combine core's create permission with this module's
"own"‑scoped ones. For example, for a role managing `promo` blocks:

- **Create `promo` block content** (core's permission)
- **Update own `promo` block content** (Block Access)
- **Delete own `promo` block content** (Block Access)

Leave *Administer blocks* unchecked so the role stays least‑privilege. Thanks to
the module's add‑form access rule, a user can reach the "Add content block" form
for a type as long as they hold either *Administer blocks* or that type's create
permission.

## Granting via config

If you manage roles as exported configuration, the permissions are just strings
in `user.role.<role>.permissions`, for example:

```yaml
permissions:
  - 'update own basic block_content'
  - 'delete own basic block_content'
```

## Upgrading to 2.0.0

Because the *create* / *update any* / *delete any* permissions are removed in
2.0.0, the module ships an update hook that migrates roles to the equivalent core
permissions where one exists. If you only ever used those deprecated permissions,
the update tells you the module can be uninstalled. If you rely on the
*update own* / *delete own* permissions, keep the module — core has no equivalent.
