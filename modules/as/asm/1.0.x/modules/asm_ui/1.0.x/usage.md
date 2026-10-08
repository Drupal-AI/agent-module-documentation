<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
asm_ui adds the administrative UI (listing plus add/edit/delete forms) for managing the Avoid sending mail (asm) blocklist of email addresses.

---

The base `asm` module defines the `asm_email_blocked` content entity and blocks mail, but ships no interface. asm_ui supplies one: via `hook_entity_type_alter()` it attaches a list builder, an HTML route provider, and add/edit/delete form handlers to the entity, and registers link templates under `/admin/config/people/mail-blocked`. A menu link ("Emails Blocked", under the People admin index) and an "Add email" action link surface the pages. The collection page shows a table of blocked addresses (ID, mail, reason, created) with a total count; the add/edit form saves an address and returns to the collection with a status message; delete uses core's confirm form. All pages are gated by asm's `administer asm email blocked` permission — asm_ui declares no permissions of its own. Depends on `asm`; supports Drupal 10 and 11.

---

- Provide a point-and-click admin page for the mail blocklist.
- Add a new blocked email address through a form.
- Record a reason note when blocking an address.
- Edit an existing blocked address or its reason.
- Delete a blocked address via a confirm form.
- Review all blocked addresses in a sortable admin table.
- See the created date of each blocked address.
- See a running total of how many addresses are blocked.
- Reach the listing from the People admin menu ("Emails Blocked").
- Use the "Add email" action link on the collection page.
- Manage the blocklist without writing code or drush.
- Keep the base asm module UI-free where only programmatic blocking is wanted (leave asm_ui disabled).
- Restrict blocklist management to trusted admins via `administer asm email blocked`.
- Land back on the collection page after each add/edit save.
- Get a status message confirming each create/update.
- Support Drupal 10 and 11.
