# ActiveCampaign — manual setup guide

**ActiveCampaign** (`activecampaign`) integrates the **ActiveCampaign**
marketing-automation and CRM platform with Drupal. Its job is to connect your
site to ActiveCampaign so that contacts can be synced and marketing-automation
features can run against your site's audience.

The project is organised as a base module plus two optional submodules.
**ActiveCampaign Dashboard** (`activecampaign_dashboard`) adds an in-Drupal
dashboard view, and **ActiveCampaign Webform** (`activecampaign_webform`)
integrates with the Webform module so form submissions can flow into
ActiveCampaign. It sits in the "Automated marketing" package and runs on Drupal
10.2 and 11.

Because this module sends personal data — contacts' names and email addresses —
to a third-party service, treat it as a privacy-relevant integration. Store the
ActiveCampaign API credentials as secrets (never in committed configuration), and
make sure you have appropriate consent and a privacy disclosure covering the data
you share with ActiveCampaign (a GDPR concern for EU-facing sites). The module
has no access-control role of its own; it is purely an outbound integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the dashboard/webform submodules.
2. [Configuration](configuration/index.md) — connect your ActiveCampaign account
   with API credentials stored as secrets.

## Where it lives in the admin menu

After enabling, connect the module to your ActiveCampaign account using your API
credentials (see [Configuration](configuration/index.md)). If you enable the
**Dashboard** submodule you also get an in-Drupal dashboard view of your
ActiveCampaign data.
