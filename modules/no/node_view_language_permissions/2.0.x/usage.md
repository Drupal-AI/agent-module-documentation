<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node View Language Permissions enables 'View own content' and 'View any content' permissions for each content type and language.

---

Node View Language Permissions adds fine-grained view permissions to nodes — providing "View own
content" and "View any content" permissions **per content type and per language**, so you can restrict which
users can view nodes based on the node's language (e.g. only certain users may view French-language content).
It is in the Access control package and provides its own permissions.

Use it to restrict node view access by language. This is a genuine access-control module implemented with the
correct mechanism: it uses Drupal's **node-grants system** (`hook_node_access_records()` +
`hook_node_grants()`), which enforces access at the **query level** — so nodes a user isn't permitted to view
(by their content-type+language permissions) are filtered out of listings/search/Views, not merely hidden on
the full page (the strong, correct pattern). When adopting: grant the per-type/per-language permissions to
match your intent and **test** that the right users can/can't see nodes in each language (node-access grants
are additive — a user needs a granting permission to view). Configure the permissions on the roles.

---

- Add per-type per-language view permissions.
- Provide 'View own/any content' by language.
- Restrict node view by language.
- Use the node-grants system.
- Enforce access at the query level.
- Filter restricted nodes from listings/search.
- Avoid the listings-leak mistake.
- Provide its own permissions.
- Grant per-type/per-language permissions to match intent.
- Test can/can't-see per language.
- Know grants are additive.
- Configure the permissions on roles.
- Restrict by node language.
- Handle language-based access.
- Enforce node grants.
- Control view by language.
- Configure per language.
- Restrict content viewing.
- Handle per-language permissions.
- Provide language view access.
