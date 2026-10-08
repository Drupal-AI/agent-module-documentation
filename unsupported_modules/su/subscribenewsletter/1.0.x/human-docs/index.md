# Subscribe Newsletter — manual setup guide

**Subscribe Newsletter** (`subscribenewsletter`) provides a simple newsletter
sign-up form — as both a page and a block — that takes a visitor's email address
and forwards it to an external newsletter API endpoint you configure. It is a thin
bridge between your Drupal site and a third-party email service provider (ESP).

The form itself is minimal: a single required email field, validated with Drupal's
core email validator. When a visitor submits, the module reads your configured
endpoint URL and API key, builds the request URL, and POSTs the email address as
JSON (`{"EMAIL": …}`) to your ESP, then shows a success message and returns the
visitor to the front page. A companion block renders the same form with a title,
description, and logo you set on the admin page, so you can drop the sign-up form
into any region, or link people to the standalone `/subscribenewsletter` page.

The module needs configuration before it does anything useful — you must supply the
endpoint URL and API key on its admin form. It has **no module dependencies** and
no PHP or library requirements.

**Please read these caveats before putting the form live.** They come straight from
how the module works:

- The public sign-up form is reachable by **anonymous visitors** (it is gated only
  by the *access content* permission), and each submission triggers an outbound API
  POST with whatever email was entered. The form does carry Drupal's standard CSRF
  token, but you should add anti-spam — a CAPTCHA or Honeypot — to stop bots from
  driving those outbound calls. There is **no double-opt-in / confirmation step**:
  submissions go straight to your ESP, so make sure that matches what your provider
  expects.
- The **API key is stored in plain module configuration** and appended onto the
  endpoint URL (as `endpoint_url . '&' . API_Key`) rather than sent as a header,
  which means it travels in the request URL. **Use an HTTPS endpoint** so the URL
  (and the key in it) is encrypted in transit, and rotate the key if the URL may
  have been exposed.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the endpoint URL, API key, and
   block appearance, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → (Newsletter) → API**
(`/admin/config/newsletter/api`), behind the *Administer site configuration*
permission. The public sign-up form lives at `/subscribenewsletter`, and the
**Subscribe Newsletter** block can be placed in any region from **Structure → Block
layout**.
