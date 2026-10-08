# Permissions

Defined in `llms_txt.permissions.yml`. **New in 1.1.x:** a second, delegated permission for
managing section entities separately from the config body.

| Permission machine name | Title | Gates |
|---|---|---|
| `administer llms.txt configuration` | Administer /llms.txt configuration | The config form `llms_txt.llms_txt_config` at `/admin/content/llms-txt` (the tokenised config body) **and** full section create/edit/delete/collection access. |
| `administer llms.txt sections` | Administer /llms.txt sections | Section entity management only — create/edit/delete and the collection at `/admin/content/llms-txt/sections`. Does **not** grant access to the config body form. |

How they combine (from `LlmsTxtSectionAccessHandler`):

- **create / update / delete** of a `llms_txt_section` → allowed if the account holds
  **either** `administer llms.txt configuration` **or** `administer llms.txt sections`
  (`allowedIfHasPermission(... 'configuration')->orIf(allowedIfHasPermission(... 'sections'))`).
- **collection** route (`/admin/content/llms-txt/sections`) → gated by the entity type's
  `collection_permission = administer llms.txt sections`.
- **view** of a section → publicly allowed when the section is **published** (this is what lets
  the `/llms.txt` endpoint render it); otherwise falls back to the two-permission check above.
- **view label** → always allowed.

Neither permission is marked `restrict access`. Grant `administer llms.txt sections` to a content
team that should curate sections without being able to change the deployable config body; grant
`administer llms.txt configuration` for full control.
