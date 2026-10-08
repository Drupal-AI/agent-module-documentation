<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Button Field adds a button field type that triggers an event when clicked.

---

Button Field defines a **field type that renders a button** — when displayed, the field shows a button
that triggers an event/action on click, letting site builders add interactive buttons to entities without
custom code. It depends on core Field, in the Field types package.

Use it to add action buttons to entities. It is a fields/interaction feature. Security note: a button that
**triggers an event/action** should have that action **access-controlled and CSRF-protected** — ensure
whatever the button triggers checks access and isn't invocable by a forged request (the button itself is just
a trigger; the handler must enforce security). It has no access-control role of its own. Add the button field
to a bundle.

---

- Add a button field type.
- Render a clickable button.
- Trigger an event on click.
- Depend on core Field.
- Add interactive buttons.
- Avoid custom code.
- ACCESS-control the triggered action.
- CSRF-protect the action.
- Ensure the action isn't forgeable.
- Have no access-control role of its own.
- Add the button field.
- Handle button fields.
- Add buttons.
- Configure the field.
- Trigger actions.
- Handle the button.
- Add triggers.
- Configure buttons.
- Secure the action.
- Provide button fields.
