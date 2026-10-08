# Configuration

Before you can translate anything, the Node.js translation service must be running (see
[Installation](../installation/index.md)) and Drupal must know where to reach it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Regional and language → Node.js Translate**, or navigate
   directly to `/admin/config/regional/nodejs_translate`.

## Service host / IP address

If your Node.js service runs on the same server as Drupal, the default settings usually
work. If you run it on a **separate/external server**, update the **IP address** on the
form to point at that host.

Node.js Translate supports **multiple hosts**. When you configure more than one, the
module uses them **one after another in turn** — so spreading translation across several
Node.js services (on different IP addresses) lets you reduce the delay between
translations and share the load.

## Delay between requests

The form lets you set a **delay time** between requests. Tune it to the content you are
translating:

- **Increase** the delay for long texts, to give each request time to complete and to
  be gentler on the endpoint.
- **Decrease** the delay for short texts such as taxonomy term names, so bulk runs
  finish faster.

## No API key to store

Unlike paid translation providers, this module needs **no API key or secret** — the
Node.js service reaches Google Translate's public page directly, and Drupal only needs
the service's host address(es). There is therefore no key to keep in an environment
variable or a Key entity; the host/IP and delay values are ordinary configuration.

## What leaves your site (egress and terms of service)

Be deliberate about this before translating real content:

- The text you translate is sent **from Drupal to your Node.js service**, and from
  there **on to Google Translate's public web page**. Content therefore leaves your
  server and reaches a third party.
- **Do not send sensitive or confidential content** through it.
- The approach relies on an **unofficial, free endpoint and is against Google's terms
  of service**. Treat the module as suitable for learning or personal/pet projects
  rather than production workloads, as the maintainers themselves note.

## Language code mapping (for developers)

If your Drupal language codes don't match the ISO‑639 codes Google expects, implement
`hook_nodejs_translate_languages_alter()` to map them (for example `zh_hans` → `zh`).
This lives in code rather than on the settings form.
