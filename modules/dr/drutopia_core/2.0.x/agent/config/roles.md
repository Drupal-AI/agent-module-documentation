<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site-wide roles & permissions

Drutopia Core defines the distribution's role baseline. It works in two layers:

1. **`config/install/user.role.*.yml`** create the base role entities (no permissions in these files):
   - `administrator` — weight 5, **`is_admin: true`** (core grants it every permission automatically).
   - `contributor` — weight 2.
   - `editor` — weight 3.
   - `manager` — weight 4.
   (`anonymous` and `authenticated` already exist from core.)

2. **`config/actions/user.role.*.yml`** are **config-action** files that `add` permissions (and module/config dependencies) onto the role after it exists. There are five: `anonymous`, `authenticated`, `contributor`, `editor`, `manager`. Each uses `plugin: add`, `path: ["permissions"]`. The exact permission set each role receives (the `value` of every action) is below.

There is **no** action file for `administrator` — it needs none because `is_admin` grants all permissions.

## anonymous
- `access content`
- `use exclude node title`
- `view media`

## authenticated
- `access content`
- `access shortcuts`
- `cancel account`
- `change own username`
- `delete own files`
- `use exclude node title`
- `view media`

## contributor
- `access content overview`
- `access contextual links`
- `access media overview`
- `create media`
- `create terms in tags`
- `delete own files`
- `edit terms in tags`
- `update media`  *(value of the `update own media` action; note the value string is `update media`)*
- `use exclude node title`
- `view all revisions`
- `view all media revisions`
- `view own unpublished content`
- `view the administration theme`

Also adds config dependency `taxonomy.vocabulary.tags`.

## editor
- `access administration pages`
- `access content overview`
- `access contextual links`
- `access files overview`
- `access media overview`
- `access site in maintenance mode`
- `access toolbar`
- `access tour`
- `access user profiles`
- `administer nodes`
- `administer taxonomy`
- `administer users`
- `create media`
- `create url aliases`
- `delete all revisions`
- `delete own files`
- `revert all revisions`
- `update any media`
- `use exclude node title`
- `view all media revisions`
- `view all revisions`
- `view own unpublished content`
- `view own unpublished media`
- `view the administration theme`

## manager
Everything `editor` gets, plus:
- `access user contact forms`
- `Administer account settings`
- `Administer date-time`
- `Administer site information`
- `administer url aliases`

(Full manager set: `access administration pages`, `access content overview`, `access contextual links`, `access files overview`, `access media overview`, `access site in maintenance mode`, `access toolbar`, `access tour`, `access user contact forms`, `access user profiles`, `Administer account settings`, `Administer date-time`, `administer nodes`, `Administer site information`, `administer taxonomy`, `administer url aliases`, `administer users`, `create media`, `create url aliases`, `delete all revisions`, `delete own files`, `revert all revisions`, `update any media`, `use exclude node title`, `view all media revisions`, `view all revisions`, `view own unpublished content`, `view own unpublished media`, `view the administration theme`.) The `manager` action also adds the `config_perms` module dependency.

## Trust model

`anonymous` and `authenticated` receive only read/self-service permissions. `contributor` is a content author. `editor` and `manager` are administrative roles (`administer nodes/taxonomy/users`, revision control, URL aliases) intended for trusted staff; `administrator` (`is_admin`) is full control. No role is granted permission definitions provided by this module itself — it ships none (`provides_permissions=false`); the strings above are core/contrib permissions. Two `config_perms` custom-permission entities are also shipped (`administer_site_information`, `edit_contact_form`) — see [shipped-config.md](shipped-config.md).
