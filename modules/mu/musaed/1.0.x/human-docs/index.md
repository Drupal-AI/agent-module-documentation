# Musaed — manual setup guide

**Musaed** (`musaed`) integrates the third‑party **Musaed accessibility tool**
into your Drupal site. Musaed is an accessibility widget that helps make a site
more inclusive for visitors with vision, cognitive, or motor challenges — offering
customizable assistive features while keeping your site's own look and feel. This
module is the glue that loads the Musaed widget onto your pages.

Musaed is a **hosted service**: to use it you need a **subscription on
musaed.co**, which gives you a unique **client ID** to identify your site to the
service. The module itself is free; the functionality behind it comes from the
external Musaed platform. Because of that, enabling this module causes your pages
to **load a third‑party script** from Musaed — so before you turn it on, confirm
the privacy and consent implications for your visitors (for example, whether it
needs to be mentioned in your privacy policy or gated behind a cookie‑consent
mechanism).

The module is an accessibility integration only — it adds the assistant widget and
has **no content or access‑control role** of its own. It supports Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page documented** for this module — its
one real setup step is supplying your Musaed **client ID**, described in "How to
use it" below.

## How to use it

1. **Subscribe on [musaed.co](https://musaed.co)** and obtain your unique
   **client ID** — this is required for the widget to work.
2. Install and enable the module (see [Installation](installation/index.md)).
3. **Provide your client ID** to the module so it can load your Musaed widget.
   Because this ID identifies your subscription, treat it as an account
   credential rather than something to commit into shared code.
4. Confirm the accessibility widget appears on your site's front end, and review
   the **privacy/consent** consequences of loading Musaed's third‑party script
   for your visitors.
