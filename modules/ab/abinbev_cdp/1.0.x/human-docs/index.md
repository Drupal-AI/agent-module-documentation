# AbInBev CDP — manual setup guide

**AbInBev CDP** (`abinbev_cdp`) connects a Drupal site to the **AB InBev Customer
Data Platform (CDP)**. It pushes and syncs customer data and events from Drupal
up to the CDP, so that customer activity captured on the site feeds AB InBev's
central marketing-data platform.

The module is built for AB InBev's own sites and supports **multiple
configurations** — for example, a separate connection per brand or per market —
so one Drupal install can talk to the CDP under several different setups. It is a
bespoke marketing/CRM integration rather than a general-purpose tool.

Because it sends customer data to an external platform, two things matter: the
**API credentials** for the CDP should be stored securely (kept in environment
variables, not committed to configuration), and the customer data leaving Drupal
carries the usual privacy responsibilities. The module provides its own
permissions so you can control who may administer the connection.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

> **Note on the available documentation.** The upstream agent docs for this
> bespoke module are brief and do not spell out an exact settings-page path or a
> field-by-field breakdown of the connection form, so the setup described below
> is deliberately high-level. Confirm the specifics against the module's own
> README once it is installed.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, connect Drupal to the CDP by supplying the platform's
API credentials and defining one or more configurations (for example, one per
brand or market). Keep the credentials in an environment variable rather than in
plain configuration. Grant the module's administration permission only to the
people who should manage the CDP connection. Once configured, customer data and
events flow from Drupal to the CDP automatically.
