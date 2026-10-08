Deprecated, empty submodule of Crop API — it provides no functionality and will be removed in a future release; do not enable it.

---

`crop_media_entity` was once a compatibility bridge between Crop API and the old contrib Media Entity module. That integration is now handled directly by Crop API's core Media support, so the submodule has been emptied out. Its `.module` file contains only a deprecation notice and it is marked `hidden: true` in its info file. It ships no routes, services, plugins, config, or hooks. It exists only so existing sites that still have it enabled do not fatal on update. New sites should ignore it entirely and rely on the parent Crop module.

---

- Nothing — the module is deprecated and does nothing.
- Left enabled only for backward compatibility on legacy sites; safe to uninstall.
