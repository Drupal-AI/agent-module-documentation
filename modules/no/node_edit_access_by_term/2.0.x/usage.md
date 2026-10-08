<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Edit Access by Term restricts node edit access by taxonomy term using user/role fields on terms.

---

Node Edit Access by Term **restricts node edit access by taxonomy term** — each taxonomy term gets a user/role
autocomplete field listing who may edit nodes tagged with it, so editing a node is limited to the users/roles
allowed by its terms. It provides its own permissions.

Use it to scope which editors can edit which term-tagged content. The check runs in `hook_form_alter()` — when
the editor is neither in the term's allowed roles nor allowed users it `throw`s an `AccessDeniedHttpException`,
blocking the node edit form. Configure the term allow-lists.

---

- Restrict node edit by taxonomy term.
- Use user/role allow-lists on terms.
- Limit editing to allowed users/roles.
- Provide its own permissions.
- Serve access control.
- Scope editors by term.
- Check access in hook_form_alter (throws on the edit form).
- Configure the term allow-lists.
- Handle term-based edit restriction.
- Restrict editing.
- Configure the allow-lists.
- Gate the edit form.
- Handle the terms.
- Limit editors.
- Provide term-based edit restriction.
