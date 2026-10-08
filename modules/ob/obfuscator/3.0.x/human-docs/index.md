# Obfuscator — manual setup guide

**Obfuscator** (`obfuscator`) is a small hardening module that reduces how much a
site tells the outside world about itself. It removes the **Drupal version** from
the HTML source and from HTTP response headers, strips **asset version query
strings** (the `?v=…` on CSS/JS URLs) from the HTML, and — through guidance for
your `.htaccess` — disables the HTTP **TRACE** and **TRACK** methods on Apache. The
aim is to make it a little harder for an attacker to fingerprint exactly which
Drupal version you run and then reach for a matching known‑version exploit.

It is worth being honest about what this does and does not achieve. This is
**security‑through‑obscurity — a marginal, defense‑in‑depth measure, not real
protection**. Obfuscator fixes no vulnerability; a determined attacker can often
still infer the version by other means. The essential control remains keeping
Drupal core and your modules **patched and up to date**. Treat Obfuscator as a
minor add‑on layered on top of actual security maintenance, never as a substitute
for it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which fingerprints to strip on
   the settings form.

## Where it lives in the admin menu

Once enabled, Obfuscator's settings form sits at its admin settings page (the
`obfuscator.admin_settings` route), where you turn each hardening option on or off.
The `.htaccess` change to disable TRACE/TRACK is applied to your Apache
configuration file rather than through the UI — see
[Configuration](configuration/index.md) for the details.
