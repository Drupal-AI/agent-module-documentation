# AutoPlay Auto Integration — manual setup guide

**AutoPlay Auto Integration** (`autoplay`) forwards **Webform** submissions to
AutoPlay's automotive dealership lead‑management platform. It is aimed at car
dealerships: when a visitor completes an enquiry or test‑drive request form, the
submission is turned into an AutoPlay lead and delivered to AutoPlay's Lead API, so
enquiries land in the dealership's CRM without anyone re‑keying them.

Technically, the module adds a **Webform handler** you attach to a form. When a
submission is saved, the handler maps the submitted values onto an AutoPlay lead and
sends it to the configured AutoPlay endpoint over SOAP (using PHP's `SoapClient`
against a WSDL URL). AutoPlay provides a **sandbox** endpoint for testing and a
**production** endpoint for go‑live. A queue worker is available so leads can be
delivered in the background rather than during the request.

A settings form stores the default DealershipId and endpoint, and delivery uses the
HTTPS WSDL so lead data (which includes customer PII) travels over TLS. Keep the
production HTTPS WSDL configured for live traffic. The settings form is
permission‑gated, and the module exposes no inbound or anonymous endpoints of its
own — it only sends data outward to AutoPlay.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Webform) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — set the default DealershipId and
   endpoint, then add the handler to a form and map fields.

## Where it lives in the admin menu

The settings form is at **Configuration → System → AutoPlay**
(`/admin/config/system/autoplay`). The lead‑delivery behavior itself is added
per form, as a handler under each Webform's **Settings → Emails / Handlers**.
