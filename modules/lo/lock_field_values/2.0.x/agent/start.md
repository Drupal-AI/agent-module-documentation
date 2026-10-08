<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lock Field Values — agent index

Lets admins/editors **lock field values** so non-authorized users can't change them (protect a price/legal
field/slug from accidental/unauthorized edits). Depends on core `field`; provides permissions. Version
**2.0.2**. Core `^8||^9||^10||^11`.

Content-integrity/field-level control — restricts **editing** of the locked field (enforced on edit form/
field access); governs who may **change** (not view) the value. Grant lock/unlock to the right roles;
complements normal field/entity access.
