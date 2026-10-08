<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entityform Block provides blocks that render add/edit forms for content entities, so an entity form can be placed anywhere a block can go.

---

Sometimes you want an entity's create or edit form on a page that is not the standard entity form route — a "submit an idea" form in a sidebar, an inline edit form on a dashboard, a contact-style entity form embedded in a landing page. Building that means a custom block plugin that instantiates the entity form, which is boilerplate every time.

Entityform Block makes it configuration: it exposes blocks that render the add or edit form for a content entity, which you place through the normal block/Layout Builder UI. The form behaves like the real entity form — same fields, same validation, same save.

Because it places a real entity form, **access control is the thing to get right**. The form saves an entity, so it must only be reachable by users who should create or edit that entity type — placing an add form in a public region exposes entity creation to whoever can see the block. Confirm the block's visibility and the entity type's create/edit permissions align: the block is a placement mechanism, and it does not add access control of its own beyond what the entity form and block visibility provide.

---

- Embed an entity add form in a block.
- Place an edit form anywhere.
- Add a submit form to a sidebar.
- Render an entity form as a block.
- Inline an edit form on a dashboard.
- Avoid a custom form block plugin.
- Place a form via Layout Builder.
- Add a create form to a landing page.
- Show an entity form in a region.
- Confirm entity create permissions.
- Restrict the form block's visibility.
- Align block visibility with access.
- Embed a contact-style entity form.
- Provide inline editing.
- Place a form outside its route.
- Add a quick-add form.
- Render add or edit forms.
- Reuse the real entity form.
- Keep validation intact.
- Control who sees the form block.