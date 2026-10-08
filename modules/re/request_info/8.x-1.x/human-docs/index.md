# Request Info — manual setup guide

**Request Info** (`request_info`) is a tiny helper that adds **request
information to Drupal's status report** page. Its job is to answer one question:
"what does Drupal actually see?" — which is exactly what you need to know when a
reverse proxy, CDN, or load balancer sits in front of your site and rewrites
requests before Drupal receives them.

That gap between what a visitor sent and what Drupal received is where a whole
class of problems lives: the wrong client IP showing up in logs, the wrong scheme
causing mixed-content warnings or redirect loops, the wrong host breaking
absolute URLs, or trusted reverse-proxy settings that don't match your actual
infrastructure. Instead of adding a debug statement or digging through logs,
Request Info puts the details on the status report — where an administrator
already looks when something is wrong with the environment.

It needs no other modules, adds no routes or permissions of its own, and works
across Drupal 8, 9, 10, and 11.

> **Be deliberate about what it displays.** The information it shows is request
> data, and headers can include cookies, authorization values, and forwarding
> chains that reveal internal network structure. The status report is already
> behind the strong **Administer site configuration** permission — but remember
> that this page now carries request detail. **Sanitise before sharing a
> screenshot**, which is exactly what people do when asking for help with an
> environment problem in a support ticket or issue queue.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — once enabled, the information simply appears
on the status report, as described below.

## Where it lives in the admin menu

Request Info adds no menu item of its own. Its output appears on the **status
report** at **Reports → Status report** (`/admin/reports/status`), which requires
the **Administer site configuration** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Reports → Status report**.
3. Read the request-information section to see what request Drupal actually
   received — client IP, scheme, host, and forwarding headers. Use it to verify
   that trusted-proxy settings are correct, that headers are being followed, and
   to diagnose IP/scheme/host issues behind a proxy or CDN.
4. If you need to share the status report for support, **redact** any sensitive
   header values first.
