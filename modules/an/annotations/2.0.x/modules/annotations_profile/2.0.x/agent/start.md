<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Profile (annotations_profile) — agent index

Overlay injection into user account/registration forms for Profile fields. Depends on `annotations`, `annotations_overlay`, `profile`.

## Provides

- **Hooks** `annotations_profile.hooks` (`AnnotationsProfileHooks`, args: `@current_user`, `@annotations_overlay.service`, `@config.factory`, `@renderer`) — a `form_alter` that injects annotation overlay triggers/dialogs for annotated Profile fields onto the user account and registration forms, which the base overlay's entity-form injection does not reach.

## Notes for agents

- No routes, permissions, config, or plugins of its own — a thin bridge. Visibility follows annotations_overlay: `view annotations form overlay`, consume permissions, and per-user type hiding.
- Reuses `AnnotationsOverlayService` + `AnnotationsOverlayTriggerBuilder`; output escaped/server-side rendered as in the base overlay.
