<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

## Views data (`masquerade_field.views.inc`)
`hook_views_data_alter()` adds:
- A **relationship** `masquerade_as_target_id` on `user__masquerade_as` → `users_field_data.uid`
  ("Masquerade as"), so a view can hop from a user to each account they may masquerade as.
- A **field** `masquerade_link` on `users_field_data` (id `masquerade_link`).

## Field handler — `masquerade_link`
`src/Plugin/views/field/MasqueradeLink.php` (`@ViewsField("masquerade_link")`, extends core `EntityLink`):
- `getUrlInfo()`: links to the entity's `masquerade` link template normally, or falls back to
  `canonical` (the profile) when the current user is **already masquerading** (you cannot masquerade
  twice). Handles multilingual translation of the row entity.
- `renderLink()`: renders the parent link but uses `getDisplayName()` as the link text.
- `checkUrlAccess()`: returns `AccessResult::allowed()` **unconditionally** — it does not itself gate
  the link. This is safe because (a) the view that ships it is access-controlled and argument-scoped to
  the current user's own targets, and (b) the switch route the link points at re-validates access in
  `SwitchController::switchTo()` / `masquerade_switch_user_validate()`. The unconditional `allowed()`
  affects only whether the *link is shown*, not whether the *switch succeeds*.

## Bundled view/block — `views.view.masquerade_as` (optional config)
- Provides a **"Masquerade as" block** listing accounts the current user may masquerade as.
- Access: permission `view own masquerade field`.
- Base table `users_field_data`; contextual argument `uid` defaults to **current user**; joined through
  the `masquerade_as_target_id` relationship; filtered to active users (`status = 1`); rendered as an
  HTML list of `masquerade_link` fields, sorted by name. Cache contexts include `user`,
  `user.permissions`, `url`.

Because the argument defaults to the current user and the relationship walks that user's own
`masquerade_as` values, the block only ever lists targets the current user is configured for.
