<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Profile injects annotation overlays into user account and registration forms for Profile fields.

---

Annotations Profile is a small bridge between annotations_overlay and the contrib Profile module. Profile fields render on the user account and registration forms (not on a separate profile entity form), so the base overlay's entity-form injection does not reach them. This module's `AnnotationsProfileHooks` adds a `form_alter` that injects the same annotation overlay triggers/dialogs for annotated Profile fields onto those user forms, reusing `AnnotationsOverlayService` and the shared trigger builder. Requires `profile`, `annotations`, and `annotations_overlay`.

---

- Show annotation overlays for Profile fields on the user account form.
- Show annotation overlays for Profile fields on the registration form.
- Reuse the overlay service and shared trigger builder.
- Give in-context guidance where Profile fields actually appear.
- Respect the viewer's consume permissions and per-user hidden types.
- Honor the `view annotations form overlay` permission.
- Work without changing Profile module behavior.
- Cover Profile fields the base overlay's entity-form injection misses.
- Support editorial/technical/rules notes on profile data.
- Attach guidance to onboarding/registration fields.
- Integrate structurally (no hard assumptions beyond Profile presence).
- Keep output escaped and server-side rendered like the base overlay.
- Complement annotations_webform as another form-context integration.
- Apply to any Profile type's fields that are annotated.
- Trigger dialogs on demand via the native overlay JS.
- Require no additional configuration once installed.
