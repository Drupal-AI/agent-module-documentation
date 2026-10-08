<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailgun Mailing Lists is a submodule of Mailgun that manages Mailgun mailing lists from Drupal and exposes a placeable "Mailing list subscribe form" block so visitors can subscribe to a list by email.

---

The submodule adds an admin page (route `mailgun_mailing_lists.admin_settings_form` at
`/admin/config/services/mailgun/settings/mailing-lists`, a tab under the Mailgun settings, gated
by the parent module's `administer mailgun` permission) that lists your Mailgun mailing lists and
lets you create a new one (address, name, description, access level) via the Mailgun API. A
second route (`mailgun_mailing_lists.list`) shows the members of a given list. The visitor-facing
piece is a Block plugin **`mailing_list_subscribe`** ("Mailing list subscribe form") whose block
settings store which list (`mailing_list`, a list address) it subscribes people to; when rendered
it shows a single email field and, on submit, adds that address as a member of the configured
Mailgun list (creating the membership through the `mailgun.mailgun_client`). All list creation,
member lookup and subscription operations call the Mailgun HTTP API, so they need a valid Mailgun
API key configured in the parent module — but placing and configuring the subscribe block is
local Drupal configuration. It depends on the parent Mailgun module for the API client.

---

- Add a newsletter signup block to a sidebar backed by a Mailgun mailing list.
- Let visitors subscribe to a mailing list with just their email address.
- Manage (list/create) Mailgun mailing lists from the Drupal admin UI.
- Create a new Mailgun list (address, name, description, access level) without leaving Drupal.
- View the members of a Mailgun mailing list from the admin.
- Place multiple subscribe blocks, each wired to a different Mailgun list.
- Add a footer "Join our newsletter" form on every page.
- Route subscribers into a specific segment by choosing the list per block.
- Offer subscription on a campaign landing page via a placed block.
- Reuse the parent Mailgun API key/config for list operations (single integration).
- Restrict list administration to trusted users via the `administer mailgun` permission.
- Collect leads into Mailgun for later broadcasts.
- Provide a GDPR-style single-field (email only) opt-in form.
- Swap which list a subscribe block targets by editing the block's configuration.
- Show a "already subscribed" path when the email is already a member.
- Combine with the parent module's HTML templates for confirmation emails.
- Build a simple email-capture funnel on a Drupal site.
- Keep subscription UI as configuration (block placement) deployable across environments.
