<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Victoria Bank MIA — agent index

**Drupal Commerce Victoria Bank MIA gateway** (Moldova). Version **1.0.0-rc8**. Core `^10||^11`.

Positive: server-side bank QR status re-fetch (STATUS_PAID) on a DB-stored uuid. NOTE: JWT verification is dead code — relies solely on the re-fetch. Credentials env-backed. Depends on `commerce`, `commerce_payment`.