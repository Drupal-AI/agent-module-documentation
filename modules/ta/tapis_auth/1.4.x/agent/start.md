<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TAPIS Auth — agent index

**Implements TAPIS authentication for Drupal** (OAuth/JWT tokens per tenant). Depends on `tapis_tenant`. Provides
permissions. Version **1.4.1-beta2**. Core `^10||^11`.

Authentication/integration foundation — holds **TAPIS access tokens/credentials** (sensitive secrets — store via
Key/env, never commit, protect tokens; HTTPS). Own permissions.
