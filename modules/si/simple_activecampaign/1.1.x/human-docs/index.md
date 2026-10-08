# Simple ActiveCampaign — manual setup guide

**Simple ActiveCampaign** (`simple_activecampaign`) adds a newsletter
**subscription form** to your site as a block. A visitor enters their details, and
the module creates a contact in your [ActiveCampaign](https://www.activecampaign.com)
account through the ActiveCampaign API — a quick way to collect newsletter sign-ups
and push them straight into your email-marketing/CRM platform.

The form is AJAX-powered and highly customizable **per block instance**: you can
relabel the form fields, set your own success and failure messages, and control
which ActiveCampaign contact lists are involved. New contacts can be added to a
default list automatically, and you can optionally let visitors pick an additional
list to join. The contact lists are loaded live from ActiveCampaign via the API,
and within the block settings you can re-label them, hide some from the options,
and reorder them.

The module needs configuration before it works: you enter your ActiveCampaign API
URL and key on a services settings page, then place and configure the block. It
provides its own permission, has no submodules, and — because it talks to an
external service with a credential — you should store the API key securely (see the
installation and configuration notes). Note that this project is **not covered by
Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its required
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your API credentials and place
   and configure the subscription block.

## Where it lives in the admin menu

Two places. The API connection is set under **Configuration → Web services →
ActiveCampaign**, and the form itself is added and tailored through **Structure →
Block layout** (`/admin/structure/block`), where you place the ActiveCampaign block
into a region and configure its labels, messages, and lists.
