Embederator manages reusable third-party embed snippets (CRM forms, iframes, widgets, tracking pixels) as Drupal entities: a config `embederator_type` bundle holds the raw markup skeleton, and each `embederator` content entity fills in the per-instance values via tokens.

---

The module defines two entity types. An `embederator_type` (config entity, bundle) stores the shared embed markup as a `text_format` value plus a `wrapper_class`, or — when "use server-side include" is checked — an `embed_url` to fetch instead. An `embederator` (content entity, fieldable) is one instance of a bundle; it ships a base `embed_id` string field and you may add more fields, all exposable as `[embederator:<field>]` tokens inside the bundle markup/URL. At render, `EmbederatorRender::getEmbedMarkup()` token-replaces the bundle markup with the entity's field values (token replacement escapes those values), while `getSsiMarkup()` fetches the token-replaced URL server-side via the HTTP client and inlines the response body; both are output through a `processed_text` element that is hardcoded to the `full_html` format. The `embederator_default` field formatter (bound to the `embed_id` base field) offers four load styles: direct, lazy (JS swaps in the markup), "lazy unless query params", and iframe-proxy (renders through the `/embederator/lazyload/{id}/{settings}` controller with iframeResizer auto-height). Access is permission-based (`view/add/edit/delete embederator entity`, `administer embederator types`); there is no global settings page (`configure` is null). Templates are `embederator--BUNDLE.html.twig` for per-bundle wrappers, and three alter hooks (`hook_embederator_url_alter`, `hook_embederator_markup_alter`, `hook_embederator_lazyload_alter`) let code adjust the URL, markup, and laziness per embed.

---

- Embed a third-party CRM/marketing form (Blackbaud, tfaform, etc.) once as a bundle and reuse it across many pages with a per-instance ID token.
- Let content editors create a new embed by filling in a single ID field, without touching raw HTML.
- Restrict raw-HTML embed authoring to trusted site builders via the `administer embederator types` permission while editors only supply token values.
- Store the markup for a recurring embed as importable/exportable config so it can be deployed headlessly.
- Use `[embederator:embed_id]` in bundle markup to inject a unique form/video/widget hash per entity.
- Add extra fields to an embed bundle (e.g. a campaign code, a date) and expose them as additional tokens.
- Server-side-include (SSI) an external HTML fragment by URL instead of pasting client-side markup.
- Lazy-load a heavy embed so it only initializes after the page loads.
- Lazy-load an embed only when the page has no query parameters (e.g. skip lazy load for tracked landing URLs).
- Render an embed inside a resizing iframe proxy to isolate its CSS/JS from the host page.
- Auto-size the iframe proxy to its content height with the bundled iframeResizer library.
- Pass outer-page query parameters through to the iframe-proxied embed's src.
- Give each embed a BEM-style, bundle-specific wrapper class for responsive theming.
- Override an embed's wrapper markup with an `embederator--BUNDLE.html.twig` template.
- Append a unique DOM-ID suffix to form inputs in an embed so multiple instances on one page don't collide.
- Force a zero-length cache (`max-age = 0`) for embeds whose third-party markup must always be fresh.
- Alter an SSI fetch URL in code (e.g. add a return-URL parameter) with `hook_embederator_url_alter()`.
- Post-process embed markup before render (trim, rewrite) with `hook_embederator_markup_alter()`.
- Force lazy-load off for specific long-form embeds with `hook_embederator_lazyload_alter()`.
- Maintain a browsable admin list of all embed instances at `/admin/content/embederator`.
- Reference embed entities from other content using the provided `EmbederatorSelection` entity-reference handler.
- Preview the embed markup with token highlighting directly on the entity add/edit form.
- Parse tokens out of a freshly pasted embed code/URL using the form's paste-and-parse helper.
- Localize/standardize how marketing embeds are managed so non-technical staff can launch campaigns.
- Swap a whole family of embeds (e.g. change the CRM vendor) by editing one bundle's markup.
