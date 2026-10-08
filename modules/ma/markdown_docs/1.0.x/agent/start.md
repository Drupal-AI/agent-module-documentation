<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdown Docs — agent index

**Renders Markdown files as browsable in-site documentation** (nav + search + images) under
`/admin/documentation`. Provides permissions. Version **1.0.0-alpha3**. Core `^10||^11`.

Admin — all routes **permission-gated**; image serving is **path-traversal-guarded** (rejects `..`/null,
`realpath` within docs root, image-extension allowlist). Keep edit permissions to trusted admins. No broader
access role.
