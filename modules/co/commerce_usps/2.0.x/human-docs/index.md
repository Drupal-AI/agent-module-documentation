# Commerce USPS — manual setup guide

**Commerce USPS** (`commerce_usps`) adds USPS (the United States Postal Service)
as a shipping carrier for Drupal Commerce. Once configured, it fetches **live
postage rates** from the USPS API during checkout, so shoppers see real USPS
prices for their cart and destination instead of flat or guessed shipping costs.

It plugs into the Commerce Shipping framework as two shipping-method plugins —
**USPS Domestic** (`usps`) and **USPS International** (`usps_international`). You
create a Commerce *Shipping method*, pick one of these plugins, enter your USPS
API credentials, and choose which named services to offer (Priority Mail, Ground
Advantage, Priority Mail Express, and their international equivalents). At
checkout the plugin builds a request from the order's packages and ship-to
address and returns a rate for each enabled service. It also declares USPS
flat-rate boxes as Commerce package types.

The 2.x branch uses the **current USPS OAuth API**, which means a Consumer key
and Consumer secret (not the older USERID web-tools login). You can run in a test
mode with sandbox credentials first, then flip to live once everything checks
out. Contract / negotiated pricing, a rate multiplier, custom rounding, a
tracking-URL template, and request/response logging for debugging are all
available per shipping method.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in
   Commerce Shipping, and enable the module.
2. [Configuration](configuration/index.md) — create a USPS shipping method,
   enter API credentials safely, and choose services and options.

## Where it lives in the admin menu

Commerce USPS has no settings page of its own. You configure it as a Commerce
**Shipping method** under **Commerce → Configuration → Shipping → Shipping
methods** (`/admin/commerce/config/shipping-methods`). Add a shipping method
there and choose the USPS or USPS International plugin.

## How to use it

Enable the module, then add a shipping method under *Commerce → Configuration →
Shipping → Shipping methods*, choosing **USPS** (domestic) or **USPS
International**. Enter your USPS Consumer key and secret, leave the mode on
**test** while you verify things, pick the services you want to offer and a
default package type, and save. USPS rates then appear during checkout for
matching orders. When you are happy, edit the method and switch the mode to
**live**. See [Configuration](configuration/index.md) for the full walkthrough,
including how to keep your API secret out of version control.
