<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Moderation State Form Knockout shows the moderation state widget but disables interaction.

---

Moderation State Form Knockout shows the Content Moderation state widget on entity forms but disables
interaction with it — so editors can *see* the current moderation state on the edit form without being able
to change it via the widget (the state is displayed read-only). It is in the custom package.

Use it where the moderation state should be visible but not editable inline. Important to understand: this is
a **UI/display** measure — disabling the widget does **not** enforce moderation-transition access. The actual
authority over which state transitions a user may perform is (and must remain) Content Moderation's transition
permissions; disabling the widget just removes the inline control, it doesn't prevent a permitted transition
via other means. So treat it as UI presentation, not access control. It has no access-control role. Enable it
where the read-only state display is wanted.

---

- Show the moderation-state widget read-only.
- Disable interaction with the widget.
- Display the current state without editing.
- Serve read-only state display.
- KNOW it is UI-only, not access control.
- Understand it doesn't enforce transition access.
- Rely on Content Moderation transition permissions.
- Not treat the disabled widget as a control.
- Have no access-control role.
- Enable read-only state display.
- Show state without change.
- Handle the moderation widget.
- Disable the widget.
- Configure the display.
- Show moderation state.
- Present state read-only.
- Handle state display.
- Disable state editing inline.
- Configure knockout.
- Show state.
