<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PingMe (pingme) — agent index
**Example module demonstrating schema, mail, CRUD, record lists, single-record view and modal forms.**

- **Version:** 8.0.x
- **Core:** ^8.8.0 || ^9 || ^10
- **Storage:** `pingme` table created in `pingme.install`
- **Routes:**
  - `_access: 'TRUE'` (anonymous): `/ping-me` (create), `/ping-me/records/edit/{id}` (edit), `/pingme/form/delete_messages/{id}` (delete), `/pingme/form/modal_form` (demo modal)
  - `_permission: 'access content'`: `/ping-me/records`, `/pingme/ViewrRecord/{id}`, `/pingme/openModalForm`, `/pingme/LoadUsers`
- **Controllers/Forms:** PingmeDataController, ViewSingleRecordController, LoadUsersController, ModalFormExampleController; ChatForm, DeleteMessagesForm, ModalForm

**Security:** demonstration module. Four `_access: 'TRUE'` routes let anonymous users create/edit/delete rows in the `pingme` table; the `access content`-gated list/view/autocomplete routes expose recipient emails and enumerate users. Not for production without adding permission checks. (Queries are parameterised; autocomplete input is Xss::filter'ed.)

See [extend/example.md](extend/example.md)
