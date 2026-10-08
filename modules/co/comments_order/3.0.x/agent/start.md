<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comments Order — agent index

Choose oldest-first vs newest-first ordering **per comment field**, plus how threaded children
sort. No admin page (`configure: null`), no permissions, no Drush, no plugins. All state is
**three third-party settings on the comment field's `field.field.*` config**.

- **Set the order for a comment field / where it is stored / config keys** →
  [configure/order.md](configure/order.md)
- **How it actually reorders comments (query alter, storage handler, thread math, redirect)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: settings live at `field.field.<entity_type>.<bundle>.<comment_field>` →
`third_party_settings.comments_order.{order, children_natural_order, created_order}`, where
`order` is `ASC` or `DESC`. The extra fields appear on the *Manage fields* → comment field edit
form only for fields whose type is `comment`.
