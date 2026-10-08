Honeypot mitigates spam form submissions using two invisible techniques — a hidden "honeypot" field that only bots fill in, and a minimum time-to-complete restriction — without ever showing a CAPTCHA to real users.

---

Honeypot adds anti-spam protection to Drupal forms with no user-visible friction. Its first defense is a hidden field (default machine name `url`) that is invisible to humans but that automated spam bots tend to fill in; any submission with that field populated is rejected. Its second defense is a time limit: a form submitted faster than a configurable threshold (default 5 seconds, with an exponential back-off for repeat offenders) is treated as a bot and rejected. You can protect all forms at once (`protect_all_forms`) or opt-in specific forms, and you can exclude forms (login, search, and exposed Views filters are excluded by default). Rejections can be logged to the Drupal log, and a `bypass honeypot protection` permission lets trusted roles skip it. Everything is configured at Admin → Configuration → Content authoring → Honeypot configuration. Developers can protect a custom form by calling the `honeypot` service's `addFormProtection()`, and can react to or tune behavior through alter hooks (`hook_honeypot_form_protections_alter`, `hook_honeypot_reject`, `hook_honeypot_time_limit`). It is a lightweight, widely used alternative or complement to CAPTCHA.

---

- Block spam bots on comment forms without a CAPTCHA.
- Protect contact forms from automated submissions.
- Stop spam registrations on the user register form.
- Guard newsletter/signup forms against bots.
- Protect Webform submissions from spam.
- Turn on protection for every form site-wide in one setting.
- Opt-in protection for only selected forms.
- Exclude the login or search form from protection.
- Reject submissions completed impossibly fast (time restriction).
- Increase the delay automatically for repeat offenders.
- Rename the hidden honeypot field to evade tuned bots.
- Log every rejected submission for monitoring.
- Let trusted editor roles bypass honeypot checks.
- Add spam protection to a custom module's form in code.
- Combine honeypot with CAPTCHA for layered defense.
- Reduce moderation workload from spam comments.
- Avoid accessibility problems that CAPTCHAs cause.
- Add extra time delay to forms frequently targeted by spammers (hook).
- Track how often a specific form is hit by bots (hook).
- Notify or act when a submission is rejected (hook).
- Tune the honeypot expiration/cleanup window via cron.
- Protect anonymous feedback forms on a marketing site.
- Cut down on junk leads reaching a CRM integration.
- Keep signup conversion high by not showing puzzles to humans.
