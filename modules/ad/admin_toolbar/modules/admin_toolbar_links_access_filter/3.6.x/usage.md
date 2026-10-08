Admin Toolbar Links Access Filter hides admin menu links a user has no access to, working around the fact that the "Use the administration pages and help" permission otherwise reveals links the user cannot follow. Deprecated from Drupal 10.3 onward (core now handles this).

---

This small submodule implements `hook_preprocess_menu()` to remove administration menu links that the current user lacks permission to reach, so non-superadmin roles granted broad toolbar access don't see a cluttered menu full of dead-end links. It was useful before Drupal core improved admin menu access filtering; as of Drupal 10.3 the behavior is handled by core and the module is marked deprecated (see the issue linked in its info.yml). It has no configuration, no permissions, and no services — it is purely a preprocess hook. It depends on the base Admin Toolbar module. New sites on Drupal 10.3+ should not install it.

---

- Hide admin menu links a role cannot access to reduce clutter (pre-10.3).
- Prevent editors from seeing configuration links they can't open.
- Clean up the toolbar for roles with the broad "Use administration pages" permission.
- Avoid confusing users with links that lead to access-denied pages.
- Retrofit older Drupal 9 / early-10 sites with per-permission menu filtering.
- Serve as a reference for how to filter menu items in a preprocess hook.
- Retire in favor of core's built-in filtering on Drupal 10.3+.
