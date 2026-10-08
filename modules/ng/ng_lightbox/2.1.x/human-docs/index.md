# NG Lightbox — manual setup guide

**NG Lightbox** (`ng_lightbox`) opens links in a pop‑up dialog (a "lightbox")
instead of loading a whole new page. You give it a list of paths — for example
`/contact` or `/comment/*/reply` — and any matching link on the site opens in an
overlay right where the visitor is, keeping them on the current page.

What makes NG Lightbox unusual is that it ships **no JavaScript library of its
own**. It reuses Drupal core's built‑in AJAX dialog system: when a link matches
one of your patterns, the module quietly adds the `use-ajax` class and the
`data-dialog-type` attribute that core already understands. That means you get
core's dialog styling and accessibility handling for free, without installing a
third‑party popup library like Colorbox or Magnific Popup.

Matching is path based. You can target internal paths, use `*` as a wildcard,
and NG Lightbox will even match against a page's URL **alias** — so an editor can
turn lightboxing on or off for a page just by changing its alias. You can also
lightbox a single one‑off link by hand: add the CSS class `ng-lightbox` to the
anchor and the module picks it up regardless of your pattern list. Out of the
box the pattern list is empty, so nothing is lightboxed until you configure it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   the path patterns, dialog width, CSS class, admin‑path skipping, and the
   modal‑vs‑dialog renderer.

## Where it lives in the admin menu

Once enabled, NG Lightbox's settings form sits at **Configuration → Media → NG
Lightbox** (`/admin/config/media/ng-lightbox`). Reaching it requires the
**Administer NG Lightbox** permission (`administer ng lightbox`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and add one path per line to the **Paths** field, each
   starting with a `/` — for example `/contact` or `/node/*`.
3. Save. Any link on the site whose path matches now opens in a dialog.

Note that only links Drupal builds through its normal link generator (menu
links, Views "read more" links, `#type: link` render arrays, and so on) are
altered. A link you type by hand directly into a Twig template is not touched —
for those, add the `ng-lightbox` class yourself.
