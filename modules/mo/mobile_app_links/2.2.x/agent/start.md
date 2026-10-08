# Mobile App Link — agent index

Serves the public `.well-known` domain-association files for iOS Universal Links and Android
App Links, generated from admin config. Four config forms + four public controller routes.
One permission, config schema, no Drush, no plugin types. Core-only.

- **The four config forms, the four public `.well-known` routes, config object names, and how
  files are generated** → [configure/wellknown.md](configure/wellknown.md)

Key facts:
- Public routes (all `_access: TRUE`, served by `src/Controller/WellKnownController.php`):
  `/.well-known/assetlinks.json`, `/.well-known/apple-app-site-association`,
  `/.well-known/apple-developer-domain-association.txt`,
  `/.well-known/apple-developer-merchantid-domain-association.txt`.
- Admin routes under `admin/config/mobile-app-links/*`, permission `administer mobile app links`;
  `configure` route `mobile_app_links.config`.
- Config objects: `mobile_app_links.ios`, `mobile_app_links.android_packages`,
  `mobile_app_links.apple_dev_id_assoc`, `mobile_app_links.apple_dev_merchantid_assoc`.
- `MobileAppLinksPathProcessor` disables route normalization + strips language prefix for any
  `.well-known` path (service tags `path_processor_inbound`/`outbound`).
