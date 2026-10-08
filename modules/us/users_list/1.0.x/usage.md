<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Users List creates user-directory lists viewable as pages and blocks.

---

Users List **creates user-directory lists** — several lists of users (alphabetical, newest, by role) viewable
as pages (`/userslist/...`) and blocks. Admin config is gated by `administer site configuration` and the lists
themselves by an **`access users lists`** permission. It depends on core Node and Block, and provides its own
permissions.

Use it to publish member directories. It is a user-engagement/directory feature. Privacy note: it **exposes a
directory of user accounts** (usernames, roles, join dates) to anyone with the `access users lists` permission — so
grant that permission deliberately (a member directory reveals who has accounts, which is often sensitive), and
consider whether the lists should be non-public. It gates access via that permission. Configure the user lists.

---

- Create user-directory lists.
- Show them as pages and blocks.
- List by alpha/newest/role.
- Depend on core Node + Block.
- Provide its own permissions.
- Serve user engagement/directory.
- EXPOSE a directory of user accounts to holders of 'access users lists'.
- Grant that permission deliberately (a directory reveals who has accounts).
- Consider whether the lists should be non-public.
- Gate access via the permission.
- Configure the user lists.
- Handle user lists.
- List users.
- Configure the lists.
- Show directories.
- Handle the display.
- Publish directories.
- List members.
- Restrict the permission.
- Provide user-directory lists.
