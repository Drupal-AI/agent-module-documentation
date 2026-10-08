<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Singles provides single node types, used for one-off pages (like Home, About) that have unique content requirements and only one instance.

---

Node Singles provides "single" node types — content types intended to have exactly one node each, for
one-off pages like Home, About or Contact that have unique content/field requirements but aren't part of a
repeating content set. It manages these singletons (ensuring one instance, providing direct edit access)
rather than treating them as ordinary content types. It requires PHP 7.1, depends on core Node, and
provides its own permissions.

Use it to model unique landing/section pages as structured content (with their own fields) without the
overhead of a general content type that could accumulate many nodes. It is a site-structure/content
feature; access to the single nodes is governed by node access and the module's permissions. Configure
the single types and their fields.

---

- Create single (one-off) node types.
- Model Home/About/Contact pages.
- Ensure one node per type.
- Give one-off pages unique fields.
- Require PHP 7.1.
- Depend on core Node.
- Provide its own permissions.
- Manage singleton content.
- Provide direct edit access to singles.
- Avoid a general type accumulating nodes.
- Structure landing pages.
- Govern access via node access.
- Configure single types and fields.
- Model unique pages.
- Handle one-instance content.
- Build section pages.
- Structure one-off content.
- Manage unique-page types.
- Edit singles directly.
- Create landing-page types.
