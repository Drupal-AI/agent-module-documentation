<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Context Profile Role adds a "User Profile Role" condition plugin plus a context provider so blocks (or any condition consumer) can be shown or hidden based on the roles of the user whose profile page is being viewed.

---

A context provider (`UserProfileRouteContext`) reads the `user` route parameter on user/profile routes and exposes it as a `user_profile` entity context, cached per route. The condition plugin (`UserProfileRole`) offers a checkboxes list of all site roles and, in `evaluate()`, returns TRUE when the viewed profile user has any of the selected roles (an empty selection matches all when not negated). This is a display-time visibility test only: it evaluates the roles of the profile owner shown in the URL, not the roles of the current viewer, so it neither grants nor changes any permissions.

The module is small (a context provider, a condition plugin, a config schema for the plugin's `roles` sequence) and autowires its services. Typical use is to place a block on `/user/{uid}` pages that only shows for profiles belonging to, say, editors or premium members.

---

- Show a block only on profile pages of users with a given role.
- Hide a block on profiles of a given role (via condition negation).
- Match several roles at once (any-of logic).
- Add a "premium member" call-to-action only on premium members' profiles.
- Display editor/author bio widgets only on staff profiles.
- Use the provided `user_profile` route context in other context-aware plugins.
- Drive Context/Block layout visibility off the viewed account's roles.
- Show admin-only tools on admin profiles.
- Keep visibility cached correctly per route (route cache context).
- Combine with other block visibility conditions for fine-grained placement.
- Target the profile owner's roles rather than the current viewer's.
- Configure the role set through the standard condition config form.
- Apply to any route exposing a `user` parameter, not just canonical profile pages.
- Leave roles empty to always match (unless negated).
- Summarise the condition human-readably in the block config UI.