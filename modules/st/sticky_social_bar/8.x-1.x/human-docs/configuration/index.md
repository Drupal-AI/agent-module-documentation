# Configuration

Sticky Social Bar has two parts to set up: the **settings form** (which channels
and options the bar offers) and the **block** (where the bar appears). This page
covers the settings form; block placement is described in
[Installation](../installation/index.md).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Sticky Social Bar**, or navigate directly to
   `/admin/config/media/sticky-social-bar`.

## What you can set

- **Social channels** — enable or disable each supported social network
  individually (for example Facebook, X/Twitter, LinkedIn, and so on). Turn on only
  the channels that matter to your audience; anything you leave off will not appear
  in the bar.
- **Share options** — the form exposes the bar's options, including whether it
  shares the **current page** URL or an **arbitrary/other** URL, so you can point
  the share links at the page a visitor is on or at a fixed campaign URL.
- **Tokens** — where the form accepts a URL or share text, you can use **Token**
  replacements to build the value dynamically from field and entity data.

## Save

Click **Save configuration**. Then make sure the **Sticky Social Bar** block is
placed in a region (see [Installation](../installation/index.md)) and reload a
page to confirm the enabled channels appear in the bar.

## Styling and markup

The bar's appearance comes from the module's own CSS library. If you want to
restyle it, override those styles in your theme; to change the markup itself, copy
and override the module's Twig template in your theme.
