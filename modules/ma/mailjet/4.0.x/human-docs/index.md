# Mailjet — manual setup guide

**Mailjet** (`mailjet`) routes your Drupal site's email through the
[Mailjet](https://www.mailjet.com/) email API instead of the local mail server,
and — through a set of optional submodules — adds Mailjet's marketing tooling on
top: contact lists, subscription sign-up forms, campaigns, delivery statistics,
event webhooks, and Drupal Commerce triggers. The base module handles
transactional delivery (the password resets, order confirmations, and system
notices your site already sends), giving you Mailjet's deliverability handling
and per-message tracking that plain PHP mail cannot offer.

It is worth understanding the scope before you enable everything. The base
module on its own is "just" a better mail transport. The submodules widen that
considerably — enabling the whole project brings a full marketing platform into
your site, not simply a mail transport. Turn on only the pieces you actually
need. The available submodules are **Contact lists** (`mailjet_list`),
**Subscription** (`mailjet_subscription`), **Campaigns** (`mailjet_campaign`),
**Event callbacks** (`mailjet_event`), **Statistics** (`mailjet_stats`),
**Commerce** (`mailjet_commerce`), and a **Trigger examples**
(`mailjet_trigger_examples`) helper.

Two things to keep front of mind. First, the **API key and secret are live
credentials** — treat them like passwords, keep them out of exported
configuration, and store them in an environment variable surfaced through a Key
entity (the installation and configuration guides show exactly how). Second, a
contact list is **personal data**: synchronising your subscribers to Mailjet is
a data-processing arrangement that needs a lawful basis and, in many
jurisdictions, a processor agreement with Mailjet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP
   libraries with Composer, enable it, and choose which submodules you need.
2. [Configuration](configuration/index.md) — enter your Mailjet API key and
   secret safely and set the module's options.

## Where it lives in the admin menu

Once enabled, Mailjet's settings sit at **Configuration → System → Mailjet**
(`/admin/config/system/mailjet`). Your API credentials are entered on the **API**
tab under that page (`/admin/config/system/mailjet/api`).

## How to use it

At a minimum: install the module, enter your Mailjet API key and secret, and
Drupal's transactional email starts flowing through Mailjet. From there, enable
the submodules that match what you want to do — manage lists, add a newsletter
subscription form, run campaigns, or wire up Commerce triggers. If you enable
**Event callbacks** (`mailjet_event`), remember that it receives POST requests
from Mailjet; like any webhook it must be authenticated by signature rather than
trusted simply because a request arrived.
