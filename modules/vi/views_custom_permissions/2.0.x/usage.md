<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Custom Permissions provides a Views access plugin letting developers define a custom callback function to control access to views pages, blocks and other displays.

---

Views Custom Permissions adds a Views access plugin that lets site developers control access to a
view (page, block or other display) via a custom access-callback function they specify — for cases where
the built-in "permission" and "role" access plugins aren't flexible enough (dynamic, context-dependent
access logic). The callback mapping is stored in `views_custom_permissions.settings`; it depends on
Views and provides its own permissions.

Use it when a view needs bespoke access logic beyond a static permission/role. It is an access-control
feature, so the important responsibility is on the configured callback: **the callback must correctly
return access granted/denied, defaulting to denied**, and it is set by administrators/developers (not
end users), so treat the configuration as trusted/privileged. Verify the callback's logic and its
fail-closed behaviour before relying on it to protect a view; a mistaken or missing callback must not
fall open. Configure the view's access to use this plugin and point it at your callback.

---

- Control view access via a custom callback.
- Define bespoke access logic for views.
- Go beyond permission/role access.
- Apply to pages, blocks and displays.
- Store the callback mapping in config.
- Depend on Views.
- Provide its own permissions.
- Ensure the callback fails closed.
- Verify the callback denies by default.
- Treat the config as privileged.
- Use for dynamic access logic.
- Set by developers, not end users.
- Point the view's access at the plugin.
- Return granted/denied correctly.
- Protect views with custom logic.
- Handle context-dependent access.
- Configure the access callback.
- Test the callback's logic.
- Avoid a fail-open callback.
- Apply custom view permissions.
