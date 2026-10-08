# lazy (Lazy-load) — agent start

Defers loading of images and iframes until near the viewport, using native `loading="lazy"`
or the JavaScript **lazysizes** library. Three entry points: a text-format **filter** for inline
`<img>`/`<iframe>`, image **field formatters**, and a `data-lazy` render attribute. Depends on
core `filter` + `system`. Package: *Input filters*. Config UI:
**Admin → Config → Content authoring → Lazy-load** (`/admin/config/content/lazy`); route
`lazy.config_form`, gated by the core `administer filters` permission. Requires the lazysizes
library in `/libraries/lazysizes` (unless using native-only mode).

- Enable & configure lazy-loading (filter, field formatters, native vs library, skip class, visibility) → [configure/lazy.md](configure/lazy.md)
- Call the `lazy` service and implement the alter hooks → [api/lazy.md](api/lazy.md)
