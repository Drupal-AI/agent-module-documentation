# Permissions

Varbase Carousels defines **no** `varbase_carousels.permissions.yml`. Access is governed by the
per-bundle permissions that **core `block_content` generates** for the `varbase_carousel_block`
bundle, and by core global block-content permissions:

| Permission | Grants |
|---|---|
| `create varbase_carousel_block block content` | Add a carousel block. |
| `edit any varbase_carousel_block block content` | Edit any carousel block. |
| `edit own varbase_carousel_block block content` | Edit own carousel blocks. |
| `delete any varbase_carousel_block block content` | Delete any carousel block. |
| `delete own varbase_carousel_block block content` | Delete own carousel blocks. |
| `access block library` / `administer block content` | Core: reach the block-content UI. |
| `administer blocks` / `administer block_content display` | Core: place blocks / edit the type's fields & displays. |

## Grants shipped at install (Varbase convention)

The module carries a `config/permissions/` directory (not standard Drupal — consumed by
`ModuleInstallerFactory::addPermissions('varbase_carousels')` from `hook_install`). Each file grants
the listed permissions to an existing Varbase role, if that role exists:

| Role (`config/permissions/user.permissions.<role>.yml`) | Granted permissions |
|---|---|
| `content_admin` | `create`, `edit any`, `delete any` varbase_carousel_block block content |
| `site_admin` | `create`, `edit any`, `delete any` varbase_carousel_block block content |
| `seo_admin` | `create`, `edit any` varbase_carousel_block block content |
| `editor` | (none) |
| `authenticated` | (none) |
| `anonymous` | (none) |

These roles are Varbase-distribution roles; on a non-Varbase site the grants are simply no-ops for
roles that do not exist. There is no anonymous or authenticated grant — carousels are edited only by
the admin/editor roles above.
