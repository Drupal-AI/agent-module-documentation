<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSnippet stores and provides code snippets.

---

JSnippet **stores and provides reusable code snippets** — managing JavaScript/CSS snippets as entities and
attaching them to pages as Drupal **libraries** (e.g. via a field formatter or globally). It provides its own
permissions.

Use it to manage reusable front-end snippets. It is a developer/theming feature with a **security consideration**:
the snippets are **JavaScript/CSS that run in visitors' browsers** — a malicious or mistaken snippet is effectively
**arbitrary JS on your pages (XSS/defacement)**, so keep the snippet-editing permission to **fully-trusted
admins/developers** and review snippet content. (It attaches libraries; it does not eval PHP server-side.) It has
no access-control role beyond its permission. Configure the snippets and who may edit them.

---

- Store reusable code snippets.
- Attach JS/CSS as libraries.
- Manage snippet entities.
- Provide its own permissions.
- Serve developers/theming.
- Reuse front-end snippets.
- KNOW snippets are JS/CSS that run in browsers.
- Treat them as arbitrary JS (XSS/defacement risk).
- Keep editing to fully-trusted admins/developers.
- Review snippet content (no server-side eval).
- Have no access-control role beyond permission.
- Configure snippets + who edits them.
- Handle snippets.
- Add snippets.
- Configure the snippets.
- Attach snippets.
- Handle the libraries.
- Manage snippets.
- Restrict editing.
- Provide code snippets.
