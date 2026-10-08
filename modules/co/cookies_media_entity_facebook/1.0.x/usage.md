<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
COOKiES Media Entity Facebook brings media_entity_facebook Facebook embeds under COOKiES consent management, so they only load after the visitor accepts Facebook cookies.

---

COOKiES Media Entity Facebook is a small glue submodule of the COOKiES consent framework. It registers a COOKiES service config entity named `facebook` and defers the Facebook embed script rendered by the media_entity_facebook module until the visitor grants consent for that service. On page render it rewrites the embed `<script>` to `type="text/plain"` with a `data-sid="facebook"` marker (via `hook_preprocess_media_entity_facebook`) so the browser will not execute it, and it attaches its JavaScript library only when the COOKiES knock-out mode is active. Client-side, its behavior listens for the `cookiesjsrUserConsent` event: on consent it clones each blocked script back to an executable `<script>`; without consent it renders a COOKiES placeholder/overlay over `.facebook-embedded-content`. It provides no routes, permissions, PHP classes, or admin settings form of its own — configuration happens through the COOKiES service entity and the media_entity_facebook module.

It depends on `cookies` and `media_entity_facebook` (`^4.0`), targets Drupal 9.3+, 10, and 11, and sets its module weight to 11 on install so it loads after the third-party integration.

---

- Gate Facebook media embeds behind cookie consent for GDPR/ePrivacy compliance.
- Register a COOKiES `facebook` service (group `social`, `consentRequired: true`).
- Block the media_entity_facebook embed script from running before consent.
- Rewrite the embed `<script>` to `type="text/plain"` with `data-sid="facebook"` so the browser skips it.
- Re-activate blocked Facebook scripts client-side once the visitor accepts.
- Show a COOKiES placeholder overlay in place of blocked Facebook content.
- Present the "This content is blocked because Facebook cookies have not been accepted" placeholder text.
- Offer an "Only accept Facebook cookies" per-service accept button.
- Listen to the `cookiesjsrUserConsent` browser event to activate or fall back.
- Take over the media_entity_facebook `facebookMediaEntity` attach behavior so it only runs after consent.
- Attach the module's JS/CSS library only when COOKiES knock-out mode is active.
- Link visitors to Facebook's cookie policy from the consent service definition.
- Keep third-party Facebook tracking off pages until explicit opt-in.
- Integrate cleanly with an existing COOKiES banner/consent UI.
- Enforce the module as a config dependency of the `facebook` COOKiES service (update 8001).
- Load after the third-party integration via module weight 11.
- Support editorial workflows that embed Facebook posts/videos as media entities.
- Provide a consent-managed alternative to loading Facebook's SDK unconditionally.
- Cover Drupal 9.3, 10, and 11 sites.
- Work with no additional PHP configuration once enabled.
