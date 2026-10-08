<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Menu UI adds the menu-link section to the product form, so a product can be placed in a menu when it is created.

---

Nodes have had "Provide a menu link" on their edit form since forever, and it is one of the small things that makes content creation feel finished — you publish a page and it is in the navigation. Commerce products do not have it, so putting a product in a menu means going to the menu administration afterwards and pasting a path, which people forget.

This module brings core's `menu_ui` behaviour to the product form. The result is that a featured product, a category landing product or a service offering can be navigable from the moment it is saved.

It is a small bridge between two things that both already exist, which is the best kind of contrib module — no new concepts, no configuration to learn, just a capability that was missing from one entity type and present on another.

Worth deciding as an editorial matter: menus that anyone can add to grow unmanageable, and a product form with a menu section invites every product to be added. Restricting which menus are available on the product form, as core allows per bundle, is the control to use.

---

- Add a product to a menu when creating it.
- Put a featured product in the main navigation.
- Make a service offering navigable.
- Avoid pasting product paths into menu admin.
- Stop editors forgetting the menu link.
- Reuse core's menu_ui behaviour for products.
- Restrict which menus appear on the product form.
- Keep a product menu manageable.
- Edit a product's menu link with the product.
- Remove a menu link when unpublishing.
- Give commerce parity with nodes.
- Plan storefront navigation.
- Audit menu links pointing at products.
- Delegate product navigation to merchandisers.
- Document which menus products may join.
