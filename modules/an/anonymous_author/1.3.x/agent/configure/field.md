<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the anonymous author field

1. Add a field of type **Anonymous author** to an entity type (node, comment, etc.) via Manage fields.
2. On Manage form display, the **Anonymous Author** widget exposes `email`, `name` and a `notify` checkbox. Optionally set email/name placeholder text in the widget settings.
3. On Manage display, use the **Anonymous author** formatter to render the stored details.

Visibility rules (`AnonymousAuthorWidget::formElement`):
- New entity → fields shown only to **anonymous** users.
- Existing entity → fields shown only to users with `edit anonymous author fields`.

Notifications: if `notify` is set, `anonymous_author_entity_update` emails the stored address on entity update, and `anonymous_author_entity_insert` emails it when a comment is added (skipping the author's own comment). The recipient is the visitor-supplied email — validate/rate-limit upstream if abuse is a concern.

Note: the field stores plain name/email text; it does **not** set the entity's real owner/`uid`. Anonymous content creation still requires the relevant core create permission.
