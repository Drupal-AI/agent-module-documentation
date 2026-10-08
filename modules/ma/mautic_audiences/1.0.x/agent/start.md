<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic Audiences — agent index

**Mautic segment/tag audience personalisation** (LB/block conditions, Views filter, Twig, tokens, JS API). Version **1.0.0**. Core `^10.3||^11`.

**SECURITY (1.0.0):** `/mautic-audiences/webhook` verifies HMAC with `hash_equals()` when a secret is set, but BYPASSES the check when `webhook_secret` is empty (the default) → anonymous can trigger contact refreshes (bounded; re-fetches from Mautic). Set a secret. Depends on `advanced_mautic_integration`.