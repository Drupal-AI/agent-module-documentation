# Permissions

From `blue_billywig.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer blue_billywig` | The settings form (`blue_billywig.settings`, `/admin/config/media/blue-billywig`) — API credentials, playout, embed type, feature toggles. | Config/admin permission. |
| `upload videos to blue_billywig s3` | The three S3 upload POST routes (`blue_billywig.s3.initialize_upload` / `.complete_upload` / `.abort_upload`) used by the Uppy widget. | Grant to content editors who may upload videos to the platform. Its holder can create clips on the connected OVP account and obtain presigned S3 upload URLs; scope is limited to uploading videos (the controller rejects non-video MIME types), i.e. the module's intended editor capability — not a boundary-crossing/privilege-escalation grant. |

Neither permission is marked `restrict access: true`.

## Route access summary

- Settings form → `_permission: administer blue_billywig`.
- S3 upload routes → `_permission: upload videos to blue_billywig s3` (POST only).
- Media library search (`blue_billywig.media_library_search`) → `_custom_access:
  media_library.ui_builder:checkAccess` (same gate as core media library).
- Accessibility & content-protection forms (`blue_billywig.request_accessibility`,
  `blue_billywig.content_protection`) → `_entity_access: media.update` on the target media entity.

No dedicated permission is required to view/import existing clips beyond normal media library access.
