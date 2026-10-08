Views Role Based Global Text adds role-based visibility to the Views "Global: Text area" area handler, so a header/footer/empty text block can be shown to (or hidden from) selected user roles.

---

The module swaps the class behind the core Views `text` area plugin (via
`hook_views_plugins_area_alter()`, pointing it at `RoleBasedGlobalText`, which extends core's
`Text` area handler). This adds a **Roles** fieldset to the Global: Text area configuration
form with a "Select Roles" checkboxes element and a "Negate" checkbox. At render time it
compares the current user's roles against the selected roles: if no role is selected the text
shows to everyone (unchanged behaviour); if roles are selected and not negated, only users
with one of those roles see the text; if roles are selected and negated, everyone **except**
those roles sees it. The selection is stored in the view's area handler options
(`roles_fieldset.roles` and `roles_fieldset.negate`). It works anywhere the Global: Text area
is used — header, footer, empty text — on any display, with no permissions, config schema, or
settings page of its own. Because it only overrides the area plugin class, existing Global:
Text areas keep working and simply gain the extra role controls.

---

- Show a promotional banner in a View header only to anonymous users.
- Hide an internal note in a View footer from anonymous visitors (negate anonymous).
- Display a "you have no results" empty-text message tailored to a specific role.
- Show editor-only instructions above an administrative View listing.
- Present different header text to authenticated vs anonymous users using two text areas.
- Restrict a call-to-action in a View to members of a "subscriber" role.
- Show a compliance/legal notice only to a particular staff role.
- Hide a marketing message from administrators while showing it to everyone else.
- Add role-gated help text to an exposed-filter View.
- Show a "become a member" prompt to anonymous users on a content listing.
- Provide role-specific footer disclaimers on a report View.
- Display beta-feature notices only to a "beta tester" role.
- Show pricing notes only to a "reseller" role in a product View.
- Hide a debugging/notes text area from all but developer roles.
- Give moderators an extra instruction block on a moderation queue View.
- Show onboarding tips in the empty text only to newly-registered role users.
- Present localized announcements to a language-specific editor role.
- Toggle a seasonal banner for a specific role without duplicating the View.
- Keep the default (all users) behaviour by leaving the role selection empty.
- Combine several role-scoped text areas to build a role-aware View header.
- Show a "restricted content below" warning only to roles that can see the rows.
