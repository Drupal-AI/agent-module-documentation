<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Markdown Docs renders Markdown files as browsable documentation.

---

Markdown Docs **renders Markdown files as browsable in-site documentation** — turning a directory of `.md`
files into a navigable docs section (with search and image serving) under `/admin/documentation`. It provides
its own permissions, in the Administration package.

Use it to publish internal documentation from Markdown. It is an administration feature and it is built
defensively: all routes are **permission-gated** (`access markdown_docs`, `edit markdown_docs files`,
`administer markdown_docs`), and image serving is **path-traversal-guarded** — the resolver rejects `..`/null
bytes, verifies the resolved path with `realpath()` stays **within the docs root**, and allows only whitelisted
image extensions. Keep the edit permissions (which write doc files) to trusted admins. It has no broader
access-control role beyond its permissions. Configure the docs root and permissions.

---

- Render Markdown as browsable docs.
- Navigate a .md directory.
- Provide search and images.
- Provide its own permissions.
- Gate all routes by permission.
- Serve /admin/documentation.
- Guard image serving against traversal.
- Reject ../null and verify realpath within docs root.
- Allow only whitelisted image extensions.
- Keep edit permissions to trusted admins.
- Have no broader access-control role.
- Configure the docs root.
- Handle Markdown docs.
- Show docs.
- Configure the docs.
- Render markdown.
- Handle the docs.
- Browse docs.
- Restrict edit access.
- Provide Markdown docs.
