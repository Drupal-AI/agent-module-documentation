# Required Menu Link — agent index

Makes a menu link required (or default-on) per content type, via `hook_form_alter` on the node
type and node forms. No settings page (`configure` null), no permissions, no services. Depends
on `menu_ui`. Config schema describes the node-type third-party settings.

- **The three per-content-type settings, where they are stored, and the node-form
  enforcement/JS behavior** → [configure/settings.md](configure/settings.md)

Key facts:
- Settings are node-type third-party settings in namespace `required_menulink`:
  `require_menulink`, `soft_require`, `disable_auto_menutitle` (schema
  `node.type.*.third_party.required_menulink`).
- Enforcement is form-level: with `require_menulink` on and `soft_require` off, the node form
  disables + checks `menu[enabled]` and sets the menu link title `#required`.
- Configured on the content type edit form's "Menu link settings" vertical tab; no separate route.
