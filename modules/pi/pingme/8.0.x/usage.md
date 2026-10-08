<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A learning/example module for new Drupal developers that demonstrates a custom schema, mail, insert/update/delete, a paged record list, a single-record view and AJAX modal-popup forms.

---

On install (`pingme.install`) it creates a `pingme` table (receiver uid/name/email, message, isDeleted flag). The "ChatForm" lets you pick a user via an autocomplete backed by `/pingme/LoadUsers` and store a message; `PingmeDataController` renders a paged, filtered (`isDeleted = 0`) table with view/edit/delete links; `ViewSingleRecordController` shows one record in a modal; `DeleteMessagesForm` soft/hard-deletes; and `ModalForm`/`ModalFormExampleController` demonstrate opening an AJAX modal dialog. Queries use the parameterised database API and the autocomplete input is `Xss::filter`ed.

It is explicitly a demonstration module, and its routing reflects tutorial convenience rather than a production access model. Four routes are declared with `_access: 'TRUE'` — `/ping-me` (ChatForm create), `/ping-me/records/edit/{id}` (ChatForm edit), `/pingme/form/delete_messages/{id}` (delete), and `/pingme/form/modal_form` (demo modal) — meaning anonymous visitors can create, edit and delete rows in the `pingme` table. The listing and single-record routes (`/ping-me/records`, `/pingme/ViewrRecord/{id}`) and the user autocomplete (`/pingme/LoadUsers`) are gated only by `access content`, which is anonymous on a default site, and they display recipient email addresses and enumerate user accounts. Treat this module as sample code: do not enable it on a public or production site without adding real permission checks.

---
- Learn how to define a custom database schema in hook_install
- See a paged Views-free record table built in a controller
- Study an entity autocomplete backed by a custom controller
- Learn AJAX modal dialog patterns (OpenModalDialogCommand)
- See a ConfirmForm-based delete flow
- Demonstrate insert and update with the database API
- Demonstrate a hook_mail implementation
- Example of Link/Url render arrays with dialog options
- Reference for use-ajax buttons and dialog libraries
- Practice reading form state in an AJAX submit callback
- Show a single record in a modal popup
- Filter out soft-deleted rows in a list query
- Escape user autocomplete input with Xss::filter
- Use as a scaffold when learning Drupal form/controller APIs
- Compare procedural \Drupal::database() usage across CRUD ops
