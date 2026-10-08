<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Contact adds two display formatters for core Email fields that render a contact form instead of exposing the address: "Email contact link" (a link/modal to a contact form) and "Email contact inline" (the form embedded directly in the page).

---

The module ships two field formatters for the `email` field type — `email_contact_link` and `email_contact_inline` — plus a route (`email_contact.form`) and a `hook_mail()` implementation. Instead of printing the email address (which invites scraping/spam), the field is shown as a link to, or an embedded copy of, a small contact form (name, email, subject, message). On submit the message is sent to the field's address(es) via Drupal's mail system with the visitor's address as reply-to; the address itself is never shown. `email_contact_link` can open the form on its own page or in an **AJAX modal** and lets you set the link text and page/modal title; `email_contact_inline` embeds the form and lets you choose the post-submit redirect (front page, current page, or a custom path). Both formatters support an "include field values in the email body" toggle and an "additional message" that supports **tokens** when the Token module is present. Access is inherited from the entity's and field's view access — there is no module-specific permission — and the form validates the address and blocks header-injection attempts. Modules can alter the modal open/close behaviour by subscribing to `AjaxEmailContactCommandEvent`. There is no global settings page; everything is configured per field in *Manage display*.

---

- Show an author/staff email field as a "Contact this person" link that opens a contact form.
- Hide real email addresses from scrapers while still letting visitors get in touch.
- Embed an inline contact form beneath a listing's email field so users can message directly.
- Open the contact form in a modal dialog from a node's email field (AJAX).
- Provide a department mailbox contact form on a "Contact us" content type's email field.
- Let visitors email a property/product lister without revealing the address.
- Set custom link text like "Email the organiser" on an event's email field.
- Redirect users to the front page, the current page, or a custom thank-you path after they submit the inline form.
- Include the submitter's name and email in the message body automatically.
- Prepend a standard message (with tokens, e.g. `[current-page:url]`) to every email sent through the form.
- Give each contact form a custom page/modal title, or fall back to "<entity label> - Email Contact".
- Send to multiple recipients when the email field has several values.
- Replace a plain mailto: link (spam-prone) with a moderated contact form.
- Add a "Message the seller" modal to a marketplace listing.
- Let site members contact a profile owner via their user email field without seeing the address.
- Protect a support alias behind a contact form that logs each send.
- Collect enquiries with reply-to set to the sender so staff can reply directly.
- Offer both an on-page form (inline) and a compact link/modal (link) for different view modes.
- Prevent email header injection by relying on the module's subject/address validation.
- Customise modal open/close AJAX behaviour by subscribing to the AjaxEmailContactCommandEvent.
- Turn any entity's email field (node, user, taxonomy term, media) into a contact channel via its Manage display.
