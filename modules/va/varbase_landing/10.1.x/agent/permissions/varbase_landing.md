<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# varbase_landing — permissions

`varbase_landing` defines **no** permissions of its own (no `varbase_landing.permissions.yml`). The
permissions in play are the standard per-bundle node permissions that core's Node module generates
for the `landing_page` content type (`create landing_page content`,
`edit any/own landing_page content`, `delete any/own landing_page content`,
`view/revert landing_page revisions`, …).

What the module *does* is **grant** those permissions to a set of roles when its recipe runs
(`recipes/default/recipe.yml`, `config.actions … grantPermissions`). These roles are the Varbase
distribution roles; on a plain Drupal site some (e.g. `editor`, `content_admin`, `seo_admin`,
`site_admin`) may not exist, in which case those grant actions no-op.

| Role | Granted on `landing_page` |
|---|---|
| `authenticated` | `edit own`, `delete own` |
| `editor` | `create`, `edit any`, `view revisions` |
| `content_admin` | `create`, `edit any`, `delete any`, `revert revisions`, `view revisions` |
| `seo_admin` | `create`, `edit any`, `delete any`, `view revisions` |
| `site_admin` | `create`, `edit any`, `delete any`, `revert revisions`, `view revisions` |

Notes for reasoning about access:
- **Authenticated users get only `edit own` / `delete own`, not `create`.** Without a `create` grant
  they cannot author a landing page, so in practice these apply only to landing pages another role
  set them as author of. There is no privilege escalation here — creation is limited to the four
  admin/editor roles above.
- To let a new role manage landing pages, grant the same core node permissions (via UI at
  `/admin/people/permissions` or config), not a module-specific permission.
