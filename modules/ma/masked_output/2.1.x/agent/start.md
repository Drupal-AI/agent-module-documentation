<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masked Output — agent index

**Displays fields as masked strings** (e.g. `******9845`). Depends on core `user`. Provides permissions. Version
**2.1.0**. Core `^10||^11`.

**Display-only masking** — the real value is unchanged in DB / entity API / JSON:API / exports / edit form. It is a
**UI convenience, NOT a data-access control**; anyone with data access via another path sees the true value. Use
field access/encryption for genuinely sensitive data.
