<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The birthday block, the page, and the install-created fields

## Install & enable

```bash
composer require drupal/birthday_block
drush en birthday_block -y
```

Only dependency is core **`user`**. No sub-modules, no permissions of its own, no Drush commands,
no config objects.

### What install creates (`birthday_block.install`)

`birthday_block_install()` creates two **required** base fields on the **user** entity (bundle
`user`), each only if it does not already exist:

- `field_dob` — type `datetime`, `datetime_type: date` (date only), label *Date of Birth*.
- `field_first_name` — type `string`, `max_length: 255`, label *First Name*.

Both are created with `required => TRUE`. They are **not** auto-added to the user form display, so
after install go to *Configuration → People → Account settings → Manage form display* and enable
the two fields so members can enter values. `birthday_block_uninstall()` deletes both `FieldConfig`
and `FieldStorageConfig` entries — **uninstalling destroys the stored dates of birth**.

## The block plugin

`src/Plugin/Block/BirthdayBlock.php` — `@Block(id = "birthday_block", admin_label = "Birthday
Block")`, extends `BlockBase`, implements `ContainerFactoryPluginInterface`. Injected services:
`database`, `entity_type.manager`, `file_url_generator`, and `config.factory->get('user.settings')`.

Place it via *Structure → Block layout* (or a `block` config entity). `build()`:

- Calls `getBirthdaysData('block')` (the arg is unused).
- **Today** bucket: for each user, an item themed `birthday_block_item` with `[first name (#markup),
  image_style 'thumbnail' of the picture, literal 'Today']`.
- **Upcoming** bucket: only the first **`$no_of_birthdays_to_show = 2`** rows (hard-coded, not
  configurable) as items `[first name, thumbnail, date('d M', next_birthday)]`. If more than 2
  upcoming rows exist, appends a **"View All"** `Link` to `Url::fromRoute('birthday_block.birthday_page')`.
- Returns `#theme => 'birthday_block'` with `#items => ['today' => …, 'upcoming' => …]` and
  **`#cache => ['max-age' => 0]`** (rendered fresh every request).

Picture URL: `user.user_picture` file if set, else
`file_url_generator->generateAbsoluteString(user.settings picture_default)`.

## The page

Route `birthday_block.birthday_page` (`birthday_block.routing.yml`):

```yaml
path: '/user/birthday'
defaults:
  _controller: '\Drupal\birthday_block\Controller\BirthdayController::content'
  _title: 'Users Birthday'
requirements:
  _permission: 'access content'
```

`BirthdayController::content()` returns `#theme => 'birthday_list'` with `#birthdays` =
`getBirthdaysData()`, which here returns `['today' => [...], 'future' => [...]]` where each entry is
`['name', 'profile_url' (entity.user.canonical), 'picture_url', 'birthday' (date('d M'))]`.
(Note: the controller calls `$query->execute()->fetchAll()` twice back-to-back — a harmless
duplicate.)

## The query (`getBirthdaysData()`, identical in block and controller)

```
select user__field_dob dob
  leftJoin users_field_data u ON u.uid = dob.entity_id
  addExpression("UNIX_TIMESTAMP(DATE_ADD(dob.field_dob_value,
     INTERVAL IF(DAYOFYEAR(dob.field_dob_value) >= DAYOFYEAR(CURDATE() - 1),
       YEAR(CURDATE()) - YEAR(dob.field_dob_value),
       YEAR(CURDATE()) - YEAR(dob.field_dob_value) + 1) YEAR)", 'next_birthday')
  fields(dob, field_dob_value); fields(u, uid)
  isNotNull(dob.field_dob_value)
  havingCondition('next_birthday', [today, today + 1 week + 86399], 'BETWEEN')
  orderBy(next_birthday ASC)
```

`$curdate = strtotime('today')`; the window is today 00:00 → +1 week (end of day). All operands are
literal SQL functions or server-computed timestamps bound as placeholders — **no request input is
concatenated** into the SQL. Rows are then split into today vs future by comparing
`date('Y-m-d', next_birthday)` to today. The MySQL-specific `UNIX_TIMESTAMP`/`DATE_ADD`/`DAYOFYEAR`
expression ties this to MySQL/MariaDB.

## Theming

`hook_theme` registers three templates (`templates/`):

- `birthday_block` (`birthday-block.html.twig`) — wraps today/upcoming item lists.
- `birthday_block_item` (`birthday-block-item.html.twig`) — renders `content.0/1/2` (name, picture,
  date).
- `birthday_list` (`birthday-list.html.twig`) — the page: `{{ user.name }}` auto-escaped, picture
  `<img>`, and `<a href="{{ user.profile_url }}">`.

`hook_page_attachments` attaches library `birthday_block/birthday_block` (`css/styles.css`,
`birthday_block.libraries.yml`) on **every** page.

## Operating notes / limits

- "Upcoming in the block" is fixed at 2; the one-week window and the fields (`field_dob`,
  `field_first_name`) are hard-coded — there is **no settings form**.
- The query has no filter on user `status`, so it includes blocked users that have a DOB set.
- The block's `max-age 0` means it is uncacheable; on a large user base the per-request query +
  per-row entity load has a cost.
- To reach the two fields you must enable them on the user form display after install (see above).
