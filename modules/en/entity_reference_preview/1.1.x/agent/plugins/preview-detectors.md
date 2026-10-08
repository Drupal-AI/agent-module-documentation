<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: preview_detector

Preview mode is decided by `preview_detector` plugins. If any plugin reports the request is a preview,
preview mode is on.

## Plugin infrastructure

- Annotation `@PreviewDetector` (`src/Annotation/PreviewDetector.php`; fields `id`, `title`,
  `description`).
- Interface `PreviewDetectorInterface` (`label()`, `isPreviewing(Request $request): bool`).
- Base `PreviewDetectorPluginBase`.
- Manager `PreviewDetectorPluginManager` (service, parent `default_plugin_manager`; subdir
  `Plugin/PreviewDetector`, cache key `preview_detector_plugins`). Implements
  `FallbackPluginManagerInterface` → fallback id **`rendered_entity`**.
  - `activeDetector(Request, $configuration = [])`: instantiates all definitions and returns the id of
    the first that reports `isPreviewing()`, else NULL.
  - `isPreviewing(Request, ...)`: `(bool) activeDetector(...)`.

Add a custom detector by placing a plugin in your module's `Plugin/PreviewDetector` implementing the
interface — it participates automatically.

## Shipped plugins (src/Plugin/PreviewDetector)

- **`rendered_entity`** (`RenderedEntityPreviewDetector`): preview when the route-level content entity
  (the single publishable `ContentEntityInterface` route param) is on a `load_latest_revision` route
  (the `.../latest` tab), OR the entity itself is the latest translation-affected, non-default,
  non-new revision (`entityIsPreviewing()`). No config, purely reflects what is being viewed.
- **`cookie`** (`CookiePreviewDetector`, `ContainerFactoryPluginInterface`): preview when the session
  value `entity_reference_preview.status` equals `previewing`. `start()`/`stop()` set/remove that
  session value; they are called only from `PreviewActionsForm::submitForm()`, which is gated by the
  `request entity_reference_preview preview` permission.

The cookie/session flag is what keeps manual preview active while browsing pages that have no latest
tab (e.g. views listings, blocks, Layout Builder pages).
