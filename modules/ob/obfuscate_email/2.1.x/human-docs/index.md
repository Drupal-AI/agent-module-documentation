<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscate Email — manual setup guide

**Obfuscate Email** (`obfuscate_email`) hides email addresses from spam
harvesters. It renders each address scrambled on the server — ROT13-encoded, with
`@` and `.` swapped for `/at/` and `/dot/` — and a small piece of JavaScript
reassembles the real, clickable `mailto:` address in the visitor's browser. Real
people see a normal, clickable email; bots reading the raw HTML source see only
gibberish.

There are two ways to use it, and they share the same JavaScript:

1. **A text-format filter** — add the *Obfuscate Email* filter to a text format
   (for example Full HTML). Any `mailto:` link in body/rich-text content authored
   with that format is scrambled on output. You can optionally require visitors to
   click a link before the address is revealed.
2. **A field template** — the module ships a template for any field literally
   named `field_email`, so those fields are obfuscated automatically once the
   module is enabled, with no per-format setup.

It has no admin settings page, no permissions, and no Drush commands — the only
settings live inside a text format's filter configuration. It also provides a
`rot13` Twig filter you can reuse in custom templates.

> **Heads up — JavaScript required.** Because the address is reassembled in the
> browser, visitors with JavaScript disabled never see the email. There is
> intentionally no non-JS fallback.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the filter to a text format and
   set the click-to-reveal options, plus the `field_email` template approach.

## Where it lives in the admin menu

There is no dedicated settings page. The filter is configured on individual text
formats at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). The field-template path needs no admin
navigation — it applies automatically to fields named `field_email`.

## How to use it

- To scramble addresses in rich-text/body content, enable the filter on a text
  format — see [Configuration](configuration/index.md).
- To scramble a dedicated email field, simply name the field `field_email`; the
  module's template takes over once enabled. To customize the markup, override
  `field--email.html.twig` in your theme.
