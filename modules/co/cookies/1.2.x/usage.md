COOKiES is a GDPR consent-management framework: it shows a configurable consent banner and blocks third-party scripts/services until the visitor grants consent for the matching category. Each 3rd-party integration (Google Analytics, Matomo, Facebook Pixel, etc.) is a separate `cookies_*` submodule you enable.

---

COOKiES ships the vanilla-JS `cookiesjsr` library (Composer dep `jfeltkamp/cookiesjsr`) and renders its banner through the **COOKiES UI** block (`cookies_ui_block`), which you place via the core Block layout. Consent is organised into **service groups** (config entity `cookies_service_group`: functional, performance, marketing, tracking, social, video) and individual **services** (config entity `cookies_service`) that belong to a group and describe one data processor for the GDPR documentation. The heart of the framework is the *knock-out* pattern: an integration submodule rewrites its third-party `<script>` to `type="text/plain"` and tags it `data-cookieconsent="<group>"` so the browser never executes it; when the user consents, JavaScript swaps it back to a live script. Server-side, `Drupal::service('cookies.knock_out')->doKnockOut()` tells a bridge module whether to knock scripts out on the current page (true only when a COOKiES UI block is actually visible). A small JS event API — dispatch `cookiesjsrSetService` to grant/deny, listen for `cookiesjsrUserConsent` to react — drives everything client-side; a `/cookies/consent/callback.json` endpoint fires `hook_cookies_user_consent()` server-side. Admins configure base behaviour at **Admin → Config → System → COOKiES** (`/admin/config/system/cookies/config`), edit banner texts, and manage service/service-group entities. Because it is fully config-translatable it can produce per-language cookie documentation (as a page, the COOKiES Docs block, or the `[cookies:docs]` token). Styling is themeable via CSS variables or by disabling the bundled CSS. The ~11 per-service `cookies_*` submodules are the ready-made bridges you enable for popular tools; each is a thin integration, not a separate product.

---

- Show a GDPR-compliant cookie consent banner on a Drupal site by placing the COOKiES UI block.
- Block Google Analytics from loading until the visitor accepts the analytics/performance category.
- Group consent choices into functional, performance, marketing, tracking, social and video categories.
- Define a `cookies_service` config entity to gate any custom third-party script behind a consent category.
- Let visitors re-open the consent dialog from a footer link targeting `#editCookieSettings`.
- Enable the `cookies_ga` submodule to manage Google Analytics consent out of the box.
- Enable `cookies_matomo`, `cookies_gtag`, `cookies_facebook_pixel` etc. for other trackers.
- Gate embedded YouTube/Vimeo videos with a placeholder overlay until consent (`cookies_video`).
- Gate Instagram or Twitter/X media embeds until the social category is accepted (`cookies_instagram`, `cookies_twitter_media`).
- Gate reCAPTCHA until consent is granted (`cookies_recaptcha`).
- Block arbitrary injected CSS/JS snippets via the Asset Injector bridge (`cookies_asset_injector`).
- Gate content behind a text-format filter until consent (`cookies_filter`).
- Show a per-service "accept only this service" button on a blocked element's placeholder overlay.
- Offer a single "Accept all" / "Deny all" choice on the banner.
- Produce translatable cookie/privacy documentation per service for the GDPR imprint.
- Embed that documentation as a page, the COOKiES Docs block, or the `[cookies:docs]` token.
- Configure the consent cookie name, lifetime, domain, SameSite and Secure flags.
- Switch between per-service and per-group consent (`group_consent`).
- Load the cookiesjsr library from a CDN or locally (`lib_load_from_cdn`).
- React to consent changes in custom JS by listening for the `cookiesjsrUserConsent` event.
- Programmatically grant/deny a service from JS by dispatching `cookiesjsrSetService`.
- Decide in a custom bridge module whether to knock scripts out via `cookies.knock_out` service.
- Respond to a consent submission server-side with `hook_cookies_user_consent()`.
- Store consent decisions for authenticated users (`store_auth_user_consent`).
- Restyle the banner using CSS variables, or disable bundled styles and start from scratch.
- Gate who can configure base settings, widget texts, and service entities via three permissions.
- Deploy the whole consent configuration (services, groups, texts) between environments as config.
- Build a custom integration for any un-bridged third-party tool by copying a `cookies_*` submodule.
