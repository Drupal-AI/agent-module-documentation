# engageSPARK — manual setup guide

**engageSPARK** (`sms_engagespark`) is a gateway plugin for the **SMS Framework**
that lets Drupal send text messages through the engageSPARK service. It doesn't
send SMS on its own; instead it registers engageSPARK as one more gateway that
SMS Framework can route messages through. Once you've added and selected the
gateway, any SMS that the framework dispatches — order alerts, one‑time
passcodes, reminders, campaign messages — can be delivered via engageSPARK.

The module depends on the **SMS Framework** module (`smsframework`, machine name
`sms`) and on the `giggsey/libphonenumber-for-php` library for phone‑number
handling, which Composer installs for you. It has **no admin settings form of its
own**: you create and configure the engageSPARK gateway entirely through SMS
Framework's gateway UI, entering the engageSPARK API token and your
organization/sender settings there. It provides no permissions and adds no routes
of its own.

**Please review the security note below before enabling this in production.** The
module's own documented security finding is that, in the version reviewed, the
engageSPARK API request was sent with **TLS certificate verification disabled**
(`verify => FALSE`) while carrying the API token in the `Authorization` header.
On a network path where an attacker can sit in the middle, that would let them
present any certificate and capture the API token, the message contents, and the
recipient numbers — and then send SMS on your account. The fix is to remove the
`verify => FALSE` option so the connection validates the server certificate;
check whether your installed version still has this before trusting it with a
live account.

This guide is written for a **human** setting the gateway up through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its SMS Framework dependency).

## How to use it

1. Make sure the **SMS Framework** module is installed and enabled (see
   [Installation](installation/index.md)).
2. Go to **Configuration → SMS & messaging → Gateways**
   (`/admin/config/smsframework/gateways`) and add a new gateway using the
   **engageSPARK** plugin.
3. Enter your engageSPARK **API token** and the organization / sender settings
   for your account.
4. Save the gateway, then set it as the site's **default** gateway (or route
   specific phone numbers to it).

From then on, any module that sends SMS through the framework — for example
verification codes for sign‑up or two‑factor flows, or bulk/engagement campaigns
— will deliver via engageSPARK. You can switch providers later simply by changing
which gateway is active. Test delivery from SMS Framework's own test form and
review send results in its reporting.
