<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailgroup — agent start

Group email communication. Entities: **Mail Group**, **Mail Group Type**, **Mail Group Membership**.
Sending/receiving backends are a **connection plugin type** (`ConnectionManager`,
`Plugin/Mailgroup/Connection`); concrete plugins ship in companion modules (e.g. `mailgroup_amazonses`).
Depends on core `options` + `user` and `encrypt`.

Key services: `plugin.manager.mailgroup_connection`, `mailgroup.handler` (`MailHandler`, outbound),
`mailgroup_message.parser_factory` (zbateson mail-mime-parser), `MailGroupMessageEventSubscriber`
(routes received messages to the handler).

Permissions (`mailgroup.permissions.yml`): `administer mail groups` (restricted) + add/edit/delete/view
for groups and memberships incl. "own" variants. All routes are permission-gated
(membership multi-action forms require `administer mail groups` + the specific membership perm).

Security: connection config is **encrypted via the Encrypt module**; routes are permission-gated. No
disabled-TLS or unauthenticated-mutation issues in the base module.
