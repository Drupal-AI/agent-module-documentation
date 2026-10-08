<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term Reference (term_reference) — agent index

**Adds a References tab to taxonomy term pages to manage entities that reference the term via an entity-reference field.**

- **Version:** 1.0.x (from 1.0.0-alpha1)
- **Core:** ^10 || ^11
- **Dependencies:** field, taxonomy
- **Route:** `term_reference.references` → `/taxonomy/term/{taxonomy_term}/references/{field}` (admin route, local task)
- **Access:** `TermReferenceForm::access` → requires `taxonomy_term.update` AND `fieldAccess('edit')` on the reference field (`TermReferenceManager::accessReference`)
- **Services:** `term_reference.discovery`, `term_reference.manager`
- **Security:** Route uses a custom access handler that combines term-update and field-edit access — no `_access: TRUE`, no anonymous mutation. Reference changes call `$entity->save()` only after access checks pass. No security findings.
