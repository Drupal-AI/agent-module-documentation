# media_file_delete — agent start

Adds an optional "Also delete the associated file?" checkbox to the media **delete** and
**bulk delete** confirm forms, so deleting a media item can also delete its underlying file.
Guards deletion by file-delete access and by file usage. Alters the `media` entity's delete
forms via `hook_entity_type_alter` (`MediaFileDeleteHooks`). Depends on core `media`, `file`.
Config UI: **Admin → Config → Media → Media File Delete Settings**
(`/admin/config/media/media_file_delete/settings`); route `media_file_delete.settings`.

- Settings + how the delete forms/confirm option work → [configure/settings.md](configure/settings.md)
- Permissions (`delete any file`, `administer media file delete`) → [permissions/permissions.md](permissions/permissions.md)
- Add a custom file-usage resolver (tagged service) → [extend/usage-resolver.md](extend/usage-resolver.md)
- Submodule `media_file_delete_entity_usage` guards files in use per Entity Usage → see its own docs
