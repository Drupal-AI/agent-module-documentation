# Civic Cookie Control — manual setup guide

**Civic Cookie Control** (project **`civicccookiecontrol`**, module
**`civiccookiecontrol`**) integrates the commercial **Civic Cookie Control**
consent banner with Drupal. It gives you the Drupal‑side configuration for Civic's
hosted consent widget: cookie categories visitors can accept or reject, "strictly
necessary" cookies they can't, IAB Transparency & Consent Framework vendor lists
for programmatic advertising, and consent text in multiple languages — all managed
from Drupal admin screens.

It's important to understand the split. The **consent engine itself is Civic's
hosted product** — this module supplies configuration and loads Civic's assets; it
is not the consent widget. You will need an **account and API key/licence from
Civic** for the banner to work. Enabling the module shows the banner and lets you
configure it, but it doesn't, by itself, stop third‑party scripts that other
modules add — you have to wire the scripts you want blocked to the consent
categories.

Mind the **naming**: the drupal.org project is `civicccookiecontrol` (with a triple
"c"), while the module machine name is `civiccookiecontrol`. So you
`composer require drupal/civicccookiecontrol` but `drush en civiccookiecontrol`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (project `civicccookiecontrol`) and enable it (`civiccookiecontrol`).
2. [Configuration](configuration/index.md) — add your Civic API key and set up
   categories, necessary cookies, vendors and languages.

## Where it lives in the admin menu

The configuration screens are reached via the module's *configure* link (the
`cookiecontrol.admin_overview` route) and are gated by the **Administer
civiccookiecontrol** permission — so you can hand cookie‑consent configuration to a
compliance role without giving them broader admin rights. See
[Configuration](configuration/index.md) for the walkthrough.
