<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Spamicide is a lightweight honeypot anti-spam module: it adds a CSS-hidden text field ("feed me") to selected forms, and silently rejects any submission where that field is filled in — which bots do and humans do not.

---

Spamicide defines a `spamicide` config entity, one per protected form, keyed by `spamicide_form_id`. `hook_form_alter` looks up an enabled `spamicide` entity matching the current `$form_id`; when found it injects a hidden `feed_me` textfield (weighted to the bottom) and a `spamicide_validate` validation handler, and attaches the `spamicide/spamicide` library whose tiny CSS hides the field (`visibility:hidden;height:0`). On submit, `spamicide_validate` checks `feed_me`: if non-empty it sets a form error, optionally logs the attempt (form id + client IP) to watchdog and increments a counter, then redirects back to the current page (or the front page for the login form) — the spammer gets no useful feedback. On install (`spamicide_install`) it auto-creates protections for core `contact_message_feedback_form`, `contact_message_personal_form`, `user_register_form`, `user_login_form` and `comment_comment_form`. Admins manage protections at `admin/structure/spamicide` (collection + add/edit/delete forms, `configure` = `entity.spamicide.collection`, permission `administer spamicide`) and can enable an "admin mode" (`spamicide_admin_mode`) that adds a convenience "Add spamicide to this form" link on forms that don't yet have protection (for users with `administer spamicide`, excluding search/admin-structure forms). Settings (`spamicide.settings`): `spamicide_admin_mode`, `spamicide_log_attempts`, `spamicide_counter`. The honeypot field name is fixed as `feed_me` in this release. No dependencies, plugins, or Drush.

---

- Block automated spam on the site-wide contact form.
- Block spam on the personal (user-to-user) contact form.
- Reduce bogus user registrations by protecting the register form.
- Stop credential-stuffing bots that auto-submit the login form.
- Cut comment spam by protecting the default comment form.
- Add honeypot protection to any custom or contrib module's form by its form id.
- Protect a webform or newsletter-signup form from bot submissions.
- Silently reject bot submissions with no CAPTCHA and no user friction.
- Add anti-spam without external services, large tables, or third-party calls.
- Log spam attempts (with attacker IP) to watchdog for monitoring.
- Track a running counter of blocked spam submissions.
- Enable "admin mode" to get one-click "protect this form" links while browsing forms.
- Selectively enable/disable protection per form via the `status` flag on each entity.
- Remove protection from a form you no longer want covered (delete its spamicide entity).
- Keep protection config portable (config entities, exportable with the site's config).
- Combine with other spam tools (Honeypot/CAPTCHA) for layered defense.
- Protect an event/RSVP form from automated signups.
- Guard a "request a quote" or lead-gen form against bot floods.
- Provide accessible spam protection (no puzzle to solve for real users/screen readers).
- Restrict who can manage spamicide protections via the `administer spamicide` permission.
