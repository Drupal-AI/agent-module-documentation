# SMSGateway MSG91 — manual setup guide

**SMSGateway MSG91** (`smsgateway_msg91`) plugs the Indian **MSG91**
transactional‑SMS API into Drupal's **SMS Framework**. It registers an MSG91
gateway so that any SMS the framework dispatches can go through MSG91, and it adds
a few extras on top: a standalone *Send SMS* admin form, management of MSG91
flow/template ids (as required by India's TRAI regulations), reusable email/SMS
template entities, and content‑action / **ECA** hooks so other modules can trigger
an SMS in response to a Drupal event.

The module depends on the **SMS Framework** (`drupal:sms`) and works together with
the **Token** and **ECA** modules; it requires **PHP 8.1**. It is supported by The
Union (the International Union Against Tuberculosis and Lung Disease). Unlike most
SMS Framework gateways, this one has its **own settings page** where you enter your
MSG91 auth URL and auth key and manage templates.

On the data‑handling side, the gateway sends your message content and recipient
numbers to MSG91's flow endpoint over Guzzle with **TLS verification on**, passing
your account **auth key** in the `authkey` HTTP header — so protect that key.

A couple of rough edges in this release are worth knowing before you lean on it in
production. First, the standalone *Send SMS* form at `/sendmsg` is gated by a
permission (`msg api access`) that the module references but does **not actually
declare**, so on a stock install no role can be granted it and the form is
effectively unreachable except for user 1. Second, that same form ends its submit
handler with a debug statement that dumps the raw MSG91 response and halts the
request — so don't rely on `/sendmsg` for a polished production workflow; drive
sends through the gateway (and ECA/Actions) instead. Treat this module as an
early, actively developed release and test your send path before trusting it.

This guide is written for a **human** setting the gateway up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus SMS Framework, Token, and ECA).
2. [Configuration](configuration/index.md) — enter your MSG91 auth key and flow
   settings, and manage templates.

## Where it lives in the admin menu

The module's settings form lives at **`/admin/config/smsgateway_msg91/settings`**
(permission *administer smsgateway_msg91 site configuration*). Reusable email/SMS
templates are managed at **`/admin/structure/msg-api-email-templates`**.

## How to use it

After you configure the MSG91 auth key and flow (see
[Configuration](configuration/index.md)), set the MSG91 gateway as SMS Framework's
default so outbound SMS routes through MSG91. You can then trigger sends from a
**Views Bulk Operations** action on selected users or nodes, or from an **ECA**
model reacting to a Drupal event (such as user registration), using the module's
two Action plugins — one for a free‑text message and one for a template‑based
send.
