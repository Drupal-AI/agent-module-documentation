<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled CORS (lupus_decoupled_cors) — agent index

Submodule of **lupus_decoupled**, **hard dependency of the top-level module**. Configures CORS so
a browser-based front end can call Drupal's APIs. Version **1.5.1**. Core `^10 || ^11`.

Shipping a decoupled setup without CORS configured would mean every installation starts broken —
hence the hard dependency.

**Treat it as an access boundary, and say so.** CORS names which origins may read responses using
the visitor's credentials. List the front end's actual origins (production, staging, local) rather
than `*`, review on environment change, and treat "allow credentials" as a separate, equally
consequential switch.

Debugging note: the failure is a **browser console** message, not a server error — a request that
works in curl and fails in the browser is CORS.