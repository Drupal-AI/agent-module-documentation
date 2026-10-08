# OnePass — manual setup guide

**OnePass** (`onepass`) integrates Drupal with
[1Pass](https://1pass.me/), a platform for **single‑article sales** — a
"micro‑paywall" where a reader clicks a 1Pass button on an article and, once
they pay, the full article appears, with 1Pass handling the accounting behind the
scenes.

The module wires that experience into Drupal. It populates the 1Pass button embed
code, gives you a shortcode (`[1pass]`) to drop into a post where the button
should appear, provides a virtual Display Suite field that automatically truncates
a post at the paywall point if the editor forgets the shortcode, and publishes a
built‑in Atom feed so 1Pass can discover and index your content. It can also be
used to *restrict* content: enable the "1Pass paywall" option on a content type
and on individual nodes, then lock a piece by inserting the shortcode.

To do any of this the module needs your **1Pass API credentials** — a publishable
key and a secret key from your 1Pass account. These are configured in the admin
UI and, because one of them is a secret, must be stored securely rather than
committed to code. The module depends on core's **User** and **Views** modules,
and Display Suite is recommended for the truncation field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your 1Pass keys, choose the
   test or live environment, and turn on the paywall.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → OnePass**
(`/admin/config/content/onepass`), where you enter your publishable and secret
keys and choose the environment. See [Configuration](configuration/index.md).

## How to use it

The typical flow, once your keys are in place:

1. Sign up at [1pass.me](https://1pass.me/) and get your publishable and secret
   keys (enter your email on their site to obtain them).
2. Enter the keys on the OnePass settings form and save.
3. To sell (or gate) a piece of content, edit the relevant **content type** and
   enable it for 1Pass integration (and, if you want automatic truncation,
   configure the virtual Display Suite field there too).
4. On an individual node, tick the 1Pass checkbox and insert the `[1pass]`
   shortcode in the body at the point where the article should be truncated and
   the 1Pass button injected.

The module's `onepass_atoms` Atom feed keeps 1Pass up to date automatically — it
refreshes whenever you update your site, and the feed is restricted so it can only
be read by 1Pass's servers.
