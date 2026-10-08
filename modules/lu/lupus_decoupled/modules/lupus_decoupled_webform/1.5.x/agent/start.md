<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Webform (lupus_decoupled_webform) — agent index

Submodule of **lupus_decoupled**. Webform support via the custom-elements form API.
Version **1.5.1**. Core `^10 || ^11`.

Handlers still run, submissions still store, per-webform access is still Webform's — none of which
survives reimplementing a Webform in the front end.

**Two things to check on any decoupled Webform deployment:**

1. **File uploads** — confirm they land as **managed files with validators applied**, don't assume.
2. **Spam protection** — a form reachable from another origin is reachable by bots. Verify the
   site's CAPTCHA/honeypot works in the decoupled flow; a webform without it will be found.