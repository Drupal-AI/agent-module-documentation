<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Swapper swaps an old node for a new one, preserving aliases and redirects.

---

Node Swapper **swaps an old node for a new one** — replacing a node with a replacement while **preserving the
URL alias and creating redirects** from the old to the new, so links/SEO are maintained during content replacement.
It depends on the Redirect and Pathauto modules, and provides its own permissions.

Use it to replace content without breaking URLs. It is a content-administration feature; the swap is a privileged
editorial operation (it moves aliases and creates redirects) gated by its permission (restrict to trusted editors).
It has no broader access-control role. Configure/permission the swap.

---

- Swap an old node for a new one.
- Preserve URL aliases.
- Create old→new redirects.
- Depend on Redirect + Pathauto.
- Provide its own permissions.
- Serve content administration.
- Move aliases + create redirects (privileged op).
- Restrict the permission to trusted editors.
- Have no broader access-control role.
- Configure/permission the swap.
- Handle node swapping.
- Swap nodes.
- Configure the swap.
- Replace nodes.
- Handle the aliases.
- Preserve URLs.
- Configure content.
- Handle redirects.
- Swap content.
- Provide node swapping.
