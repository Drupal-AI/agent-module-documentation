<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js Tag Revalidator — agent index

**Cache tag-based revalidation for Next.js ISR pages**. Depends on `next`. Version **1.0.1**. Core `^10||^11`.

Decoupled/integration — calls the Next.js **revalidation webhook** (egress) protected by a **shared secret** (store
securely — env/Key, HTTPS); no access role.
