# Pinterest Hover Button — manual setup guide

**Pinterest Hover Button** (`pinterest_hover`) adds Pinterest's "Pin It" button
to the images on your site. When a visitor hovers over an image, a small Pinterest
button appears over it, so they can save (pin) the picture straight to one of their
Pinterest boards. It is a good fit for image-heavy sites — recipe sites, galleries,
product pages, blogs — where you want visitors to share your visuals on Pinterest.

Under the hood the module loads Pinterest's own `pinit.js` widget script from
Pinterest's CDN and lets you control how the button looks (size, shape, colour),
where it appears (all pages, or only certain content types), and which images to
leave alone (via CSS selectors). It also patches responsive-image markup so the
button can find the correct image URL to pin.

Because the button relies on a third-party script loaded from Pinterest, that
external request is a privacy consideration: visitors' browsers contact Pinterest
whenever the script loads. If your site has a privacy policy or a cookie/consent
banner, mention this third-party integration there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   button appearance, per-content-type targeting, and image exclusions.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → Pinterest Hover**
(`/admin/config/pinterest-hover/config`). You need the **Administer site
configuration** permission to open it. There are no other admin pages — everything
the module does is controlled from that one form.
