# Section Banner — manual setup guide

**Section Banner** (`section_banner`) lets site builders show dynamic banners on
specific parts of a site — targeted by path, wildcard path pattern, content type,
View, or route name — without writing any custom code. Each banner can carry a
title, a description, and an image, and it is placed on the page through a single
block you drop into a region.

The problem it solves is banner placement that is more flexible than plain block
visibility rules. Instead of juggling several blocks with per-block visibility
settings, you manage all your banners from one configuration screen with unified,
rule-based targeting. It is fully multilingual — banners fall back automatically
when a translation is missing, and a banner image can be shared across languages —
and it supports **tokens**, so a banner's text can include dynamic values like the
node title or the current user's name. You can add custom CSS classes for styling,
and the markup comes from a Twig template
(`section-banner-block.html.twig`) you can override in your theme for full control.

The module needs configuration before it shows anything: you create your banners
and their display rules on the settings screen, then place the Section Banner
block. It creates no new content types. It depends on core's **Block**, **File**,
**Image**, and **Filter** modules, and supports Drupal 10 and 11. It is built with
proper cache contexts and tags, so remember to clear caches after changing banner
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — create banners, set display rules,
   and place the block.

## Where it lives in the admin menu

The banner management screen is at **Configuration → Content authoring → Section
Banner** (`/admin/config/content/section-banner`). The block that renders the
banners is placed from **Structure → Block layout**.

## How to use it

You define banners (title, description, image, display rules, optional CSS
classes) on the Section Banner configuration page, choosing which language you are
configuring, then place the **Section Banner block** into a region via Block
layout. On any page that matches a banner's rules, the block renders that banner.
Clear caches after configuration changes so banners display correctly.
