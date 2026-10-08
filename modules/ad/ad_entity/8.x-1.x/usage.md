Advertising Entity is a framework for consolidated ad management: it defines Ad and Display config entities plus AdType/AdView/AdContext plugin types, and renders provider ad tags into pages via blocks, fields and a canonical/iFrame view.

---

Advertising Entity separates *what* an ad is (a config entity bound to a provider AdType plugin such as DFP or AdTech and an AdView handler that decides the container: HTML, iFrame, FIA or AMP) from *where* it shows (a Display config that maps Ad entities to theme breakpoints and is placeable as a block). Targeting/context data is attached in one provider-agnostic way through an "Advertising context" field type (targeting, turn-off) or site-wide settings, collected server-side by an AdContextManager and emitted as JSON alongside each ad container for the provider's client-side library to consume. The module itself provides no provider — you enable a submodule (ad_entity_dfp, ad_entity_adtech_v2, ad_entity_generic, …). It also centralises consent-aware personalization (opt-in/opt-out cookie checks, EU Cookie Compliance / OIL.js integration) so ad scripts can respect tracking consent. Creating and configuring ads is restricted to the `administer ad_entity` permission; two separate view permissions gate whether ads and displays render for a role.

---

- Manage ads from several providers in one admin UI at `/admin/structure/ad_entity`.
- Define an Ad entity by picking a provider AdType plugin and an AdView handler.
- Swap an ad's provider/type later without losing its targeting context.
- Create Display configs that map ads to theme breakpoints and place them as blocks.
- Render an ad as a plain HTML container for normal pages.
- Render an ad as a self-contained iFrame for feeds or external embedding.
- Render an ad for Facebook Instant Articles (FIA) or AMP (AMP via the DFP submodule).
- Attach an "Advertising context" field to nodes/terms to add per-content targeting.
- Turn ads off on specific content using the turn-off context plugin.
- Add site-wide targeting/context in the global settings form.
- Include elementary entity info (type, label, uuid) as targeting automatically.
- Aggregate taxonomy-tree targeting from a node's referenced terms.
- Configure consent-aware personalization (opt-in / opt-out / disabled / unbiased).
- Bind consent to a cookie set by EU Cookie Compliance, the Consent module or OIL.js.
- Respect theme breakpoints for responsive ad initialization via Theme Breakpoints JS.
- Preload the Google Publisher Tag library for faster ad loading.
- Restrict who may view ads with the "View Advertising entities / Display configs" permissions.
- Keep ad administration limited to the `administer ad_entity` permission.
- Extend the framework by writing your own AdType, AdView or AdContext plugin.
- Provide site-wide default targeting per provider from the global settings.
- Reuse one Ad entity in multiple places/displays on a page.
- Serve different creative per breakpoint by creating one Ad entity per size.
