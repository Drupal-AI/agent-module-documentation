<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protect Form Flood Control applies Drupal's core flood service to any form, blocking a client that submits a chosen form more than a threshold number of times within a time window.

---

The module alters every form (`hook_form_alter`) and, when a form is "protected", attaches a validate callback that consults core's `flood` service: it blocks submission with an error once the client has submitted that form more than `threshold` times in `window` seconds, otherwise it registers the submission. All behavior comes from one config object, `protect_form_flood_control.settings`. You can protect **all** forms (`general.protect_all`) with an unprotected-ID exclusion list, or protect only an explicit list of form IDs (`general.protected_ids`), plus per-form overrides in `forms` that set their own window/threshold. Form IDs and base form IDs are matched with the path matcher, so wildcards (e.g. `webform_submission_*`) work. Core `system_*`, `search_*` and `views_exposed_form_*` forms are never protected, and the module's own settings form is exempt. A whitelist of IP addresses and a `bypass protect form flood control` permission skip protection entirely; an optional log records blocked submissions, and a `show_ids` debug mode prints each form's ID to privileged users so admins can discover the IDs to configure.

---

- Throttle a contact form so a bot cannot submit it hundreds of times an hour.
- Limit a user registration form to a few attempts per window to curb spam signups.
- Rate-limit a webform (using a wildcard like `webform_submission_*`) across all its instances.
- Protect a "request password" or login form against rapid repeated submissions.
- Protect every form on the site at once with `protect_all`, then exclude a few via the unprotected list.
- Set a global default window/threshold and override them for a specific high-risk form.
- Whitelist your office IP so staff testing forms are never blocked.
- Give trusted roles the `bypass protect form flood control` permission to skip limits.
- Discover unfamiliar form IDs by enabling the "show form IDs" debug mode for admins.
- Log blocked submissions to watchdog to monitor abuse patterns and tune thresholds.
- Add a per-form rule that allows only 3 submissions per hour on a newsletter signup.
- Stop a comment form from being flooded by anonymous users.
- Apply different limits to different forms via the individual form configurations list.
- Protect a survey form from ballot-stuffing by the same client.
- Rate-limit an AJAX-driven form by matching its base form ID.
- Exclude search and exposed-filter forms automatically (built-in system-form exemption).
- Enforce a 24-hour window with a 50-submission threshold as a conservative site-wide default.
- Prevent brute-force guessing on a coupon/redeem form by capping attempts.
- Provide lightweight abuse protection without a CAPTCHA on low-risk forms.
- Combine an IP whitelist with a strict global limit for a members-only site.
- Tune the message shown to a blocked user (threshold and human-readable window interval).
- Protect custom module forms by adding their form IDs to the protected list.
- Roll out protection gradually by listing individual form IDs before switching to protect-all.
