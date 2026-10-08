<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Not Role adds a condition plugin (`user_not_role`) that passes when the current user does **not** have any of the selected roles — the inverse of core's "User Role" condition.

---

Drupal's condition system drives block visibility (and any other condition consumer: Layout Builder sections, Page Manager, Rules-style checks). Core ships a "User Role" condition that expresses only the positive case: show this to users who **have** role X. The negative — show this to everyone who is *not* an editor, hide an upgrade prompt from members, offer a trial banner to people **without** the premium role — has no first-class expression, and the workarounds are poor: enumerating every other role (and remembering to update the list whenever a role is added, which nobody does), or rendering the block and hiding it with CSS (which is not a condition at all and still ships the markup). User Not Role closes that gap with one plugin. Its `evaluate()` takes `array_intersect(configured_roles, $user->getRoles())`: an **empty** intersection means the user has none of the selected roles, so the condition returns TRUE; a non-empty intersection returns FALSE. The standard "Negate the condition" checkbox flips the result, so the same plugin can also express "the user **can be** one of these roles." Selecting no roles evaluates to TRUE for everyone (no restriction). Two things worth internalising. First, a condition is **visibility, not access**: a block hidden by this condition is genuinely not rendered, but the content it would have shown is still reachable wherever else it lives — this governs presentation, never confidentiality. Second, the condition correctly narrows its cache context from `user` to `user.roles`, so a per-role visibility result is not leaked across users with different role sets. Anonymous visitors have only the `anonymous` role, so "does not have role X" is true for them — usually intended, occasionally not, so check it against intent. Requires Drupal core `^11.3 || ^12`; no external dependencies.

---

- Show a block only to users who do **not** have a specific role.
- Hide a members-only upgrade prompt from users who already have the member role.
- Offer a "go premium" banner exclusively to non-premium users.
- Show onboarding or a signup nudge to users lacking any assigned role.
- Combine with core's "User Role" condition to show a block to role A **except** those who also have role B.
- Hide staff-only notices from staff while showing them to everyone else.
- Display a trial-conversion message to users without the subscriber role.
- Target role-absence messaging without enumerating every other role.
- Express tiered-membership visibility (show to lower tiers, hide from the top tier).
- Negate the condition to reuse it as an inclusive "user can be one of these roles" check.
- Hide editor tooling blocks from non-editors while keeping them off for editors' public view.
- Show a "complete your profile" prompt to users who have not yet earned a role.
- Gate a promotional block so it disappears once a user gains the target role.
- Use in Layout Builder or Page Manager anywhere a condition plugin is accepted.
- Show a block to authenticated users who are not administrators.
- Present a feedback survey only to users outside a beta-tester role.
- Drive role-based A/B content by excluding a treatment role.
- Keep a "join our program" call-to-action away from existing participants.
- Rely on `user.roles` cache variance so the negated result is cached correctly per role set.
- Provide a maintainable alternative to CSS-hiding a block from a role.
