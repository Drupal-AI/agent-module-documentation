# Landingi Landing Pages — manual setup guide

**Landingi Landing Pages** (`landingi_landing_pages`) connects Drupal to
[Landingi](https://landingi.com/), a no‑code landing‑page builder. You design a
marketing landing page in Landingi's builder — no programming required — and this
module pulls it into your Drupal site and serves it there. The link between the two
is Landingi's API, authenticated with an **API key** from your Landingi account.

It's aimed at marketing teams who want the speed of Landingi's drag‑and‑drop
builder but want the finished pages living on their own Drupal domain. The module
supports Drupal 10 and 11.

Because it talks to an external service with a secret key, two things matter for a
safe setup, both covered in the configuration guide: **store the API key securely**
(as an environment variable rather than in committed configuration), and be aware
of a **TLS hardening note** for the version as shipped.

> **Note on the Composer package name.** The project's machine name is
> `landingi_landing_pages`, but its Composer package is **`drupal/landingi`** — use
> that name when you require it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (as
   `drupal/landingi`) and enable it.
2. [Configuration](configuration/index.md) — supply and secure your Landingi API
   key, review the TLS note, and import pages.

## How to use it

Build your landing pages in Landingi as usual. Once you've configured the API key
in Drupal (see [Configuration](configuration/index.md)), you can import those pages
into your site and serve them from your own domain.
