<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Query — agent index

A **Twig interface for querying entity data inside templates** (fetch entities in Twig without preprocess/
Views). Depends on core `system`. Version **1.0.8**. Core `^10.1||^11`.

Developer/theming (access-relevant) — base query uses `accessCheck(FALSE)` **+ an access query tag** + `status
= 1` (node **grants** applied at query level like Views; unpublished excluded, full entity access not run).
Keep to **developer-controlled** templates (never expose to untrusted Twig authors); access relies on the
**tag**. No access role of its own.
