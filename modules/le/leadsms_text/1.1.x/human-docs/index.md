# LEADsms — manual setup guide

**LEADsms** (`leadsms_text`) adds an SMS "click‑to‑text" widget to your Drupal
site so visitors can start a text‑message conversation with you, turning casual
browsers into support conversations and sales leads. It is the Drupal front end
for the **CONNECTsms** platform: the module renders a small form on your pages,
collects the visitor's message and phone number, and sends that content securely
to your CONNECTsms account, where you carry on the conversation over SMS.

It is aimed at businesses and site owners who want a quick, personal
communication channel — customer support or lead generation by text rather than
email or a contact form. There are no other Drupal module dependencies; the
module works against the CONNECTsms service, which you connect to with an
activation key.

Using LEADsms in production requires an active **CONNECTsms subscription** and
**PHP 8.0 or higher**. Because the widget hands visitor input to an external
service, the account credential that links your site to CONNECTsms is sensitive
and should be stored as a secret — see the Configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter and safely store your
   CONNECTsms activation key, and understand what leaves your site.

## Where it lives in the admin menu

Once enabled, LEADsms is configured at **`/admin/config/leadsms_text/settings`**,
where you enter your CONNECTsms activation key. After it is configured, the
LEADsms widget becomes available on your site, ready to accept visitor input and
relay it to CONNECTsms.
