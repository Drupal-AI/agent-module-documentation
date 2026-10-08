<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Partial Access — agent index

**Role-based truncated (paywalled) node body**. Version **1.0.0**. Core `^11`.

**SECURITY (1.0.0):** truncation is HTML-render-only (a `KernelEvents::VIEW` subscriber mutates `body`); no `hook_node_access` → the full 'paid' body is exposed via JSON:API/REST/Views/search. NOT real access control. Depends on core `node`, `user`.