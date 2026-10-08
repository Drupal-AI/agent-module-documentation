# Counter — manual setup guide

**Counter** (`counter`) displays site statistics in a block — total visits, node
count, unique visitors, and the visitor's own IP address. It's the classic "you are
visitor number 12,345" pattern, implemented locally inside Drupal rather than
through an external analytics service. All data is stored in your own database and
counted in real time.

It can count site visits per day (down to the minute or second), distinguish unique
visitors, separate registered from unregistered users, show published vs.
unpublished node counts, and display both the web server's IP and the client's IP.
It keeps a report of client IP, access date, and accessed page, offers per‑day /
week / month / year statistics, and integrates with **Views** so you can build your
own reports from the counter data. To classify visitors accurately (for example, to
tell real browsers from crawlers when counting unique visitors) it uses the
`matomo/device-detector` library, which Composer installs for you.

There are three things worth weighing before putting this on a public site, and
they're worth taking seriously:

- **Privacy.** Counting visitors locally means **recording visitor data**,
  including IP addresses — which is personal data under GDPR. Using it needs a
  lawful basis, a retention plan, and a mention in your privacy notice. "It's just a
  counter" is not an exemption.
- **Proxies and CDNs.** The client IP the module shows will be the *proxy's* address
  unless Drupal's trusted‑proxy settings (`reverse_proxy` and
  `reverse_proxy_addresses` in `settings.php`) are configured. Behind a CDN, an
  unconfigured setup shows the wrong address by default.
- **Page caching.** A counter that writes on every request works against Drupal's
  page cache — you tend to get either an inaccurate count or an uncacheable page.
  Check which happens under anonymous traffic before relying on it.

The module works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   device‑detector library) and enable the module.
2. [Configuration](configuration/index.md) — the counter settings, and the block
   and Views display.

## Where it lives in the admin menu

Counter's settings live under **Configuration → Counter settings**
(`/admin/config/counter`), which has both a basic and an advanced form, all behind
the module's own **`administer counter`** permission. The statistics themselves are
shown via a block placed from **Structure → Block layout**.
