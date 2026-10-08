<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

## Own permission (`media_folders.permissions.yml`)

| Permission | Gates |
|---|---|
| `access media folders configuration` | Only the settings form at `/admin/config/media-folders`. Not `restrict access: true`. |

## Access to the browser and operations (reused core permissions)

Media Folders deliberately does **not** invent broad permissions for content ops — it reuses core
Media/Taxonomy access:

- **Browsing / AJAX / preview** routes require core `access media overview`.
- **Sync form** requires `administer modules`.
- **Folder create/edit/delete** — `_custom_access` → `MediaFoldersUiBuilder::hasTermPermission($op)`:
  allowed if the user has `administer taxonomy` **or** `<op> terms in media_folders_folder`
  (`create` / `edit` / `delete`).
- **Media create / upload / move** — `hasMediaCreateAccess()`: allowed with `administer media`,
  `create media`, or `create <bundle> media`.
- **Editing media** (`update-multiple`) — `canEditMedia()`: allowed with `administer media`,
  `update any media`, `update media`, or `edit[ any|own] <bundle> media`.

Net effect: a content editor with `access media overview` can browse; performing writes still requires
the corresponding taxonomy/media permission, so the module does not escalate privilege beyond core.
