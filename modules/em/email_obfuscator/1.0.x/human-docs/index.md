# Email Obfuscator — manual setup guide

**Email Obfuscator** (`email_obfuscator`, also known as the Email Obfuscation
Response Filter) scans your site's rendered output for email addresses and
obfuscates them, to make it harder for automated harvesting bots to scrape
addresses straight from your page markup and reduce the resulting spam. It works
by hooking into each generated response and rewriting the addresses it finds.

It handles two cases. For addresses inside a **`mailto:` link**, it reverses the
address in the markup and adds small inline JavaScript listeners (`onfocus` and
`onmousedown`) that flip it back to the correct address the first time the link is
used — covering left‑click, right‑click, and keyboard focus across browsers. For
**all other addresses** in the text, it inserts a hidden `<span>` containing
invalid characters into the middle of the address, so the visible text reads
correctly to a person but breaks a naive scraper.

It is sensible about **what it skips**: anything that fails PHP's email
validation, everything in the admin back office, addresses inside HTML attributes,
Ajax webform requests, and any routes you whitelist. By default it also adds a
`data-nosnippet` attribute so the hidden filler text does not surface in search
results (note this is officially honoured only by Googlebot).

The most important thing to understand is the **limit**: this is a *deterrent, not
real protection*. The real address still has to reach the browser to be usable, so
anyone viewing source or de‑obfuscating the markup can still get it. It reduces
casual automated harvesting; it does not keep an address private, and it plays no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no admin settings form**. It works automatically once enabled;
the few available tweaks are made in `settings.php`, described below.

## How to use it

Email Obfuscator starts working as soon as it is enabled — every non‑admin
response has its email addresses obfuscated automatically, with no configuration
required.

### Optional tuning in `settings.php`

Two behaviours can be adjusted by adding to your site's `settings.php`:

- **Whitelist (exclude) routes** — no obfuscation happens on the routes you list:

  ```php
  $settings['email_obfuscator'] = [
    'ignored_routes' => [
      'rest.api_layout_footer.GET',
      'editor.link_dialog',
    ],
  ];
  ```

  **Important:** if you use CKEditor 4, whitelist the `editor.link_dialog` route so
  the module does not obfuscate the email inside the CKEditor link dialog.

- **Disable `data-nosnippet`** — the `data-nosnippet` attribute is added by default
  to keep the hidden filler text out of search results. To turn it off:

  ```php
  $settings['email_obfuscator'] = [
    'use_datanosnippet' => FALSE,
  ];
  ```
