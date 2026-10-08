# EngageBay Module — manual setup guide

**EngageBay Module** (`engagebay`) connects a Drupal site to the
[EngageBay](https://www.engagebay.com/) CRM and marketing platform and lets
editors embed EngageBay **forms** and **landing pages** into content through
CKEditor. An administrator connects the account once; after that, editors insert
EngageBay content from within the rich-text editor. It depends on core's
**CKEditor 5** and **Filter** modules.

The flow is straightforward. An admin opens the connection form, logs in with
EngageBay credentials, and the module stores the account's domain and API keys.
Two CKEditor plugins — **Form** and **Landing Page** — then let editors browse the
account's forms and landing pages and drop a placeholder into the content; when
the content renders, the module fetches the hosted form or landing-page HTML from
EngageBay and displays it in place. This is a good way to capture leads and run
marketing campaigns from Drupal content without leaving the editor.

> **Data to be aware of.** Connecting posts your EngageBay username and password
> to EngageBay's login endpoint over HTTPS, and the returned REST and JS API keys
> are saved in the module's configuration. Embedded forms capture visitor data into your EngageBay CRM, so treat
> that as personal-data egress to a third party and disclose it in your privacy
> policy. When rendering embeds, the module makes a server-side request to fixed
> EngageBay hosts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CKEditor/Filter dependencies.
2. [Configuration](configuration/index.md) — connect your EngageBay account and
   add the Form / Landing Page buttons to a text format.

## Where it lives in the admin menu

The module's settings live at the EngageBay configuration route
(`/engagebay/configure`), reachable by users with the **Access administrator
pages** permission. The embedding controls are added to your text formats under
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
