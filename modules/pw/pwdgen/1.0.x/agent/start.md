<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Generator (pwdgen) — agent index

Generates **memorable passwords from one or more words** (symbol/case variation). Drush commands. Config at
`pwdgen.admin_settings`; provides permissions. Version **1.0.9**. Core `^10||^11`.

Randomness is **sound** — uses PHP `random_int()` (CSPRNG) for selection (proper entropy); minor: `shuffle()`
reordering is non-crypto but the entropy is in the selection. Strength depends on configured length/
complexity. No access role.
