# Commerce Recruiting — manual setup guide

**Commerce Recruiting** (`commerce_recruiting`) adds **referral / recruitment
marketing** to Drupal Commerce. A "recruiter" shares a personalised link or code;
when someone they recruited buys a qualifying product, the recruiter earns a
reward that can be redeemed. It's the toolkit for running affiliate, influencer,
and refer-a-friend programmes on a Commerce store.

The problem it solves is attribution and reward: you need to know which purchase
came from whose link, and to grant a reward only when a genuine purchase happens.
Commerce Recruiting groups one or more products into a **campaign**, generates
customisable **product and user codes**, tracks the resulting purchases, and lets
recruitments be exchanged for rewards. Campaigns can be time-limited, reserved for
specific users (influencers, bloggers), given a custom redirect path per product
code, and set to **auto re-recruit** so a recruited customer keeps generating
recruitments on future orders. It ships blocks for sharing links and for showing a
user their own campaigns and links, and it supports product bundles. It depends on
Commerce **Cart** (`commerce_cart`).

Because rewards have real monetary value, the module handles attribution
server-side: recruiting codes are generated with a cryptographically secure random
generator and kept unique, bonuses are calculated from the campaign configuration
(not from the request) and re-checked when the order is placed, self-referral is
blocked unless a campaign explicitly allows it, and a recruitment only becomes
redeemable once its order has completed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Cart.

Campaigns and rewards are set up as content/config entities rather than through a
single settings form, so there is no separate configuration guide — the workflow
is described below.

## Where it lives in the admin menu

Commerce Recruiting is managed under **Commerce** — you create and manage
recruiting **campaigns** and their rewards there, and place the sharing / "my
campaigns" **blocks** through **Structure → Block layout**.

## How to use it

1. Enable the module (see Installation).
2. Create a **campaign**, grouping one or more products together. Optionally set a
   time limit, reserve it for specific users, and configure the product/user codes
   and any per-code redirect path.
3. Configure the **reward** that a successful recruitment earns, and decide whether
   to enable **auto re-recruit** for repeat orders.
4. Place the **link-sharing block** on the pages where recruiters should share
   links, and the **my-campaigns block** so recruiters can see their own campaigns
   and links.
5. Test the flow end to end: share a link, make a purchase as a recruited buyer,
   and confirm the recruitment is recorded and the reward becomes redeemable — and
   that a user cannot claim their own referral.
