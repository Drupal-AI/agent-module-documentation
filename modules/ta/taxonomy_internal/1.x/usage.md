<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Internal allows taxonomy vocabularies to be marked as internal, hiding them from certain user-facing contexts while keeping them for internal categorisation.

---

Some vocabularies are for internal organisation (a workflow tag, an editorial category) and should not appear in public-facing contexts. Taxonomy Internal lets a vocabulary be marked internal. The consideration is what 'internal' actually enforces: if it hides the vocabulary from selection/display UIs but the terms are still exposed elsewhere (a term page, a field value in JSON:API), then 'internal' is a UI/organisational hint, not access control — internal terms could still be discoverable. Confirm whether marking a vocabulary internal removes it only from certain UIs or actually restricts access to its terms; do not rely on 'internal' to keep term data confidential unless it enforces access. For organising vocabularies out of the way it is useful; for hiding sensitive term data, verify enforcement.

---

- Mark a vocabulary internal.
- Hide a vocabulary from public UIs.
- Keep a vocabulary for internal use.
- Organise editorial tags.
- Remove a vocabulary from selection.
- Confirm what internal enforces.
- Don't rely on it for confidentiality.
- Verify term-access enforcement.
- Hide workflow vocabularies.
- Keep internal categorisation.
- Tidy the vocabulary list.
- Check terms aren't exposed elsewhere.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.