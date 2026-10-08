# Active Campaign API Integration — manual setup guide

**Active Campaign API Integration** (`active_campaign_api_integration`) connects
a Drupal site to **ActiveCampaign**, the marketing-automation and CRM platform,
and gives administrators a dashboard for managing common CRM objects from inside
Drupal. It uses ActiveCampaign's v3 API.

Its two main jobs are syncing and administration. On the **syncing** side, you
map the fields of a Drupal form — or the user-registration form — to
ActiveCampaign contact fields; the module then adds submit handlers so that when
someone submits that form, their data is pushed to ActiveCampaign as a contact.
New user accounts are synced automatically via a user-insert hook. On the
**administration** side, the dashboard lets you manage lists, contacts, imports,
deals, pipelines and stages without leaving the Drupal admin.

Outbound calls authenticate with your ActiveCampaign API token, sent as an
`Api-Token` header over a normal TLS-verified connection. Keep that token secret
— store it outside version control (see the installation and configuration
guides). One practical caveat to know up front: every admin route in this module
is gated by a permission literally named `administrator`, which is a *role name*,
not a real Drupal permission, so in practice only user 1 can reach the tools
unless you adjust the routing. This is a functional footgun rather than a
vulnerability, but it explains why the dashboard may appear inaccessible to other
admin users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   satisfy the `intl` PHP extension, and enable it.
2. [Configuration](configuration/index.md) — save your API credentials, reach the
   dashboard, and map forms and user registration to ActiveCampaign.

## Where it lives in the admin menu

Everything is under **Configuration → Active Campaign**
(`/admin/config/active-campaign`), which is the dashboard hub. From there you
reach the settings form
(`/admin/config/active-campaign/active-campaign-settings`), the form-mapping page
(`/admin/config/active-campaign/active-campaign-forms`), and the management tools
for lists, contacts, imports, deals, pipelines and stages.
