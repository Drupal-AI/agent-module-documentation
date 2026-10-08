# Hubspot Forms — manual setup guide

**Hubspot Forms** (`hubspot_forms`) connects your Drupal site to a HubSpot
account so editors can pick a HubSpot marketing form from a dropdown and embed
it on the site. The module fetches the account's forms through the HubSpot API,
caches the list, and offers it everywhere you might place a form. Each embed is
rendered with HubSpot's own JavaScript (`hbspt.forms.create`), so the form looks
and behaves exactly as it does in HubSpot, and marketing can change it without a
redeploy.

There are **four ways to place a form**: a **Block** you drop into any region, a
**field** you attach to a content type (so each node can carry its own form), a
**text-format shortcode** (`[hubspot-form:FORMID]`) for inline embeds in
rich-text, and a **CKEditor 5 button** that opens a picker with a live preview.
All four ultimately render the same HubSpot embed.

To connect, you enter your HubSpot credentials on the settings page. You can use
a modern **Private App access token** together with your **Portal ID**
(recommended — HubSpot is sunsetting the older method), or the legacy **API
key**. A cache lifetime setting (default three hours) keeps the module from
calling HubSpot on every page render.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the four embed
mechanisms in detail and the events API — read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connecting to HubSpot (access
   token vs API key, Portal ID, caching) and the four ways to embed a form.

## Where it lives in the admin menu

The connection settings sit at **Configuration → Web services → Hubspot Forms**
(`/admin/config/services/hubspot-forms`) and need the **Administer site
configuration** permission. Individual embeds are placed through Block Layout,
the Field UI, text-format settings, or the CKEditor toolbar, depending on which
mechanism you use.
