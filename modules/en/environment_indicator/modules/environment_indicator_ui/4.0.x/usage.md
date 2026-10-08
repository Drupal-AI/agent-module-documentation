Submodule of Environment Indicator that adds an admin form for editing the **current** environment's indicator (name and colors) directly in the UI.

---

By default the active environment indicator is often pinned in `settings.php`, which is not editable from the browser. This submodule adds a settings page at `/admin/config/development/environment-indicator/current` that lets an administrator set the current environment's `name`, `fg_color`, and `bg_color` by writing to the `environment_indicator.indicator` config. It depends only on `environment_indicator` and reuses the parent's permission (`administer environment indicator settings`). This is convenient for sites that want to manage the live indicator through configuration/UI rather than code, and it complements the Environment Switcher entities managed by the parent module. It ships a single settings form and route and defines no permissions or plugins of its own.

---

- Edit the current environment's name from the admin UI.
- Set the current environment's background color in the browser.
- Set the current environment's text (foreground) color in the browser.
- Manage the active indicator without touching `settings.php`.
- Give site admins a UI to adjust the live environment banner.
- Recolor the running environment on the fly.
- Rename an environment (e.g. "Staging" → "Pre-prod") via the UI.
- Correct indicator colors for accessibility contrast from the UI.
- Let non-developers tweak the current environment cue.
- Store the current indicator as `environment_indicator.indicator` config.
- Pair UI-managed current settings with switcher-based navigation.
- Adjust the indicator for a temporary maintenance window.
- Quickly test different indicator colors in place.
- Provide a browser-based fallback when config overrides aren't used.
- Update the environment label after a re-deployment.
- Manage per-environment appearance without a code deploy.
- Reuse the parent permission to gate access to the form.
