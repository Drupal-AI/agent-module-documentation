<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Group enables email communication for groups: it defines Mail Group, Mail Group Type, and Mail Group
Membership entities so you can build mailing-list-style groups whose members send and receive email.
Connection backends (how mail is sent/received for a group) are provided by a **connection plugin type**
(`ConnectionManager`, `Plugin/Mailgroup/Connection`), with sensitive connection settings stored encrypted
via the [Encrypt](https://www.drupal.org/project/encrypt) module. Companion modules such as
`mailgroup_amazonses` add concrete connection plugins. Depends on core `options`, core `user`, and
`encrypt`.

---

The module ships a fine-grained permission set (`mailgroup.permissions.yml`): `administer mail groups`
(restricted), plus add/edit/delete/view for mail groups and add/edit(/own)/delete(/own)/view(/own) for
memberships. All routes are permission-gated — the membership admin/confirm forms
(`/admin/mailgroup/members/{activate,deactivate,add,delete}-multiple`) require
`administer mail groups` combined with the relevant membership permission, and the per-user page
`user/{user}/mailgroups` requires `administer mail groups + edit mail group memberships +
edit own mail group memberships`. Services include `plugin.manager.mailgroup_connection` (the connection
plugin manager), `mailgroup.handler` (`MailHandler` for outbound mail), a message parser factory
(`zbateson/mail-mime-parser`), and an event subscriber (`MailGroupMessageEventSubscriber`) that hands
received messages to the handler. Config schema and a bundled Views (`views.view.mailgroup`) plus VBO
action configs are provided. Connection plugin configuration data is encrypted (the module suggests
`encrypt_kms`, `real_aes`, or `sodium` as encryption backends).

---

- Run a mailing-list-style group where members send and receive email.
- Model different group types with the Mail Group Type entity.
- Manage per-user group memberships (add/activate/deactivate/delete).
- Let users manage their own memberships with the "own" permissions.
- Pipe inbound email into a group via a connection plugin (e.g. Amazon SES).
- Store connection credentials encrypted via the Encrypt module.
- Swap encryption backends (KMS, Real AES, Sodium) per site policy.
- Bulk-activate or bulk-deactivate memberships with the bundled VBO actions.
- Bulk-add or bulk-remove memberships for selected users.
- Expose a per-user "Mail Groups" page at `user/{user}/mailgroups`.
- List and manage groups through the bundled Views view.
- Delegate group administration with the `administer mail groups` permission.
- Grant view-only access to memberships for auditors.
- Build custom connection plugins for other mail providers.
- Route received messages through the event subscriber to the mail handler.
- Parse raw MIME messages with the bundled mail-mime-parser integration.
- Restrict membership editing to owners via the "own" permission variants.
- Send group announcements through the `MailHandler` service.
