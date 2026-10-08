<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Fallback allows configuring a fallback field, so when a field is empty another field's value is used in its place.

---

Content sometimes leaves a field empty where a sensible default exists elsewhere — an empty summary that could fall back to a trimmed body, an empty image that could use a category default. Field Fallback lets a field fall back to another field's value when empty. It is a display/content convenience with no security surface — the fallback value is another field on accessible content, subject to its own access. Confirm the fallback source is appropriate and that its access matches (a fallback should not surface a field the user could not otherwise see, though in practice fallbacks are within the same entity).

---

- Fall back to another field.
- Use a default when a field is empty.
- Configure a fallback field.
- Fill an empty summary from the body.
- Use a category default image.
- Provide field fallbacks.
- Confirm the fallback source.
- Match fallback access.
- Handle empty fields.
- Set sensible defaults.
- Fall back gracefully.
- Configure per field.
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