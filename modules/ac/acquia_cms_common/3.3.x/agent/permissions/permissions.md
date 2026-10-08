<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & roles

## Permission defined

`acquia_cms_common.permissions.yml` declares one permission:

| Permission | Notes |
| --- | --- |
| `use text format full_html` | Declared with `provider: filter` — it augments the Filter module's dynamic text-format permission for the `full_html` format that this module ships. |

That is the only statically-declared permission. On install the module grants `access content` and
`view media` to both the `anonymous` and `authenticated` roles.

## Roles this module builds programmatically

The `content_model_role_presave` flow and `PermissionFacade` create/update these roles when the relevant
content-type / feature submodules are installed (`acquia_cms_common_modules_installed()`):

| Role | Created when a module of this set installs | Purpose |
| --- | --- | --- |
| `content_administrator` | content-model modules (`acquia_cms_article/dam/event/page/person/place`) | Full editorial admin (`administer nodes`, `bypass node access`, all editorial transitions, moderation dashboard, taxonomy/media admin). |
| `content_author` | content-model modules | Author role (basic administer perms + `administer menu`, `view own unpublished content`). |
| `content_editor` | content-model modules | Editor role (basic perms + publish/archive transitions, `view any unpublished content`, scheduling). |
| `user_administrator` | `shield`/`honeypot`/`recaptcha` | Granted `administer shield/honeypot/CAPTCHA/recaptcha` per module presence (via `hook_content_model_role_presave_alter`). |
| `site_builder` | `acquia_cms_site_studio` | Updated alongside the content roles. |

`PermissionFacade::getBasicAdministerPermissions()` is the shared baseline for the three `content_*` roles
(overview access, editorial `create_new_draft`/`review` transitions, moderation dashboard/sidebar, latest
version, `use text format filtered_html`/`full_html`, admin theme).

`update_8001` also grants `use text format full_html` to `administrator`, `content_administrator`,
`content_author`, `content_editor`, `developer`, `site_builder` when the shipped `full_html` format is
installed.

To add permissions to these roles from your own module, implement
`hook_content_model_role_presave_alter()` — see [../hooks/integration.md](../hooks/integration.md).
