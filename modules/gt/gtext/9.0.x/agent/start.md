# gText — agent index

A **locale string-translation** utility (built on core `locale`): a page to browse/translate the
site's interface strings, a Twig `gtext()` helper, and optional **Google Translate** machine
translation. It is about **text/string translation, not fonts**.

Key facts:
- Configure route: `gtext.translate` → **`/admin/config/texts`** (the "Translating texts" UI),
  permission `access gtext translate strings`. A separate settings page for the Google key is
  `gtext.translate.settings_page` → `/admin/config/gtext/settings`
  (permission `administer site configuration`).
- Only config: `gtext.settings` → **`google_api_key`** (string). **Not shipped** by default (no
  `config/install`), so the object is absent until you set a key.
- With a key → uses the official `google/cloud-translate` client. **Without** a key → free
  fallback via translate.google.com (≤ 1000 chars/request).
- Permissions: `access gtext translate strings` (the UI, restricted) and `access gtext translate`
  (inline translate buttons on config/entity translation forms).
- Depends on `locale`; library `google/cloud-translate`. No Drush.

Docs:
- **Google API key config, routes, permissions** → [configure/settings.md](configure/settings.md)
- **Twig `gtext()` helper, translation service, Google/fallback mechanism** → [api/translate.md](api/translate.md)
