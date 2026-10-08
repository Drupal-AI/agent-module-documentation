<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Debug Pause adds an admin-toolbar button that triggers the JavaScript debugger after a configurable delay, letting developers pause a page's JS execution (with DevTools open) without manually placing a breakpoint.

---

The module attaches a toolbar library (`debugpause/toolbar.debug-pause`) via `hook_toolbar_alter`, and `hook_preprocess_menu` injects a `pausein` attribute (the configured delay) and an id onto the Debug Pause menu item, hiding it from users lacking the `use debug pause` permission. A settings form at `/admin/config/development/debugpause` (permission `use debug pause`) configures the pause delay and whether to display the button title. It requires the Admin Toolbar module and only functions with browser DevTools open.

Operational note: this is a developer utility that runs client-side JS; it exposes only a permission-gated admin form and a toolbar button, with no server-side data handling. Its effect (invoking the JS debugger) is intended for non-production/dev use.

---
- Enable the module (requires admin_toolbar).
- Grant the `use debug pause` permission to developers.
- Visit /admin/config/development/debugpause to configure.
- Set the pause delay (pausein) in the settings form.
- Toggle whether the toolbar button title is displayed.
- Open browser DevTools so the pause takes effect.
- Click the Debug Pause toolbar button to pause JS after the delay.
- Inspect page state while JS execution is paused.
- Hide the button from users without the permission.
- Use it as a breakpoint-free way to freeze execution.
- Disable in production environments.
- Adjust the pause delay to match your debugging workflow.
- Confirm the toolbar library is attached on admin pages.
- Verify the pausein attribute is injected on the menu item.
- Restrict the feature to a dedicated developer role.
- Freeze animations mid-render to inspect DOM state.
- Remove the permission to fully hide the button.
