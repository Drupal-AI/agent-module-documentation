<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nodeletter turns a content node into a newsletter and sends it through Mailchimp, tracking each send as a `nodeletter_sending` entity.
---
Editors often want to push a published node (a press release, an announcement) to a mailing list without leaving Drupal. Nodeletter adds a per-node "Newsletter" tab that renders a sending form: pick recipient selectors within a configured Mailchimp list, send a test mail, or trigger the real send (real sending is globally gated by the `nodeletter_allow_sending` setting). Each node type is configured (`/admin/structure/types/manage/{type}/nodeletter`) with a Mailchimp list, a template, and template-variable field mappings; a pluggable `NodeletterSender` architecture (currently a Mailchimp implementation) does the actual API work via `mailchimp.api`.

Access to the per-node form is gated by `_entity_access: node.update` plus custom checks that the content type has Nodeletter enabled (`_nodeletter_enabled`) and the node is published (`_node_published`). Admin settings and per-type settings require `administer site configuration`; the sendings collection uses a `view nodeletter_sending entity` permission and the sending entity uses its own access control handler. The optional `nodeletter_blocks` submodule exposes the sending form as a block.

Setup: enable the module, configure Mailchimp credentials in the mailchimp module, enable Nodeletter per node type and map the list/template/variables, then use the per-node Newsletter tab.
---
- Send a published node to a Mailchimp list as a newsletter.
- Add a per-node "Newsletter" tab for editors with update access.
- Enable Nodeletter for specific content types only.
- Map node fields to Mailchimp template variables per type.
- Choose a Mailchimp template for each content type's newsletter.
- Send a test mail to a single address before the real send.
- Restrict real sending globally with the `nodeletter_allow_sending` toggle.
- Limit recipients within a list using Mailchimp interest-category selectors.
- Record every send as a `nodeletter_sending` entity for history.
- Review past sendings per node in the form's history section.
- Browse all sendings at `/admin/nodeletter/sendings`.
- View or delete an individual sending record.
- Add an optional comment to a send for the sending history.
- Expose the sending form as a block via the `nodeletter_blocks` submodule.
- Configure global settings at `/admin/config/services/nodeletter`.
- Attach template-variable fields to nodes via the Sending Variable field type.
- Select a Mailchimp interest category as the recipient selector.
- Prevent sends on unpublished nodes (published-only access check).
- Extend sending backends by implementing the `NodeletterSender` plugin interface.
- Track send status via the `SendingStatus` value object.
