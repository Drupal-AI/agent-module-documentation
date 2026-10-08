# Netgsm (SMS Framework) — manual setup guide

**Netgsm (SMS Framework)** (`sms_netgsm`) is a gateway plugin that lets Drupal's
**SMS Framework** send text messages through **Netgsm**, a Turkish
telecommunications provider specializing in SMS, voice, and fax services. The
module itself doesn't send SMS directly; it registers Netgsm as one of the
gateways the framework can route messages through. Once the gateway is configured
and selected, any SMS the framework dispatches — verification codes, alerts,
reminders — is delivered via Netgsm's API.

The module depends on the **SMS Framework** module (`smsframework`, machine name
`sms`) and provides its own permissions. It is independently developed and is not
affiliated with or sponsored by Netgsm. Configuration is done through SMS
Framework's gateway UI, where you supply your Netgsm account credentials.

A data‑handling note worth keeping in mind: sending SMS this way means the
**message content and recipient phone numbers (personal data)** are sent to the
Netgsm API — external egress you may need to disclose under your privacy policy.
The gateway authenticates with your **Netgsm credentials**, so store those as
secrets (an environment variable or a Key entity), keep the connection over
HTTPS, and don't commit them to version control. Beyond its own permission, the
module has no access‑control role.

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
   **Netgsm** plugin.
3. Enter your Netgsm account credentials (as required by the Netgsm API — see
   Netgsm's own API documentation for the exact fields).
4. Save the gateway and set it as the site's **default** gateway, or route
   specific numbers to it.

After that, any feature that sends SMS through the framework will deliver via
Netgsm. You can switch providers later by changing which gateway is active.
