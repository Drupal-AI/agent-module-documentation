CAPTCHA After hides the CAPTCHA on a protected form until a configured submission threshold is crossed, then reveals and enforces it.

---

CAPTCHA After is an add-on to the CAPTCHA module that delays the CAPTCHA challenge on a form until Drupal's flood counters exceed an admin-defined threshold. On a form that already has a CAPTCHA point, it starts the CAPTCHA element hidden and only makes it visible (and required) once one of five thresholds is reached within a rolling one-hour window: an invalid-submit threshold and a flooding (all-submits) threshold, each available at hostname/IP, session, or global (all-visitors) scope. This keeps forms frictionless for legitimate users while still throttling automated or repeated abuse. Global defaults live in the config object `captcha_after.settings` (route `captcha_after.settings`, path `/admin/config/people/captcha_after`); per-CAPTCHA-point overrides are stored as third-party settings on each `captcha_point` entity and edited on the CAPTCHA module's Form settings tab. A threshold of `0` disables that check; an empty per-point value falls back to the module default. On a successful (error-free) submission the IP and session invalid-submit counters for that form are cleared, so genuine users reset their own count.

---

- Show a CAPTCHA on the user login form only after several failed login attempts from the same IP.
- Keep the standard login form CAPTCHA-free for the first N tries, then require a challenge on further attempts within the hour.
- Throttle password-reset request abuse by revealing a CAPTCHA after a number of invalid submissions.
- Protect a contact form from repeated spam while letting first-time senders submit without a CAPTCHA.
- Add a session-scoped threshold so a single browser session gets challenged after a few bad submissions regardless of IP changes.
- Add a hostname/IP-scoped threshold so all requests from one address share a counter.
- Add a global (all-visitors) threshold to catch distributed abuse coming from many IPs at once.
- Use a flooding threshold to challenge after a number of successful submissions of a form (e.g. limit valid comment posts per hour per IP).
- Use a global flooding threshold to detect form flooding spread across many IP addresses.
- Set different thresholds per form: strict on login, looser on a newsletter signup.
- Set a module-wide default threshold once, then leave individual forms on the default by clearing their per-point value.
- Disable CAPTCHA-After behavior on a specific form (revert to always-on CAPTCHA) by setting all of its thresholds to 0.
- Combine invalid-submit and flooding thresholds on the same form so either condition can trigger the challenge.
- Reduce CAPTCHA fatigue on high-traffic public forms by only challenging suspected abuse.
- Pair with the CAPTCHA module's per-role "skip CAPTCHA" permission so trusted roles are never challenged.
- Tune the "suspicious" definition per form using the five independent thresholds (submit, session submit, global submit, flooding, global flooding).
- Let a legitimate user who mistypes once or twice still submit without a challenge, since counters clear on success.
- Apply bot protection to any form that supports a CAPTCHA point (webforms, comment forms, custom module forms, node forms).
- Stage rollout by enabling thresholds on one form first and expanding once tuned.
- Keep the challenge window short (counters expire after one hour) so occasional users are rarely affected.
