# video_embed_field — agent start

Field type storing a 3rd-party video URL (YouTube/Vimeo) rendered as a responsive embed with
cached thumbnails. Providers are plugins (`@VideoEmbedProvider`, `ProviderManager`). No global
config UI — everything is per-field/formatter in Field UI. Depends on core `field`, `image`,
`system`.

- Field type, widget & formatter settings (autoplay, responsive, loading, Colorbox) → [configure/field-and-formatters.md](configure/field-and-formatters.md)
- Add a new video host (VideoEmbedProvider plugin) → [plugins/provider.md](plugins/provider.md)
- Preprocess iframes / alter provider definitions (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Permissions ("never autoplay videos") → [permissions/permissions.md](permissions/permissions.md)
- Submodules: `video_embed_media` (Media), `video_embed_wysiwyg` (CKEditor 5), `vem_migrate_oembed` (Drush migrate) — see their own docs.
