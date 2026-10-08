<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and operating Nodeletter

## Global settings — `/admin/config/services/nodeletter` (`administer site configuration`)
- `nodeletter_allow_sending` — master switch for **real** newsletter sends. When off, the per-node
  form shows the "sending" tab disabled; test mails are still possible.

## Per node type — `/admin/structure/types/manage/{node_type}/nodeletter`
- Enable Nodeletter for the type (gates the `_nodeletter_enabled` access check).
- Choose the Mailchimp **list** and **template**.
- Map node fields to template variables (Sending Variable field type / formatter).

## Sending a newsletter
Visit `/node/{node}/nodeletter` (requires `node.update`, node published, type enabled). The
`NewsletterSubmitForm` offers:
- **Send test mail** — to one `test_recipient` address (always available if list+template set).
- **Submit newsletter sending** — real send to the list/selectors (only if `nodeletter_allow_sending`).
Each send creates a `nodeletter_sending` entity; browse at `/admin/nodeletter/sendings`.

## Sender plugins
Sending backends are `@NodeletterSender` plugins managed by `plugin.manager.nodeletter_sender`
(Mailchimp is the bundled implementation, using the `mailchimp.api` service via `MailchimpApiTrait`).
Implement `NodeletterSenderPluginInterface` to add another provider.
