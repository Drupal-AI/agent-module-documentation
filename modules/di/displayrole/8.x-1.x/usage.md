Display Role adds a configurable "Roles" element to the user profile display so a user's assigned roles can be shown on their profile page.

---

Display Role is a small, dependency-light module (core `user` only, no routes/permissions/services/plugins) that exposes a user's roles as a pseudo-field on the user entity's view display. Once enabled, a "Roles" component appears on People » Account settings » Manage display (`entity.entity_view_display.user.default`); dragging it into the visible region makes each user's roles render as an item list on their profile. Because the element is part of the user display build (`displayrole_user_view()`), the roles are also available through the `user.html.twig` template without a custom preprocess function. An optional, UI-less configuration flag `displayrole.settings:append_role_to_username` additionally appends the role list in parentheses to every rendered username via `displayrole_preprocess_username()`. Role labels are rendered through core's `item_list` theme (HTML-escaped). The module is intentionally minimal: it currently shows all roles a user has and offers no per-role selection.

---

- Show a user's assigned roles on their profile page without custom theme code.
- Add a "Roles" row alongside core profile elements like "Picture" and "Member for".
- Position roles above or below other user display components by drag-and-drop on Manage display.
- Give site editors a quick visual indicator of which users are moderators, editors, or admins (on trusted, access-controlled profile pages).
- Surface membership "badges" (e.g. a "Member" or "Subscriber" role) on member profiles.
- Expose roles to Twig via the user display so a themer can style or reposition them in `user.html.twig`.
- Render roles as a semantic item list that inherits the site's list styling.
- Provide a role display on a specific view mode by enabling the "Roles" component only on that mode.
- Hide the roles element again by moving the "Roles" component to the "Disabled" region on Manage display.
- Let a themer target the `item_list__roles` theme hook to customize the roles markup.
- Append roles in parentheses after usernames site-wide by setting `append_role_to_username` in `displayrole.settings`.
- Use `drush config:set displayrole.settings append_role_to_username 1` to toggle the username-append behavior (no admin UI ships for it).
- Show roles on community/directory sites where role membership is intentionally public.
- Distinguish staff from members on a members-only intranet profile page.
- Communicate a contributor's standing (e.g. "Maintainer") on a public contributor profile.
- Configure the display per user account view mode when combined with core view modes.
- Provide a lightweight alternative to writing a custom `hook_entity_extra_field_info()` / `hook_user_view()` pair yourself — the module implements both.
- Combine with core field access and "access user profiles" permission to scope who can see profiles that carry the roles element.
- Use on sites migrating from Drupal 7 where a role indicator on profiles is expected.
- Prototype a role-badge feature quickly, then replace with a more configurable solution later.
- Display roles for QA/staging verification that role assignments imported correctly.
