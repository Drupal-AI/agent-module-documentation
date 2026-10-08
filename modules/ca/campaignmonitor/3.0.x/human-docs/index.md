# Campaign Monitor — manual setup guide

**Campaign Monitor** (`campaignmonitor`) connects your Drupal site to a
[Campaign Monitor](https://www.campaignmonitor.com/) account so you can grow and
manage email-marketing subscriber lists directly from the site. Once it is
connected with your account's API key, the module pulls in the subscriber lists
from your Campaign Monitor account, lets you choose which of them are available
on the site, and gives you a ready-made **Subscribe** block you can drop into any
region so visitors can sign themselves up.

Under the hood it talks to Campaign Monitor through the official
`campaignmonitor/createsend-php` SDK, so all the traffic goes to Campaign
Monitor's own API — there is no arbitrary URL to configure. Subscriptions can
happen in real time, or you can queue them up and let cron process them in
batches to keep page loads snappy and reduce the number of API calls.

Two optional submodules extend it: **Campaign Monitor Registration**
(`campaignmonitor_registration`) adds newsletter opt-in checkboxes to the user
registration form, and **Campaign Monitor User** (`campaignmonitor_user`) adds a
subscription-management tab to each user's profile so logged-in members can
manage their own newsletters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   Campaign Monitor PHP library with Composer, and enable it.
2. [Configuration](configuration/index.md) — enter your API key, enable lists,
   place the subscribe block, and tune caching and cron behavior.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → Web services
→ Campaign Monitor** (`/admin/config/services/campaignmonitor`), and the list of
your Campaign Monitor lists is one click away at
`/admin/config/services/campaignmonitor/lists`. The subscribe form is added as a
**Campaign Monitor Signup** block that you place from **Structure → Block
layout**.

## How to use it

The short version of the workflow is:

1. Enter your **API Key** and **Client ID** on the settings form and save.
2. Open the **Lists** tab, where the module fetches the lists from your account,
   and **enable** the ones you want to use on the site.
3. Edit each enabled list to choose which fields (name, custom fields) appear on
   its subscribe form.
4. Place a **Campaign Monitor Signup** block, pick whether it targets one list
   or lets the visitor choose, and save.

From then on, visitors can subscribe from the block, logged-in users can manage
their subscriptions (if the user submodule is on), and deleting a user
automatically unsubscribes their email from every list.
