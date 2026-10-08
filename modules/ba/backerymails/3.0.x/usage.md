<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backery Mails intercepts every message going out through Drupal's `MailManagerInterface` and saves a copy as a `backerymails_entity`, then exposes a Views-driven list so administrators can read what the site actually sent.

Use it to debug transactional email, audit notifications, or keep a searchable archive of outgoing mail during development and QA.

---

Install with `composer require drupal/backerymails` and enable it (`drush en backerymails`). It depends on core `views` and the contrib `mailsystem` module.

Point the desired mail plugins at Backery Mails through the Mail System settings (it registers as a mail plugin/formatter), then browse captured mail at `/admin/config/backerymails/mails`. All admin routes require the `administer backerymails` permission; individual mail entities use an entity access handler.

Configure behavior at `/admin/config/backerymails/settings`, and purge the archive from `/admin/config/backerymails/clear`.

---

- Capture every email sent through Drupal's MailManager.
- Store each outgoing message as a `backerymails_entity` content entity.
- Provide a Views-based collection page listing archived mail.
- Show full message detail (subject, body, headers, recipients) per entry.
- Gate all administration behind the `administer backerymails` permission.
- Enforce per-entity view access through a dedicated access-control handler.
- Offer a settings form to control capture behavior.
- Provide a "Clear" form to purge all stored mail at once.
- Integrate with the contrib Mail System module as a mail plugin.
- Help debug transactional and notification emails during development.
- Act as an audit trail of what the site emailed and to whom.
- Let editors verify mail content without a real inbox.
- Expose mail data to Views for custom reports and filters.
- Support Drupal 9.5 and Drupal 10.
- Avoid changing how mail is actually delivered (it observes, then forwards).
- Keep archived mail queryable via the entity/Views API.
- Provide an admin menu block at `/admin/config/backerymails`.