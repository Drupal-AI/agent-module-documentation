<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unwanted Email Registration — agent index

Blocks **duplicate/abusive registrations that game emails with dots/spacers** (the Gmail dot trick —
`u.ser@gmail` == `user@gmail` — so one person can't farm "different" accounts). Config at
`unwanted_email_registration.settings`; provides permissions. Version **1.0.5**. Core `^8||^9||^10||^11`.

**Security/anti-abuse-positive** — closes a signup-abuse loophole (account farming/promo abuse). Configure the
normalization to match your policy. No access role beyond permission.
