<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Verify Email — agent index

**Gates parts of the site behind email verification** — emails a magic link (`/verify/{key}/{secret}`) that logs
the user in (creating an account if needed). Provides permissions. Version **1.1.0-alpha1**. Core `^10||^11`.

Authentication — **security-critical**: validates the secret with **`hash_equals`** + checks **expiry** before
`user_login_finalize` (done right). Verify the secret is **CSPRNG + single-use** in your version; the magic link
is a **capability** (deliver securely, short-lived); confirm email-based **auto-account-creation** is intended.
Layers on core auth.
