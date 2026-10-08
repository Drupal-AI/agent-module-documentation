<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book Access Code lets you protect core Book content: an administrator creates Access Code entities tied to a book, and visitors must enter a matching code to view that book's node pages. The grant is remembered in the visitor's session.

Use it for gated documentation or member content where you'd rather share a code than manage per-user accounts.

---

Install with `composer require drupal/book_access_code` and enable it (`drush en book_access_code`); it depends on core `book` and `node`.

Create and manage codes at `/admin/structure/book/access_code` (permission `administer access codes`). Configure the access page text at `/admin/config/system/book_access_code/settings`. Users with `bypass book access code checks` skip the gate.

A response-event subscriber intercepts canonical book node views: if the book has active codes and the session holds no matching code, the visitor is redirected to `/book_access` to enter one. Codes are compared with a strict `in_array(..., TRUE)` (no type-juggling). Note the gate only covers the canonical node route - content reachable via other channels (JSON:API, REST, Views) is not gated by this module.

---

- Protect core Book node pages with access codes.
- Let admins define Access Code entities per book.
- Require visitors to enter a valid code to view a gated book.
- Store granted codes in the visitor's session.
- Redirect ungated visitors to the `/book_access` code form.
- Compare codes with strict typing (no `==` juggling).
- Only enforce codes on books that have active codes.
- Provide a `bypass book access code checks` permission.
- Provide `administer access codes` and related CRUD permissions.
- Provide an add/edit/delete UI under `/admin/structure/book/access_code`.
- Offer a settings form for the access page description.
- Use a kernel response subscriber to enforce the gate.
- Trigger the page-cache kill switch when denying access.
- Gate the code-entry form by validating the `bid` query parameter.
- Support multiple valid codes per book.
- Support Drupal 9.2 and Drupal 10.
- Only cover the canonical node route (not JSON:API/REST/Views).