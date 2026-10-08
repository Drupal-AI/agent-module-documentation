<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact provides Drupal's site-wide contact forms (`/contact`) and per-user personal contact forms (`/user/{uid}/contact`). It is the former core module, continued as a contrib project for Drupal versions after 11.3, where core no longer ships it.

---

Two config entities drive everything. A **`contact_form`** config entity is one form: a label, a list of recipient email addresses, an optional auto-reply body, a confirmation message, a redirect path and a weight; the shipped `personal` form is the special one used for user-to-user mail. Submissions are **`contact_message`** content entities (fieldable, so you can add fields and reorder them on the form/display), but they are never persisted: the entity type's storage handler is `ContentEntityNullStorage`, so `MessageForm::save()` calls `$message->save()` as a deliberate no-op — a hook point contrib storage modules swap out — and then hands the message to `contact.mail_handler`. `MailHandler::sendMailMessages()` resolves the recipient language (the contacted user's preferred language for personal messages, the site default otherwise), sends `page_mail`/`user_mail` through the mail manager with the sender's address as From, optionally sends the sender a copy (`page_copy`/`user_copy`), optionally sends the configured auto-reply (`page_autoreply`), and logs each send to the `contact` channel. Flood control is built in: `contact.settings.flood` (default 5 messages per 3600 seconds) is checked in `MessageForm::validateForm()` and registered on save, and the form redirects away from itself afterwards so the flood limit does not produce spurious errors. Access is split across three permissions — `administer contact forms`, `access site-wide contact form`, `access user contact forms` — plus a dedicated access checker for the personal tab (`_access_contact_personal_tab`) that forbids contacting anonymous or blocked users, always allows `administer users`, honours each user's own on/off preference stored in `user.data`, and falls back to `contact.settings.user_default_enabled`. The module also adds a personal-contact checkbox to the user form, a `contact_link` Views field, a REST resource for posting messages, migrations from Drupal 6/7 contact settings and categories, and five help topics.

---

- Publish a public "contact us" form at `/contact` without writing code.
- Route enquiries to different teams with several contact forms (sales, support, press).
- Send an automatic acknowledgement to whoever submits a form.
- Let visitors send a copy of their message to themselves.
- Allow logged-in users to email each other without exposing email addresses.
- Give users an on/off switch for their own personal contact form.
- Default new accounts to having their personal contact form enabled (or not).
- Block contact for blocked accounts automatically.
- Let user administrators reach any account's contact form regardless of preference.
- Throttle spam with flood control (messages per interval).
- Add custom fields (phone number, department, order id) to a contact form.
- Reorder or hide fields on the contact form via Manage form display.
- Swap in a real storage handler (e.g. Contact Storage) to persist submissions instead of only emailing them.
- Redirect submitters to a thank-you page after sending.
- Show a custom confirmation message per form.
- Set which contact form `/contact` shows by default.
- Add a "contact" link column to a Views listing of users.
- Accept contact messages over REST from a decoupled front end.
- Localise recipient emails by sending in the recipient's preferred language.
- Audit contact activity through the `contact` logger channel.
- Migrate Drupal 6/7 contact categories and settings into Drupal 11.
- Keep contact forms working after upgrading past Drupal 11.3, where core dropped the module.
- Restrict the site-wide form to authenticated users by revoking the anonymous permission.
- Provide department-specific auto-replies with different SLAs.
