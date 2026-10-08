# Social media share — manual setup guide

**Social media share** (`social_media`) renders configurable "share this page"
(and "follow us") links for the current page, either as a Drupal block or as a
field. Each network's URL, label, icon, and HTML attributes are driven by
configuration and Token replacement, so a single set of settings produces links
that always point at whatever page they appear on.

The module ships a fixed set of share targets — Facebook share, Facebook
Messenger, LinkedIn, Twitter/X, Pinterest, WhatsApp, Email, and Print — each
configured as an "item" in one settings object. Every item has an enable flag, a
link label, a share URL built from Token placeholders (typically
`[current-page:url]` and `[current-page:title]`), a setting that decides whether
the URL is attached as a normal link or a JavaScript action, a weight for
ordering, an icon toggle, and a list of extra HTML attributes. The Email item has
an extra "forward this page" mode that swaps the `mailto:` link for an in-site
form (optionally in an AJAX dialog).

Output is produced by the **Social Sharing block**, which reads the configuration,
runs Token replacement, sorts the networks by weight, and renders them through a
theme template you can override. The share links only appear once you place that
block in a region (or add the `social_media` field to a content type), and the
output is cache-tagged per page so links stay correct as visitors navigate. Other
modules can add new networks or alter the build through three dispatched events.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Token dependency, and enable it.
2. [Configuration](configuration/index.md) — enable and edit each network, then
   place the block or add the field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Social media share**
(`/admin/config/services/social-media`), gated by the core *Administer site
configuration* permission. The block is placed from **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

Enable the module, adjust which networks are on and how they look on the settings
form, then place the **Social Sharing block** in a region (or add the
`social_media` field to a content type). The
[Configuration](configuration/index.md) page walks through both.
