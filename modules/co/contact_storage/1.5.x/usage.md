Contact Storage persists submissions from core's Contact module — which core normally emails and discards — as editable `contact_message` entities, and adds an admin listing, fields, and per-form extras.

---

Core Drupal's Contact module builds `contact_message` entities to send an email, then throws them away. Contact Storage keeps them: via `hook_entity_type_alter()` it gives `contact_message` an SQL storage backend, a `base_table`, an integer `id` key, plus `created`, `uid`, and `ip_address` base fields, so every submission is saved as a fieldable content entity. It exposes those messages through a bundled Views page (`contact_messages`) at **Admin → Structure → Contact → List** (`/admin/structure/contact/messages`) where each message can be viewed, edited, or deleted, with a bulk delete action. Because contact forms are bundles, you can add ordinary Drupal fields to a contact form and they are stored on each message. The module alters the contact-form edit form (via `hook_form_FORM_ID_alter`) to add per-form third-party settings — a custom submit-button label, an optional URL alias, a disabled-form message, a preview toggle, a maximum-submissions-per-user limit, and an autoreply text format — and lets a form be enabled or disabled with its own confirm forms. A global `contact_storage.settings` config object holds a single `send_html` flag for sending HTML mail (with Swiftmailer). It also provides a `contact_storage_options_email` field type for routing submissions to different recipients based on a selected option, and a clone action for whole contact forms. It depends on core `contact`, `views`, `options`, `filter`, and the contrib `token` module.

---

- Save every message sent through a core contact form instead of losing it after email delivery.
- Give site editors an admin list of all received contact messages at `/admin/structure/contact/messages`.
- View an individual stored contact message as an entity page.
- Edit a previously submitted contact message.
- Delete contact messages one at a time, or in bulk with the delete action.
- Add custom fields (e.g. a phone number or dropdown) to a contact form and store them per submission.
- Query stored `contact_message` entities programmatically with an entity query.
- Filter the messages list by a specific contact form via the `form` query argument.
- Override a contact form's submit button text (e.g. "Send enquiry" instead of "Send message").
- Give a contact form a friendly URL alias instead of `/contact/machine_name`.
- Show a custom "this form is disabled" message when a form is turned off.
- Disable or re-enable an individual contact form without deleting it.
- Cap how many times a single user (or IP, for anonymous) may submit a form.
- Hide the preview button on a contact form.
- Clone an existing contact form (and its fields) as the basis for a new one.
- Send contact emails as HTML using the global `send_html` setting plus Swiftmailer.
- Choose a text format for a contact form's autoreply message.
- Route a submission to different email recipients based on a selected option (`contact_storage_options_email` field).
- Build a moderation/inbox workflow for enquiries on top of the stored entities.
- Export the contact-messages view or clone it to build custom reporting.
- Record the submitter's IP address and user ID with each message for auditing.
- Use core Contact + Contact Storage as a lightweight alternative to Webform for simple data collection.
- Track when each message was created via the added `created` base field.
- Manage message access with the core `administer contact forms` permission.
- Deploy the `send_html` setting and per-form third-party settings as configuration between environments.
