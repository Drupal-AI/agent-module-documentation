<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Birthday Block (birthday_block) — agent index

A block plugin and a page that list users whose birthday is **today or within the next week**.
Package `Other`. Depends only on core **`user`**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.3. No settings form, **no permissions of its own**, no Drush, no config schema.

- **The block, the page, the query, the install-created fields, theming** →
  [features/block-and-page.md](features/block-and-page.md)

## What it actually is

- One block plugin: `BirthdayBlock` (id **`birthday_block`**, admin label *"Birthday Block"*) in
  `src/Plugin/Block/BirthdayBlock.php`, extending core `BlockBase`. Shows today's birthdays plus
  up to **2** upcoming, with a "View All" link to the page. `#cache max-age = 0` (never cached).
- One route/controller: `birthday_block.birthday_page` → `GET /user/birthday` →
  `BirthdayController::content()` (`src/Controller/BirthdayController.php`), `_permission:
  'access content'`. Renders the full `birthday_list` theme.
- `hook_install` (`birthday_block.install`) creates two **required** user fields: `field_dob`
  (datetime, date-only, label *Date of Birth*) and `field_first_name` (string 255, label *First
  Name*). `hook_uninstall` deletes both field configs + storages.
- `hook_theme` registers `birthday_block`, `birthday_block_item`, `birthday_list` (templates in
  `templates/`). `hook_page_attachments` attaches library `birthday_block/birthday_block`
  (`css/styles.css`) on every page.

## Mechanism (from source)

- Both the block and the controller run the same private `getBirthdaysData()`: a DB `select` on
  `user__field_dob` left-joined to `users_field_data`, with a computed `next_birthday` expression
  (`UNIX_TIMESTAMP(DATE_ADD(... DAYOFYEAR/YEAR math ...))`) filtered by a `havingCondition
  BETWEEN [today, today+1week]`, ordered ascending. No request input feeds the query.
- Rows are bucketed into `today` vs `future`; each row loads the `user` entity to read
  `field_first_name`, `user_picture` (falls back to `user.settings` `picture_default`) and, on the
  page, the canonical profile URL.

## Notes

- No `*.services.yml`, no `config/install`, no `config/schema` — `provides_config_schema` is false
  despite the older stub; the module has no config objects at all.
- The block build renders first name via `#markup` (renderer admin-XSS-filtered); the page renders
  it via Twig auto-escape. See the feature doc for the full data-flow.
