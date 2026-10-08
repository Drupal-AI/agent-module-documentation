# Mailchimp marketing — manual setup guide

**Mailchimp marketing** (`mailchimp_marketing`) connects your Drupal site to the
Mailchimp email-marketing platform so you can manage audiences, sync subscribers,
and drive email campaigns from your site's content. It's built on Mailchimp's
official PHP marketing library.

Its current standout features are around **taxonomy**: it can sync Drupal groups
and taxonomy terms to Mailchimp, and create **RSS campaigns** based on taxonomy
terms — so new content in a given category can feed a recurring Mailchimp
newsletter. An optional submodule, **Subscribe (content type)**
(`mailchimp_marketing_subscribe_ct`), adds content-type-based subscription.

Using the module means holding a Mailchimp **API key** and sending subscriber
data — emails and names, i.e. personal data — to Mailchimp, so credential and
privacy handling matter (see [Configuration](configuration/index.md)). It provides
its own permissions and supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the optional submodule.
2. [Configuration](configuration/index.md) — connect to your Mailchimp account,
   secure the API key, and handle subscriber data and consent responsibly.

## Where it lives in the admin menu

The connection and audience settings are provided by the
`mailchimp_marketing.admin` route, under **Configuration**. That's where you enter
your Mailchimp API key and set up which audiences to work with — see
[Configuration](configuration/index.md).
