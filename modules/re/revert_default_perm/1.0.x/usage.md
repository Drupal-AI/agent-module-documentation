<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revert Default Permission (RDP) controls visibility of the 'Revert to defaults' button in Layout Builder.

---

Revert Default Permission (RDP) **hides the Layout Builder "Revert to defaults" button** — providing a
permission-controlled way to hide the revert-to-default action on Layout Builder overrides, so only allowed users
see/use it. It depends on core Layout Builder and provides its own permissions.

Use it to control who can revert Layout Builder overrides. It is a Layout Builder UI-access feature; it gates the
visibility of the revert button by permission and has no broader access-control role. Note: this hides the button —
ensure the underlying revert action is also permission-appropriate. Configure the RDP permission.

---

- Hide the LB revert-to-defaults button.
- Gate the revert action by permission.
- Control who reverts overrides.
- Depend on core Layout Builder.
- Provide its own permissions.
- Serve Layout Builder UI-access.
- Gate the revert button's visibility.
- Ensure the revert action itself is permission-appropriate.
- Have no broader access-control role.
- Configure the RDP permission.
- Handle the revert button.
- Hide the button.
- Configure the permission.
- Gate revert.
- Handle Layout Builder.
- Control reverting.
- Configure Layout Builder.
- Handle the UI.
- Restrict revert.
- Provide revert-button control.
