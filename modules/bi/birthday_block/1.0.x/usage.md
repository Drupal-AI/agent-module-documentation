Birthday Block adds a block and a `/user/birthday` page that list users whose birthday is today or within the coming week.

---

Birthday Block is a small user-engagement module for community and intranet sites. On install it creates two required user fields — `field_dob` (Date of Birth) and `field_first_name` (First Name) — which the admin must enable on the user *Manage form display* so members can enter them. It then provides a `birthday_block` block plugin that renders today's birthdays and up to two upcoming ones (each with first name, user picture and date), plus a "View All" link to the full listing page at `/user/birthday`. Both the block and the page share a database query that computes each user's next birthday from `field_dob` and keeps only those falling between today and one week out. The module has no settings form, no permissions of its own, and no Drush commands; uninstalling it removes the two fields it created.

---

- Show a "birthdays this week" block in a sidebar on an intranet or community site.
- Greet members whose birthday is today with a "Today" badge in the block.
- List up to two upcoming birthdays in the block and link to the full page for the rest.
- Give staff a `/user/birthday` page listing everyone with a birthday today or in the next 7 days.
- Collect each member's date of birth via the auto-created required `field_dob` user field.
- Collect a display first name via the auto-created required `field_first_name` user field.
- Show each celebrant's uploaded user picture (falls back to the site default picture).
- Link each name on the page to that user's canonical profile.
- Order upcoming birthdays soonest-first.
- Place the block through *Structure → Block layout* on any theme region.
- Restrict who sees the block using standard core block visibility conditions (role, path, etc.).
- Seed the fields on an existing site, then bulk-import members' dates of birth.
- Run a lightweight "who to congratulate this week" HR/office widget.
- Drive a Slack/email reminder workflow by reading the same `/user/birthday` listing.
- Theme the output by overriding `birthday-block.html.twig`, `birthday-block-item.html.twig` or `birthday-list.html.twig`.
- Restyle via the module's `css/styles.css` (attached site-wide as the `birthday_block/birthday_block` library).
- Remove the birthday fields cleanly by uninstalling the module.
- Support Drupal 10 and 11 with only core User as a dependency.
