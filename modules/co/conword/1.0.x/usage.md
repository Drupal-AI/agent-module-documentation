Conword integrates the DeepL-based Conword on-page translation widget from Conword GmbH into a Drupal site by attaching the vendor's external JavaScript and controlling where it appears.

---

The module is a lightweight front-end integration for the proprietary Conword translation service (which requires a paid contract and a customer ID from Conword GmbH). On front-end page requests it evaluates a set of Drupal condition plugins (visibility rules), and when active it attaches the vendor script loaded from `https://static.conword.io/js/v2/{customer_id}/conword.js` and forwards two display flags (`disable_language_switcher`, `disable_rtl_attribute`) to it through `drupalSettings.conword.conwordConfig`. Configuration is a single config form at `/admin/config/services/conword` (permission `administer conword`) writing the `conword.settings` config object. The vendor script normally renders its own language switcher; the module also ships an optional replacement UI — a `conword` block plugin with a Twig template (`conword.html.twig`) and `conword_ui` library that draw a popover language picker using the vendor JavaScript API (`Conword.get_available_languages()`, `Conword.get_current_language()`, `Conword.translate()`). That block only becomes accessible when the "Disable language switcher" flag is enabled.

---

- Add DeepL-powered, on-page machine translation to a Drupal site without building a custom integration.
- Connect a Drupal site to a Conword GmbH translation contract by entering the customer ID at `/admin/config/services/conword`.
- Load the Conword vendor widget (`static.conword.io/js/v2/{customer_id}/conword.js`) automatically on front-end pages.
- Offer visitors an on-the-fly translation switcher for any language Conword supports.
- Restrict the widget to specific paths using the request-path visibility condition (default config hides it on `/admin`, `/admin/*`, `/batch`, entity-browser, media, node-add, node edit, and user pages).
- Show the widget only on selected content types via the `entity_bundle:node` condition.
- Limit widget display to particular user roles with the `user_role` condition.
- Enable the widget only for specific languages once the site is multilingual (the `language` condition appears only when multiple languages exist).
- Scope the widget by response status (e.g. exclude 403/404 pages) using the `response_status` condition.
- Combine multiple visibility conditions to precisely control where translation is offered.
- Disable Conword's built-in language switcher (`disable_language_switcher`) so you can use the module's own block-based picker instead.
- Turn off the widget's right-to-left attribute handling (`disable_rtl_attribute`) when it conflicts with a theme.
- Place the module's custom language-picker block (admin label "Conword") in a region for a themed, accessible popover switcher.
- Provide an accessible translation control with ARIA labels and a native `popover` modal for choosing a language.
- Render a per-language list ("Native name | English name") with the currently active language highlighted.
- Show visitors a standing "Automatic translation, no guarantee of accuracy" notice alongside the picker.
- Ship a strict Content-Security-Policy-friendly setup by installing the suggested `drupal/csp` module.
- Manage all Conword settings through Drupal configuration management (exportable `conword.settings` config object).
- Delegate widget administration to a non-superuser by granting the `administer conword` permission.
- Keep translation entirely client-side (the vendor script runs in the browser; Drupal only supplies the customer ID and display flags).
- Reuse Drupal's core condition-plugin system for visibility instead of a bespoke rules engine.
- Localize the picker's interface strings through Drupal's translation system (all UI strings pass through `t()`).
