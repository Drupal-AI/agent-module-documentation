<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CaptchEtat (with CAPTCHA) plugs the French government's official CaptchEtat challenge into Drupal's CAPTCHA module, as a state-operated, accessibility-focused alternative to reCAPTCHA.

---

Install it with Composer (`composer require drupal/captcha_captchetat`) and enable it alongside its required dependency, the **CAPTCHA** module. Before it can do anything you must complete the CaptchEtat authorization ("habilitation") process at api.gouv.fr — the service is reserved for French public entities and inter-ministerial partners — and obtain a `client_id` and `client_secret` from the PISTE "Applications" area. Enter those, together with the fixed scope `piste.captchetat`, on the settings form at **Administration › Configuration › People › CAPTCHA › CaptchEtat** (`/admin/config/people/captcha/captchetat`); a sandbox toggle lets you point at the test hosts first, and a **Type** radio chooses the challenge style (visual or audio; alphabetic, numeric, or alphanumeric; 4 to 12 characters, French or English). A second **Texts** tab customises the messages shown when the service is unavailable or when a visitor hits the per-IP rate limit. Configuring credentials does not protect any form on its own — as with any CAPTCHA type you then assign the **CaptchEtat** challenge to specific forms from the CAPTCHA module's own admin pages (default challenge or per-form CAPTCHA points). At runtime the challenge image or sound is fetched through the site's own `/captchetat/object` endpoint, and each submission is verified server-side against the CaptchEtat API, so a code is accepted only if the government service confirms it. If the credentials are missing or the API healthcheck fails, the module quietly falls back to the CAPTCHA module's built-in Math challenge, and the status report flags the API as unreachable.

---

- Add a French government CAPTCHA to forms on a public-sector site.
- Use a state-operated challenge instead of Google reCAPTCHA.
- Avoid sending visitor data to a third-party advertising provider.
- Meet French accessibility (RGAA) expectations for CAPTCHAs.
- Offer an audio CAPTCHA alternative to the visual one.
- Support French and English challenge text.
- Choose an alphabetic, numeric, or alphanumeric challenge.
- Choose a challenge length from 4 up to 12 characters.
- Protect native Drupal forms, Webforms, and custom forms.
- Enter CaptchEtat OAuth client_id and client_secret in the admin UI.
- Test against the CaptchEtat sandbox before going live.
- Customise the "service unavailable" message shown to users.
- Customise the rate-limit message shown to users.
- Rate-limit challenge generation per IP address.
- Tune the flood IP limit and time window from configuration.
- Verify each submitted code server-side against the government API.
- Fall back automatically to the Math CAPTCHA when credentials are missing.
- Surface a CaptchEtat healthcheck in the Drupal status report.
- Restrict administration to trusted users via a dedicated permission.
- Translate the settings and texts with config translation.
- Migrate an existing CaptchEtat v1 authorization to this v2 module.
