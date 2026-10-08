reCAPTCHA v3 integrates Google's score-based reCAPTCHA v3 with Drupal's CAPTCHA module, protecting forms invisibly by scoring how likely each submission is a bot instead of showing a challenge.

---

Unlike checkbox or image CAPTCHAs, Google reCAPTCHA v3 runs in the background and returns a score from 0.0 (bot) to 1.0 (human) for each interaction. This module plugs that into the CAPTCHA module so any protected form runs a v3 verification on submit. You configure your site key and secret key on the settings page (`/admin/config/people/captcha/recaptcha-v3`), then create one or more **reCAPTCHA v3 action** config entities — each defines a Google "action" name, a score **threshold**, and a **fallback challenge** to present when a submission scores below the threshold (for example fall back to a math or image CAPTCHA). Because scoring is invisible, legitimate users usually never see a challenge. Options include hiding the reCAPTCHA badge (with an alternative attribution notice), verifying the response hostname, making the CAPTCHA cacheable, and loading the library from recaptcha.net instead of google.com for regions where Google is blocked. Actions are exportable configuration and are assigned to specific forms through CAPTCHA's normal per-form points UI. It requires the CAPTCHA module and the `google/recaptcha` PHP library.

---

- Protect the user login form from credential-stuffing bots invisibly.
- Guard the user registration form against automated sign-ups.
- Stop spam on the contact form without annoying real users.
- Add invisible bot protection to comment forms.
- Score newsletter/subscription signups and block low-score bots.
- Fall back to a math CAPTCHA when a submission looks suspicious.
- Fall back to an image CAPTCHA below a chosen score threshold.
- Tune the threshold per form (stricter on login, looser on search).
- Create distinct reCAPTCHA actions for login, register, and contact.
- Hide the reCAPTCHA badge and show a custom attribution notice instead.
- Verify the response hostname to prevent token reuse from other domains.
- Load the reCAPTCHA library from recaptcha.net where google.com is blocked.
- Make the CAPTCHA cacheable so it works with page caching.
- Replace an old image-CAPTCHA on a webform with invisible scoring.
- Protect a Webform submission with a per-form reCAPTCHA v3 action.
- Set a custom error message shown when verification fails.
- Deploy reCAPTCHA action configuration between environments as config.
- Reduce friction on high-traffic public forms while keeping spam out.
- Combine with the CAPTCHA module's per-form points to protect any form.
- Monitor and adjust thresholds based on observed spam scores.
- Provide bot protection on password-reset request forms.
- Protect a "report abuse" or feedback form from automated flooding.
