<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, install & the headless role

## Config object `acquia_cms_headless.settings`

Schema: `config/schema/acquia_cms_headless.schema.yml` (type `config_object`). Install default:
`config/install/acquia_cms_headless.settings.yml`.

| key | type | default | meaning |
|-----|------|---------|---------|
| `starterkit_nextjs` | boolean | `false` | Next.js starter kit initialized |
| `headless_mode` | boolean | `false` | Pure headless mode (submodule) enabled |
| `consumer_uuid` | string | `''` | UUID of the provisioned headless consumer |
| `user_uuid` | string | `''` | UUID of the provisioned headless user |

`consumer_uuid`/`user_uuid` are written by `StarterkitNextjsService::initStarterkitNextjs()` after
provisioning, and cleared by `resetStarterkitNextjs()`. `headless_mode` is toggled by the tour form
(`Plugin/AcquiaCmsTour/AcquiaHeadlessForm::submitForm()`) and by the submodule's install handler.

## Install (`acquia_cms_headless.install`)

`hook_install()` (only when not `$is_syncing`):
1. `StarterkitNextjsService::createHeadlessUser()` — programmatically creates the `Headless` user.
2. `add_next_site_permissions()` — grants `issue subrequests` to **anonymous and authenticated**
   roles (so the front end can batch JSON:API subrequests).
3. Installs `restui`.

Update hooks: `_8001` renames the `headless` role to "Headless Administrator" and adds revision/
unpublished view permissions, plus creates a `frontend_site_with_preview` role; `_8002` back-fills
content-model roles onto the consumer's user and re-runs `add_next_site_permissions()`; `_8003`
sets `seckit.settings` `seckit_clickjacking.x_frame` to `'0'` (disables X-Frame-Options, needed so
the Next.js preview iframe can embed Drupal); `_8004` migrates the old dashboard permission name;
`_8005` proxies `consumers_update_8109`; `_8006` deletes a legacy `frontend_preview_headless` role.

`config/rewrite/seckit.settings.yml` performs the same `x_frame: '0'` rewrite at install via the
acquia_cms config-rewrite mechanism.

## The `headless` role (`config/install/user.role.headless.yml`)

`id: headless`, label "Headless Administrator", `is_admin: false`, enforced-dependent on this module.
Permissions: `access acquia cms headless dashboard`, `access user profiles`, `administer acquia cms
headless configuration`, `administer acquia cms headless keys`, `bypass node access`, `issue
subrequests`, `view all revisions`, `view any unpublished content`, `view latest version`. This is
the role assigned to the auto-created headless user and to the OAuth consumer (via its `roles`
field) so the decoupled app's token can read unpublished/latest-revision content over JSON:API.

## Permissions (`acquia_cms_headless.permissions.yml`)

- `administer acquia cms headless configuration`
- `access acquia cms headless dashboard`
- `administer acquia cms headless keys` (gates the secret/key generator routes)

## Module hooks (`acquia_cms_headless.module`)

- `hook_content_model_role_presave_alter()` — when a `content_administrator`/`content_author`/
  `content_editor` role is presaved, adds that role to the `headless` user (`user_load_by_name`).
- `hook_field_formatter_info_alter()` — replaces core `oembed` formatter class with
  `OEmbedAdvanceFormatter` (returns oEmbed metadata suitable for a decoupled client).
