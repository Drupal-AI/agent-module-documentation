# IP Condition — manual setup guide

**IP Condition** (`ip_condition`) adds a **condition plugin** that evaluates the
current visitor's IP address. In Drupal, condition plugins are the reusable rules
behind things like block visibility — so with this module installed you can show
or hide a block (or drive any other condition‑aware behavior) depending on the
visitor's IP. A common use is distinguishing internal from external visitors:
show an "intranet" block only to office IPs, for example.

It's a small, focused module: it provides the condition and nothing else — no
settings page of its own, no permissions. You configure it wherever conditions
are used, most commonly on a block's visibility settings.

One important boundary to understand: this controls **visibility, not access
control**, and the client IP is **not a trustworthy security boundary**. The IP
comes from the request and honors the `X-Forwarded-For` header, so it can be
spoofed unless you've correctly configured trusted reverse proxies. Never use
IP‑based visibility to protect sensitive content or capabilities — someone who
spoofs an IP would simply see the "hidden" block. Treat it as a convenience for
tailoring what different audiences see, not as a lock.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

IP Condition has **no configuration page** — it exposes a condition you use from
other UIs (most often block visibility), described in "How to use it" below.

## Where it lives in the admin menu

IP Condition adds no admin page of its own. You use its condition wherever Drupal
offers condition settings — most commonly at **Structure → Block layout**
(`/admin/structure/block`) when you place or configure a block.

## How to use it

1. Go to **Structure → Block layout** and place or edit a block.
2. In the block's configuration, open the **Visibility** settings.
3. Find the **IP address** condition provided by this module and enter the IP
   address(es) or range the block should apply to.
4. Choose whether to show the block for those IPs or to negate the condition
   (hide it for them), and save.

The block now appears or hides based on the visitor's IP. Remember this is
cosmetic targeting, not protection — see the security note above.

## A note on accuracy and trust

Because the condition reads the request's client IP, make sure Drupal's
**trusted‑proxy** settings in `settings.php` are correct if your site sits behind
a proxy or CDN — otherwise the IP it sees may be the proxy's, or a spoofed value.
