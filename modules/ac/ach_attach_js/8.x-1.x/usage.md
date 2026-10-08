Provides a Drupal asset library that re-runs `Drupal.attachBehaviors()` on content injected into the page asynchronously by Acquia Content Hub / Acquia Lift.

---

ACH Attach JS solves a specific Acquia Lift + Content Hub integration gap: when Lift places personalized content into a decision slot after the page has loaded, that markup is inserted into the DOM without Drupal's JavaScript behaviors ever being attached to it, so interactive features (tabs, drawers, save flags, sliders, etc.) inside that content stay dead. The parent module registers a small library (`ach_attach_js/ach-attach-js`) that listens for Lift's `acquiaLiftContentAvailable` browser event and calls `Drupal.attachBehaviors()` on the matching `[data-lift-slot]` element, so any behavior-driven JS runs on the freshly injected markup. The bundled sub-module, ACH Attach JS Attacher, adds an admin form that attaches the library on the paths you choose (using core's Request Path visibility condition, just like block placement); alternatively you attach the library yourself from a theme, preprocess function, or Twig template. The project is Acquia-specific, unsupported/obsolete upstream (the maintainer has not worked with Lift since 2019), and not covered by Drupal's security advisory policy.

---

- Re-run Drupal behaviors on Acquia Lift personalized content that is injected after the initial page load.
- Make JS-driven widgets (tabs, accordions, drawers) work inside content delivered from Acquia Content Hub via Lift.
- Bind flag/save/favorite buttons rendered inside a Lift decision slot so their JavaScript actually initializes.
- Initialize sliders/carousels or lightboxes that appear only inside Lift-injected markup.
- Hook up form behaviors (autocomplete, AJAX, validation) on forms that Lift drops into a slot.
- Attach analytics or click-tracking behaviors to personalized content added by Content Hub.
- Enable third-party or contrib module JS (behaviors) to run on asynchronously personalized regions.
- Listen for the `acquiaLiftContentAvailable` event without writing custom JS in your theme.
- Scope behavior attachment precisely to the `[data-lift-slot="<decision_slot_id>"]` element that Lift updated.
- Attach the helper library site-wide by adding `ach_attach_js/ach-attach-js` to your theme's `.info.yml` libraries.
- Attach the library from a `hook_preprocess_HOOK()` or `#attached['library']` in custom code.
- Attach the library from a Twig template with `{{ attach_library('ach_attach_js/ach-attach-js') }}`.
- Use the Attacher sub-module to attach the library only on specific paths (e.g. landing pages that use Lift).
- Exclude admin pages from library attachment using the Attacher's default negated `/admin`, `/admin/*` request-path config.
- Configure attachment paths through a familiar block-style Request Path condition UI at `/admin/config/ach_attach_js`.
- Restrict who can change the attachment paths via the dedicated `administer ach_attach_js_attacher` permission.
- Ship attachment paths as exported configuration (`ach_attach_js_attacher.settings`) for deployment across environments.
- Provide the same behavior-reattachment fix across Drupal 9.2, 10, and 11 sites running Acquia Lift.
- Serve as a lightweight, dependency-free (core-only) building block for Acquia personalization front ends.
- Reference implementation for how to react to Acquia Lift/Personalization JavaScript events in Drupal.
- Avoid custom per-project JavaScript by centralizing the Lift-event-to-attachBehaviors bridge in one library.
