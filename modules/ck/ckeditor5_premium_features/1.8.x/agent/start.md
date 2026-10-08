# ckeditor5_premium_features — agent start

Base module for CKEditor's **commercial** Premium Features on Drupal CKEditor 5. It holds the
license key + Cloud Services authentication (JWT tokens) that every feature reuses; the actual
features ship as ~20 **separate submodules** you enable individually (each is just a feature
toggle — they are NOT documented here individually). Depends on core `editor` + `ckeditor5`.
Most features need a **CKEditor commercial license and/or CKEditor Cloud Services subscription**.
Config UI: **Admin → Config → CKEditor 5 Premium Features** (`/admin/config/ckeditor5-premium-features/settings`);
info.yml `configure` route `ckeditor5_premium_features.form.settings`.

- Global license key + Cloud Services auth, and enabling a feature per text format → [configure/ckeditor5_premium_features.md](configure/ckeditor5_premium_features.md)
- Permissions (access token, exporter endpoints) → [permissions/ckeditor5_premium_features.md](permissions/ckeditor5_premium_features.md)

Submodules (enable the ones you need — each is a thin premium-feature toggle):
`_ai`, `_ai_assistant`, `_cloud_services`, `_collaboration`, `_email_editing`, `_export_pdf`,
`_export_word`, `_footnotes`, `_fullscreen`, `_import_word`, `_line_height`, `_mentions`,
`_merge_fields`, `_multi_level_lists`, `_notifications`, `_productivity_pack`,
`_realtime_collaboration`, `_source_editing_enhanced`, `_version_override`, `_wproofreader`.
