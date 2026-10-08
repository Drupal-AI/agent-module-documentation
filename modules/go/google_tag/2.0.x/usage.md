Google Tag adds Google Tag (gtag.js) and Google Tag Manager (GTM) snippets to your site through configurable tag "container" entities, and can push structured events — including Commerce, Webform and Search API events — into the dataLayer.

---

Google Tag manages one or more **tag container** config entities, each holding one or more Google tag IDs (GA4 `G-…`, Google Ads `AW-…`, GTM `GTM-…`, etc.) and the rules for when they load. A response event subscriber injects the correct `gtag.js` or `gtm.js` snippet into matching responses, resolving which container applies via visibility **conditions** (request path, response code, and other Condition plugins). Beyond page-view tracking, the module defines a `GoogleTagEvent` plugin type: each plugin emits a named analytics event (login, sign_up, search, generate_lead, custom events) whose data is collected server-side and flushed to the browser's dataLayer, with token replacement and configurable custom **dimensions and metrics**. Bundled event plugins integrate with Commerce (add_to_cart, begin_checkout, purchase, refund, view_item, wishlist…), Webform (purchase/conversion), and Search API, activated automatically when those modules are present. Global behavior — whether multiple containers are allowed and the default container — is set at **Admin → Configuration → Services → Google Tag → Settings**, while each container is edited under the same path. Configuration is exportable, there is Content-Security-Policy integration for nonces, and an upgrade path migrates from the Google Analytics module. Access is gated by the `administer google_tag_container` permission.

---

- Add a GA4 (`G-…`) tag to the whole site without editing templates.
- Install a Google Tag Manager (`GTM-…`) container snippet.
- Track multiple Google Ads / GA properties from one container.
- Run several tag containers and choose which applies where.
- Load a tag only on specific paths using request-path conditions.
- Exclude admin pages or 403/404 responses from tracking.
- Fire a GA4 `login` event when users authenticate.
- Fire a `sign_up` event on successful registration.
- Emit a `search` event from Search API queries.
- Track a `generate_lead` conversion event.
- Define arbitrary custom events pushed to the dataLayer.
- Track Commerce `add_to_cart` / `remove_from_cart` events.
- Emit `begin_checkout` and `add_payment_info` during checkout.
- Send `purchase` and `refund` ecommerce events with order data.
- Track `view_item` and `view_item_list` on product pages.
- Record add-to-wishlist events with Commerce Wishlist.
- Send a purchase/conversion event from a Webform submission.
- Attach custom dimensions and metrics with token-replaced values.
- Use tokens to populate event parameters from the current entity/route.
- Add a nonce to injected tags for Content-Security-Policy compliance.
- Enable/disable a container without deleting it.
- Export tag configuration and deploy it across environments.
- Migrate settings from the older Google Analytics module.
- Restrict tag administration to trusted roles via permission.
- Implement a custom `GoogleTagEvent` plugin for a bespoke conversion.
- Set a site-wide default container and allow or forbid multiple containers.
