<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Webform places a webform as a block on YMCA Layout Builder pages.

---

Location pages end in a form more often than not — a membership enquiry, a programme registration, a contact request — and placing it as a block means the page keeps its structure while the form stays a Webform with all its fields, validation, handlers and access intact.

Two things to check on any placed webform. The form's **own access settings still apply**, so a form restricted to authenticated users placed on a public page simply will not render for anonymous visitors, and the symptom is an empty region rather than an error. And a form on a public page **will be found by bots**, so whatever CAPTCHA or honeypot the site uses has to apply to it — a location page form collecting names and phone numbers is exactly what gets harvested.

Worth noting that a webform on a location page usually collects personal data, which makes retention and submission-access decisions part of placing it rather than an afterthought.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from 2022**, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add.

Modules in this family that require `y_lb` **without a version constraint** install cleanly and then fail at enable time with *"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* Modules that **do** constrain it — `ws_event` requires `^4.0 || ^5.0` — fail earlier and more usefully, at composer time with a resolvable explanation. The stricter-looking module behaves better.

Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Place an enquiry form on a location page.
- Add a programme registration form.
- Reuse an existing webform in a layout.
- Keep webform handlers and validation intact.
- Check the webform's access settings.
- Diagnose a form that does not render.
- Apply spam protection to a public form.
- Protect harvested contact details.
- Set a retention period for submissions.
- Restrict who can read submissions.
- Add the YMCA composer repository.
- Diagnose a y_lb core incompatibility.
- Track submissions per location.
- Audit forms collecting personal data.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
