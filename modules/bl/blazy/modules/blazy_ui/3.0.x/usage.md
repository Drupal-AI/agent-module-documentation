Blazy UI adds the global configuration form for the Blazy module, exposing lazy-load engine, placeholder, and effect settings to site builders.

---

Blazy UI is the optional administrative front end for Blazy. The base Blazy module ships no admin UI to keep runtime dependencies minimal; enabling Blazy UI adds a settings form at **Admin → Configuration → Media → Blazy** (route `blazy.settings`, path `/admin/config/media/blazy`) that writes `blazy.settings` config. From here site builders tune the IntersectionObserver/loader behavior (offset, root margin, threshold, load-invisible), choose the blur/LQIP effect (`fx`), set a global placeholder or one-pixel data URI, toggle native vs bLazy loading, enable oEmbed handling and privacy consent, and set admin CSS. It defines a single `administer blazy` permission (access-restricted) that gates the form. Once configured, its settings act as defaults consumed by every Blazy field formatter, the Blazy text filter, and Views plugins. It is safe to enable on production and equally safe to leave disabled once configuration is exported.

---

- Open a global Blazy settings form at `/admin/config/media/blazy`.
- Set the default lazy-load offset (how early images start loading before the viewport).
- Configure IntersectionObserver `rootMargin` and `threshold`.
- Enable "load invisible" for elements hidden then shown (tabs/sliders).
- Choose the blur-up / LQIP effect (`fx`) applied while images load.
- Set a global placeholder image or enable a one-pixel data URI placeholder.
- Toggle native browser lazy loading vs the bLazy/IO loader.
- Enable oEmbed handling for remote video across the site.
- Turn on privacy-consent gating for third-party media embeds.
- Enable admin CSS tweaks for Blazy formatter forms.
- Establish site-wide defaults inherited by all Blazy field formatters.
- Provide defaults for the Blazy text filter used in CKEditor.
- Grant the `administer blazy` permission to trusted roles only.
- Export the tuned `blazy.settings` config for deployment across environments.
- Adjust polyfill/RAF/promise no-JS fallbacks.
- Set a wrapper/visible CSS class applied to lazy containers.
- Disable Blazy UI after configuration to trim the admin menu while keeping settings.
- Diagnose lazy-loading behavior by temporarily changing the loader engine.
- Standardize placeholder and blur behavior for a design system.
- Reduce layout shift globally by tuning ratio/placeholder defaults.
