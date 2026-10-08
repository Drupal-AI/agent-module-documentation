# Social Contact Block — manual setup guide

**Social Contact Block** (`social_contact_info`) gives you a single, highly
configurable block for showing an organisation's contact details and social
links wherever a block can be placed — a footer, a sidebar, a "Contact us"
region. Instead of hand-coding an address and a row of icons into a template,
you fill in a form and drop the block where you want it.

The block covers two groups of information. The **contact** group holds an
address (rich text), one or more e-mail addresses (validated, turned into
`mailto:` links automatically), phone and mobile numbers (validated, turned into
`tel:` links), a fax number, and per-day working hours. The **social /
channels** group holds links to Facebook, LinkedIn, X, YouTube, Pinterest,
Instagram, WhatsApp, Telegram, Slack, Google Maps, Discord, GitHub and Dribbble.
Every item can be switched on or off individually, given a custom label, and
reordered by weight, so you show only the channels you actually use, in the order
you want them.

There is nothing to configure globally — the module has no site-wide settings
page. Everything happens on the block itself: place it through the core Block
layout UI and fill in its fields. It has no dependencies beyond Drupal core and
works on Drupal 8 through 11. A few conveniences are built in: URLs are
normalised (an `https://` is added if you forget it), a WhatsApp number becomes a
`wa.me` link, a Telegram username becomes a `t.me` link, and Google Maps can
either link out or render as an embedded map from a pasted `<iframe>`. Social
links open in a new tab with `rel` security attributes, and any custom SVG icon
markup you paste is sanitised before it is rendered.

This guide is written for a **human** placing and filling in the block through
the admin UI. If you want terse, token-cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — placing the block and filling in the
   contact and social fields, item by item.

## How to use it

The module adds no settings link of its own to the admin menu. Once enabled, go
to **Structure → Block layout** (`/admin/structure/block`), place the
**Social Contact Block** in a region, and configure it there. All of its options
live on that block-configuration form, and you can place more than one instance
(for example a compact footer block and a fuller contact-page block) with
different settings.
