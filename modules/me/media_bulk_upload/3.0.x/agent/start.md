# media_bulk_upload — agent start

Bulk-upload files and convert each to a media entity, matched to a media type by file extension.
Defines the `media_bulk_config` config entity (media types + form mode + upload location) and a
bulk upload form at `/media/bulk-upload/{media_bulk_config}`. Depends on core `media`. Admin UI:
**Admin → Configuration → Media → Bulk upload media** (`/admin/config/media/media-bulk-config`);
configure route `entity.media_bulk_config.collection`.

- Create/manage bulk-upload configs, settings keys, routes → [configure/media_bulk_upload.md](configure/media_bulk_upload.md)
- Permissions (static admin + dynamic per-config) → [permissions/media_bulk_upload.md](permissions/media_bulk_upload.md)
- Alter uploaded file IDs before media creation (hook) → [hooks/media_bulk_upload.md](hooks/media_bulk_upload.md)
- Submodule: DropzoneJS drag-and-drop uploader → [../../modules/media_bulk_upload_dropzonejs/3.0.x/agent/start.md](../../modules/media_bulk_upload_dropzonejs/3.0.x/agent/start.md)
