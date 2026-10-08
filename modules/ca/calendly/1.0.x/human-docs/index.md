# Calendly — manual setup guide

**Calendly** (`calendly`) embeds [Calendly](https://calendly.com) scheduling
pages into your Drupal site, so visitors can book meetings or appointments
through Calendly's inline or popup widget without leaving your pages. You give it
your Calendly scheduling URL and it renders the embed for you.

It is a thin, friendly bridge to a third-party service. The whole scheduling
flow — and any details a visitor enters while booking — runs on **Calendly's**
side, not yours. To make the widget work, the module loads Calendly's own
third-party JavaScript into your pages, which is worth being aware of on two
counts: you are trusting the vendor's script (it runs in your site's origin),
and visitor scheduling data is processed by Calendly, which is a privacy and
consent consideration for your site.

The module has no access-control role of its own. All you provide is the Calendly
URL and where the embed should appear.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives

Calendly does not add a general site-wide settings page. You supply your Calendly
scheduling URL where you place the embed and choose whether to show it inline or
as a popup.

## How to use it

1. In your Calendly account, copy the scheduling URL for the event type you want
   to offer.
2. Enable the module.
3. Add the Calendly embed where you want booking to appear, pasting in your
   Calendly URL and picking the inline or popup style.

Because the booking itself happens on Calendly, consider your visitors' privacy
and consent — the embed loads Calendly's script and sends scheduling data to
Calendly.
