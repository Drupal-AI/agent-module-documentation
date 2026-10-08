Lazy-load defers loading of images and iframes until they are near the viewport, using either the browser's native `loading="lazy"` attribute or the JavaScript lazysizes library, to speed up initial page rendering.

---

Lazy-load enables lazy-loading in three ways: a text-format filter (**Lazy-load images and iframes**) that rewrites inline `<img>` and `<iframe>` tags in formatted text; two image field formatters (**Image (Lazy-load)** and **Responsive image (Lazy-load)**) plus a per-formatter checkbox that opt image fields into lazy-loading; and a Form API `data-lazy` attribute you can add to any image render element. A single settings form at `/admin/config/content/lazy` (route `lazy.config_form`, gated by the core `administer filters` permission) controls global behavior. The key toggle is **preferNative**: when enabled the module simply adds `loading="lazy"` and no JS runs; when disabled it uses the lazysizes library for all browsers, swapping `src` to a `data-src` attribute and adding the `lazyload` marker class. A `skipClass` (default `no-lazy`) lets you exempt individual elements (or their parent) from lazy-loading, and a visibility condition (`request_path`, default excludes `/rss.xml`) plus a "disable on admin pages" toggle restrict where lazy-loading applies. Lazy-loading is automatically disabled on AMP pages (`?amp` query). The lazysizes library (installed to `/libraries/lazysizes`, path/URL configurable) exposes extensive tuning: marker class names, `srcAttr`/`srcsetAttr`/`sizesAttr`, `expFactor`, `loadMode`, `throttleDelay`, and ~22 optional plugins (bgset, blur-up, respimg, parent-fit, unveilhooks, etc.). Developers get a `lazy` service (`isEnabled()`, `isPathAllowed()`, `getSettings()`, `getPlugins()`) and four alter hooks to add field formatters, override CSS/effect styles, or override settings per host.

---

- Lazy-load inline images pasted into a rich-text Body field via the text-format filter.
- Lazy-load inline iframes (embedded YouTube/Vimeo/maps) in formatted text.
- Enable lazy-loading only for `<img>` tags (not iframes), or vice-versa, per text format.
- Lazy-load an image field in a view mode using the **Image (Lazy-load)** formatter.
- Lazy-load a responsive image field with the **Responsive image (Lazy-load)** formatter.
- Add a lazy-loading checkbox to the standard Image/Colorbox/Media Thumbnail formatters via third-party settings.
- Use native browser lazy-loading (`loading="lazy"`, zero JavaScript) by enabling **preferNative**.
- Fall back to the lazysizes library for all browsers by disabling **preferNative**.
- Exempt a specific image from lazy-loading by adding the `no-lazy` skip class.
- Exempt everything inside a wrapper by putting the skip class on the parent element.
- Show a lightweight placeholder (e.g. a 1x1 transparent GIF) via `placeholderSrc` while the real image loads.
- Disable lazy-loading on RSS/feed paths through the visibility condition (default `/rss.xml`).
- Limit lazy-loading to only specific pages by negating the visibility condition.
- Keep lazy-loading off administrative pages (default) or turn it on there.
- Automatically skip lazy-loading on AMP pages (`?amp` query string).
- Serve the lazysizes library from a custom local path or an external CDN URL.
- Add a `data-lazy` attribute to any image render array to lazy-load it from a custom module/form.
- Tune the lazysizes viewport expand distance (`expFactor`, `loadMode`, `hFac`) for eager or lazy preloading.
- Enable lazysizes plugins such as bgset, blur-up, respimg, parent-fit, or unveilhooks.
- Apply a fade-in CSS transition on load by enabling the default CSS effect.
- Register a custom image field formatter for lazy-loading via `hook_lazy_field_formatters_alter()`.
- Override the default or effect CSS styles with `hook_lazy_default_styles_alter()` / `hook_lazy_effect_styles_alter()`.
- Point the library path at a different CDN per hostname with `hook_lazy_settings_alter()`.
- Rename the lazysizes marker/loaded/loading class names to match a theme.
- Change the source attribute lazysizes reads (`srcAttr`, e.g. `data-src`).
- Check in code whether lazy-loading is active for the current path via the `lazy` service.
- Reduce initial page weight and improve Core Web Vitals (LCP) by deferring below-the-fold media.
- Migrate from the older 8.x-2.x bLazy-based configuration to the lazysizes engine.
