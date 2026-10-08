Klaro integrates the open-source Klaro! JavaScript consent manager into Drupal, showing a GDPR-style cookie/consent banner and blocking third-party services (analytics, maps, embeds, social) until the visitor opts in.

---

Klaro models consent as two config-entity types: **Services** (`klaro_app` — a script or third-party integration, e.g. Matomo, Google Analytics, YouTube, Leaflet) grouped under **Purposes** (`klaro_purpose` — categories such as analytics, advertising, external content). It ships ready-made service and purpose definitions for many common tools and adds the Klaro! banner/modal to every page via `hook_page_attachments`. External assets are held back until consent is given: the module's `hook_js_alter`/`hook_library_info_alter`/`hook_page_attachments_alter` rewrite matching script and library tags, and a text filter (`klaro_filter`, "Decorate external sources") wraps iframes and embeds so they only load after the user accepts the relevant service. A settings form (`klaro.admin`) controls global behavior (styling, default state, testing mode, cookie name/expiry) and a separate text-settings form manages all the banner/modal copy for translation. Everything is configuration, so consent setup is exportable and deployable, and the module includes a recipe for Google Consent Mode. Two permissions separate administering Klaro from end-users re-opening the consent UI. It is a privacy/compliance building block for sites that must gate tracking and embeds behind explicit consent.

---

- Show a GDPR/ePrivacy cookie-consent banner on every page.
- Block Google Analytics or Matomo until the visitor opts in.
- Gate YouTube/Vimeo embeds behind consent with a click-to-load placeholder.
- Require consent before loading Google Maps or Leaflet maps.
- Group tracking, advertising, and external-content services into purposes.
- Let visitors accept or decline individual services, not just all-or-nothing.
- Re-open the consent modal from a "Cookie settings" link or menu item.
- Use the "Decorate external sources" text filter to gate iframes in body content.
- Define a custom third-party service as a `klaro_app` config entity.
- Configure default opt-in/opt-out state per service.
- Deploy consent configuration across environments as exportable config.
- Translate all banner and modal text via the dedicated text-settings form.
- Enable Google Consent Mode using the bundled recipe.
- Style the consent widget to match the site theme.
- Set the consent cookie name and expiry period.
- Run Klaro in a testing/preview mode while building the site.
- Restrict who can administer consent settings with a dedicated permission.
- Provide a required "security/essential" purpose that cannot be declined.
- Show contextual consent (per-embed) only where an external service appears.
- Add an info URL/privacy-policy link to each service description.
- Comply with cookie laws without hand-writing consent JavaScript.
- Integrate consent with Google Tag Manager containers.
- Prevent social widgets (X, Facebook, LinkedIn, Instagram) from loading pre-consent.
- Offer a per-purpose toggle so analytics and advertising are consented separately.
- Automatically re-prompt visitors when the consent configuration changes.
