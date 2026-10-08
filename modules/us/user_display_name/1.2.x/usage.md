<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User display name adds a display name field to user accounts, so the name shown around the site can differ from the username used to log in.

---

Drupal shows the username everywhere a user is referenced — authored-by lines, comment attributions, admin listings — which conflates two different things. The username is a credential-adjacent identifier chosen at registration and often ugly (`jsmith_2019`), sometimes an email address, and on some sites something a user would rather not have published. What should be shown is a display name the user controls. Contrib has answered this for years with Real Name and similar; this module is the small modern version: `src/Hook` alters user display through `hook_user_format_name_alter` so Drupal's own display-name resolution returns the field's value everywhere, with `user_display_name.install` and a `post_update.php` handling the field. It depends only on core `user`, has no routes, permissions or configuration, and its `core_version_requirement` of `^10.1 || ^11 || ^12` already covers Drupal 12. There is a privacy dimension worth naming: if the point of adopting it is to stop usernames being published, check the places Drupal exposes the raw username anyway — the user listing at `/admin/people`, JSON:API and REST responses, and any view that adds the `name` field directly rather than rendering the account.

---

- Show a friendly name instead of a username.
- Let users choose how they are displayed.
- Stop usernames appearing on authored-by lines.
- Show real names on an intranet.
- Hide login identifiers from public pages.
- Display a preferred name.
- Show names in a consistent format.
- Support users whose username is an email.
- Improve readability of comment attributions.
- Let users update their display name.
- Show a professional name on a publication.
- Reduce accidental disclosure of usernames.
- Give staff listings proper names.
- Support name changes without account changes.
- Display names in a directory.
- Improve a community site's presentation.
- Prepare a user field for Drupal 12.
- Keep usernames stable while names change.
