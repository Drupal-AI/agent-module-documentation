# Instagram Media — manual setup guide

**Instagram Media** (`instagram_media`) integrates Instagram into your Drupal site
using the **Instagram Graph API** and renders a feed in a **block**. You paste a
long-lived access token, place the "Instagram Media" block, and configure how the
posts look — with a fair amount of control over images, videos, captions, and
layout. Because it uses the Graph API (rather than the older, now-deprecated Basic
Display API), it's aimed at staying current with what Instagram supports.

It is deliberately feature-rich on the display side. You can choose whether media
is unstyled, run through an **image style**, or a **responsive image style**; set
how many posts to show; hide videos or autoplay them; toggle captions, insights
(likes/comments), and post links; and control presentation with a **Swiper**
carousel, **Fancybox** lightbox, and a range of **grid layouts** from mobile to
desktop — or disable the module's CSS entirely and style it yourself. It can also
**auto-refresh the access token** using your app credentials. It depends only on
core **Block**, defines an **administer instagram media block** permission, and
supports Drupal 9, 10, and 11.

> **Platform and credentials caveats.** Instagram's Basic Display API — the old
> "show my own recent posts" route — has been shut down; the current paths are the
> Graph API (business/creator accounts) and oEmbed (individual posts). Verify the
> release targets an endpoint that still answers for your account. And the access
> token is a **secret** that expires and needs refreshing — a feed that works at
> launch can go silent weeks later, so store the token securely (an environment
> variable on this project's convention) and plan to monitor it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the Instagram Media block, add
   your token, and set the display options.

## Where it lives in the admin menu

There is no standalone settings page — configuration happens on the **Instagram
Media block** itself, which you add through **Structure → Block layout**. The
**administer instagram media block** permission gates who can administer it. See
[Configuration](configuration/index.md).
