# Configuration

Unlike most SMS Framework gateways, MSG91 has its **own settings page**.

## Open the settings form

1. Log in as a user with the **administer smsgateway_msg91 site configuration**
   permission.
2. Go to **`/admin/config/smsgateway_msg91/settings`** (Configuration → SMSGateway
   → MSG91).

## Fields

Enter the details from your MSG91 account. The settings (stored in config
`msgapi.settings` / `smsgateway_msg91.settings`) include:

- **Auth URL** — the MSG91 flow endpoint the gateway POSTs to. MSG91 provides this.
- **Auth key** — your MSG91 account auth key. It is sent to MSG91 in the `authkey`
  HTTP header on each request, over HTTPS with TLS verification on. Keep it secret.
- **Flow / template id** — the MSG91 flow (template) id used when sending. India's
  TRAI/DLT rules require pre‑registered templates, so you add the ids exactly as
  registered on the MSG91 portal.
- **Country prefix** — a dialing prefix automatically prepended to recipient
  numbers.
- **Short‑URL and real‑time‑response flags** — per‑send MSG91 options you can
  toggle.

Save the form. Then, in the **SMS Framework** gateways UI, set the MSG91 gateway
as the site **default** so outbound SMS routes through MSG91.

## Manage templates

The module defines reusable email/SMS **template entities**. List, add, and edit
them at **`/admin/structure/msg-api-email-templates`**. Managing these is gated by
the *Administer email templates* permission (a restricted permission).

## Triggering sends from Actions / ECA

Two Action plugins ship with the module — one sends a free‑text message and one
sends a template‑based message. Use them from **Views Bulk Operations** (to text a
selected set of users or nodes) or from an **ECA** model reacting to a Drupal
event. The *Execute Custom Email Action* and *Execute Custom ECA Action*
permissions (both restricted) control who may run them.

## A note on the standalone Send SMS form

The module also registers a *Send SMS* form at **`/sendmsg`**. Be aware of two
issues in this release: the form is gated by a `msg api access` permission that
the module references but does not actually declare, so no role can be granted it
on a stock install (user 1 aside) and the form is effectively unreachable; and its
submit handler ends with a debug statement that dumps the raw MSG91 response and
halts the request. Prefer configuring and sending through the SMS Framework
gateway and the Action/ECA plugins rather than relying on `/sendmsg` for
production use.
