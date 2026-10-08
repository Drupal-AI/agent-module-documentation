<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled User Form (lupus_decoupled_user_form) — agent index

Submodule of **lupus_decoupled**. Exposes Drupal's **login and password-reset** forms to the front
end via `lupus_decoupled_form`. Version **1.5.1**. Core `^10 || ^11`.

Keeps **core's flood control** and **core's one-time reset tokens** — the things a bespoke
authentication endpoint silently loses.

**Two deployment questions to raise:**

1. **Session across origins** — cookies must work across a different front-end origin. That is a
   CORS-credentials and cookie-attribute decision, not the module's.
2. **What the front end caches** — caching a personalised response in a shared cache is the
   classic decoupled leak.