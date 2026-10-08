<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth Claims — agent index

Adds **Claim** config entities (`/admin/structure/claims`, `administer claims`) mapping user fields to OIDC/private JWT claims, injected via `hook_simple_oauth_private_claims_alter`/`_oidc_claims_alter`. Depends on `simple_oauth`. Version **1.0.11**, core 9.3/10.

Security note: enabled claims are added for the token's user irrespective of client/scope — a misconfigured claim can leak a user field to every client. Admin-configured (not a code vuln). Routes correctly gated by `administer claims`.