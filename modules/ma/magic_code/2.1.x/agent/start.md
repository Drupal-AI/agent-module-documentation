<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magic Code — agent index

A **passwordless "magic code" authentication/verification system**. Depends on `consumers`, `verification`
(`magic_code_email_login`, `magic_code_verify_form` submodules). Version **2.1.0**. Core `^10.3||^11`.

Authentication — **carefully built**: CSPRNG codes (`random_int`), **expiry + single-use status**, and
**flood-protected** verification (independent IP + per-user limits, checked before lookup, ~50/hr/IP), scoped to
user+email+operation+client. Brute force well-mitigated.
