# Mailchimp E-Commerce — manual setup guide

**Mailchimp E-Commerce** (`mailchimp_ecommerce`) connects your Drupal Commerce
store to Mailchimp's e-commerce features, so purchase behaviour on your site flows
into Mailchimp and can drive marketing automation. Once it's syncing, you can
build the kinds of campaigns Mailchimp is known for — abandoned-cart emails,
product recommendations, and audience segments based on what people actually
bought.

It works by sending your **carts and orders** — including customer and order
details — to Mailchimp as they happen. That data is what powers the automations on
the Mailchimp side. To let shoppers opt into a Mailchimp audience during checkout,
you combine this module with the **Mailchimp Subscription field** provided by the
base Mailchimp module.

Mailchimp E-Commerce builds on Drupal Commerce (it depends on the Commerce cart,
checkout, order, price, and product modules, plus Address, Profile, and State
Machine) and requires the base **Mailchimp** module for the API connection. It
supports Drupal 10.4 and 11. Because it forwards personal and commercial data to a
third party, the privacy and credential handling in
[Configuration](configuration/index.md) matters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Commerce and
   Mailchimp dependencies with Composer.
2. [Configuration](configuration/index.md) — connect to Mailchimp, secure the API
   key, and handle customer data and consent responsibly.

## How it fits together

1. You install and connect the base **Mailchimp** module with your Mailchimp
   account's API key.
2. Mailchimp E-Commerce then **syncs your Commerce carts and orders** to
   Mailchimp automatically.
3. Optionally, you add the **Mailchimp Subscription field** (from the Mailchimp
   module) to your checkout so customers can opt into an audience.
4. In Mailchimp, you use the incoming purchase data to build automations and
   segments.
