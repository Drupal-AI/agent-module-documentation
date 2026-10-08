<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Contact Form adds one field formatter, "Views Contact Form" (`views_contact_form_email_formatter`), for core `email` fields. Set it as the format of any email field on an entity display or Views field, and instead of printing the address it renders an inline core contact form that emails the field's address when submitted.

---

The module's entire installed surface in 2.0.x is a single field formatter plugin, `ViewsContactFormEmailFormatter`, that applies to `email` field types. When a display component uses this formatter, `viewElements()` collects the email value(s) from the field item list, clones the admin-selected contact form entity (any non-`personal` contact form, default `feedback`), overrides that clone's `recipients` with the collected email values (optionally merging in the contact form's own configured recipients when "Include contact form recipient(s)" is on), builds a transient `contact_message` entity bound to the cloned form, and renders core's `Drupal\contact\MessageForm` in the field's place. Because it reuses the real core message form, all core behavior is preserved: subject/message fields come from the chosen contact form's form-display, authenticated users get their name/mail locked, the "send yourself a copy" box is hidden for anonymous users, and core contact flood control (`contact.settings` flood limit/interval, checked in `MessageForm::validateForm()`) still throttles submissions site-wide. The formatter has two settings, `contact_type` (which contact form supplies the fields; the `personal` form is deliberately excluded from the options) and `contact_recipients_include` (boolean). It ships no config schema, no permissions, no Drush, no submodules, and an empty `.module`. Important operational caveats: the module requires the core Contact module at runtime but declares only `views` in its `info.yml`, so Contact must be enabled separately or the formatter fatals; the recipient address is taken verbatim from the field value; and multiple email values or multiple rows each render their own copy of the same-id form.

---

- Display a user-listing view where each row's `mail`/email field shows a contact form that emails that user, without exposing the address as a mailto: link.
- Replace a plain email field on a "Team" or "Staff" content type display with an inline "message this person" form.
- Build a Views page or block of profiles, each row offering a contact form routed to that profile's stored email.
- Show a contact form on a node display that emails an email field stored on the node (e.g. an "author contact" or "listing owner" address).
- Route messages to an email held on a referenced entity by adding that email field (via a relationship/reference) to a view and formatting it with this formatter.
- Offer a per-item "contact seller/organizer" form in a directory or classifieds listing keyed off each item's contact email.
- Present a contact form whose fields (subject, message, extra fields) are defined by a custom contact form's form-display, while the recipient is data-driven from the field.
- Send each submission both to the row's email value and to a fixed department mailbox by enabling "Include contact form recipient(s)".
- Provide a support-agent listing where visitors message the specific agent shown in the row.
- Add an inline enquiry form to an event display that emails the event's organizer address field.
- Turn an email field on a "Location"/"Branch" entity into a branch-specific contact form.
- Give a membership directory a message form per member that respects core contact flood limits.
- Use inside a block-display view to place a data-driven contact form in a sidebar or region.
- Reuse an existing custom contact form's category/auto-reply/redirect settings while overriding only the recipient per row.
- Let editors change who a form emails simply by editing the email field value, with no form or code changes.
- Provide a "contact the content author" form by exposing the author's email field on the node display (subject to field access).
- Build a vendor/supplier list where each row contacts the vendor's stored email.
- Show an inline contact form on a taxonomy-term or group display driven by a term/group email field.
- Present a multi-recipient contact form when the email field holds several values (all become recipients).
- Combine with core Views formatting so the same email field can toggle between a link and an inline form across display modes.
- Offer a lightweight alternative to per-user personal contact pages for site-wide/custom contact forms tied to a data field.
- Drive a "request a callback / email me" form on product or service displays from a contact email field.
- Keep recipient addresses out of the page HTML (the form is rendered, not the address) while still enabling contact.
