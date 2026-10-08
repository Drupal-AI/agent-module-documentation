# Background Image — agent index

Attach background images to a site globally / per entity / per bundle / per path / per route / per
view, using **Media** for uploads and **Context** for placement. Optional blur, full-viewport, and
overlay-text effects. Depends on `field`, `media`, `context`. Provides a config schema and the
`administer background image` permission (restrict access). No Drush.

- **Global settings, the `background_image.settings` config (image styles, base_class, entities
  map), the media type & background image entity, and the Context reaction** →
  [configure/settings.md](configure/settings.md)
- **The four alter hooks (`background_image.api.php`) for CSS template, build, and overlay text** →
  [api/hooks.md](api/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route `background_image.settings` → `/admin/config/media/background_image`
  (gated by core `administer site configuration`); the form only edits CSS `base_class` today.
- `BackgroundImage` content entity (`background_image_field_data`): fields `image`, `media`,
  `label`, `type` (int; GLOBAL=-1, ENTITY=0, ENTITY_BUNDLE=1, PATH=2, ROUTE=3, VIEW=4),
  `target`, `settings` (map).
- Service `background_image.manager` (`BackgroundImageManager::service()`): `getBackgroundImage()`,
  `view()`, `colorSampleFile()/colorIsDark()`, `getBaseClass()`.
- Plugins: Block `background_image` + `background_image_text`; Context reaction `background_image`.
- `hook_system_info_alter` injects a "Background Image" region into all themes; `preprocess_html`
  adds `<base_class>-dark` / `<base_class>-full-viewport` body classes.
- Assets: jscolor picker loaded from jsDelivr **CDN with an SRI integrity hash**; `scrolling.blur`
  JS for scroll-triggered blur.
