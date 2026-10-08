<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Library Select provides Drupal library select per node and entity, attaching chosen registered libraries.

---

Library Select lets editors choose which registered Drupal asset libraries (CSS/JS) to attach on a
per-node/per-entity basis — so specific pages can load extra libraries (a slider, a widget) without theme
changes. It ships a `library_select_context` submodule, provides its own permissions, in the Custom package.

Use it to attach page-specific libraries. It is a content-display/asset feature; editors select from the
**registered** libraries (defined by modules/themes — not arbitrary URLs), so the attack surface is the set
of registered libraries. Since attaching a library loads its JS/CSS, restrict who can select libraries (its
permission) to trusted editors — a malicious/careless selection could load an unexpected library on a page.
It has no access-control role beyond its permission. Configure which entities can select libraries.

---

- Select libraries per node/entity.
- Attach registered libraries per page.
- Load page-specific CSS/JS.
- Ship a context submodule.
- Provide its own permissions.
- Select from registered libraries (not arbitrary URLs).
- Restrict who can select libraries.
- Grant the permission to trusted editors.
- Have no access-control role beyond permission.
- Configure entity library selection.
- Attach page libraries.
- Handle library selection.
- Load per-entity libraries.
- Configure the selection.
- Select assets.
- Attach libraries.
- Handle asset selection.
- Configure libraries.
- Restrict library selection.
- Select per node.
