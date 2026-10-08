# Protect Views Flood Control — agent index

Rate-limits Views Exposed Form submissions per view/display via the Flood API, and can cap active
filters/options per submission. No settings page of its own (`configure` null) — configured **per View
display** in the *Advanced* panel. No permissions, no Drush. Depends on core `views` and
`protect_form_flood_control` (which owns IP whitelist + logging). Provides a display-extender config
schema.

- **Enabling protection per display, all option keys, and how throttling/429/max-filters work** →
  [configure/flood-control.md](configure/flood-control.md)

Key facts:
- Display extender plugin `protect_views_flood_control`
  (`src/Plugin/views/display_extender/ProtectViewsFloodControl.php`); registered globally in
  `views.settings` `display_extenders` on install (`hook_install`).
- Enforcement: `hook_form_views_exposed_form_alter` adds a static `#validate`
  (`Hook/ProtectViewsFloodControl::exposedValidate`). Over-limit non-AJAX → `TooManyRequestsHttpException`
  (429 + `Retry-After`); AJAX → `$form_state->setError()`.
- Flood key: `views_exposed:<view id>:<display>`, checked via `protect_form_flood_control.manager`
  (`getFlood()->isAllowed()/register()`), optionally per IP /24 or /48 subnet.
- Only fires when exposed input is non-empty and the exposed form actually executes (cached result = not
  counted); never on plain page loads or pager clicks.
