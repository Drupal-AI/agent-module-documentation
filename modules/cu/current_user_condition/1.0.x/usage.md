Adds a condition plugin that is true when a visitor is viewing their own user profile page (the user canonical route).

---

Current User Profile Condition ships a single core Condition plugin (`current_user_condition`, label "Current users profile") that plugs into Drupal's condition/visibility system. When its "Is the current authenticated users profile page" checkbox is enabled, the plugin evaluates true only when the current route is `entity.user.canonical` and the `user` route parameter matches the currently logged-in account — i.e. the visitor is on their own `/user/{uid}` profile page. When the checkbox is left off, the condition always evaluates true (no restriction). The plugin can be negated like any condition, adds the `user` cache context when active, and requires no configuration UI of its own beyond the checkbox exposed wherever conditions are configured (block visibility, and any module that consumes condition plugins). It depends only on core `user` and provides config schema but no routes, permissions, services, or Drush commands.

---

- Show a block only on the logged-in user's own profile page (block visibility → "Current users profile").
- Hide a block on the logged-in user's own profile page by negating the condition.
- Display a "Edit your profile" or "Account settings" shortcut block only when a user is on their own profile.
- Show a personalized welcome/greeting block exclusively on the viewer's own `/user/{uid}` page.
- Restrict a "Your recent activity" block to the owner's profile view only.
- Present profile-completion prompts to the account owner while they view their own profile.
- Gate a call-to-action (upload avatar, verify email) to the owner's own profile page.
- Combine with other visibility conditions (roles, pages, request path) to fine-tune block placement on profile pages.
- Drive Layout Builder or any condition-aware component to vary output on the owner's own profile.
- Show contextual help or onboarding tips only when users land on their own profile.
- Differentiate the owner's view of a profile from another visitor viewing the same profile page.
- Surface private/self-only widgets (notifications, saved items) on the owner's profile only.
- Hide "Add friend"/"Follow" style blocks when the viewer is looking at their own profile.
- Show a "This is your public profile" notice to the account owner.
- Build self-service dashboards keyed to the owner's own canonical user page.
- Use the condition in custom code or other contrib that evaluates condition plugins, not just block visibility.
- Toggle promotional or upsell blocks specifically on the account holder's own profile.
- Apply the negated condition to show something everywhere except the viewer's own profile page.
- Keep block cache correctness automatically via the added `user` cache context when the condition is active.
- Support Drupal 9, 10, and 11 sites needing "is this my own profile" as a reusable visibility rule.
