# Terms of Use — agent index

Adds a required agreement checkbox (plus inline terms text or a link) to the core user
registration form, sourced from a node. One settings form, one `hook_form_user_register_form_alter`.
No permissions of its own, no plugins, no Drush, no submodules. Config UI at
`/admin/config/people/terms-of-use` (route `terms_of_use.settings_form`, permission
`administer account settings`).

- **Settings keys, the config object, how the checkbox/terms render, admin skip behavior** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `terms_of_use.settings`: `terms_of_use_node` (int nid), `terms_of_use_label_name`
  (fieldset title), `terms_of_use_label_checkbox` (checkbox label, supports `@link` token),
  `terms_of_use_open_link_in_new_window` (bool), `terms_of_use_collapsed` (bool).
- Injected only for non-`administer users` accounts on the `user_register_form`; checkbox is `#required`.
- If the checkbox label contains `@link`, a link to the node is shown instead of the body text.
- Otherwise the node body is emitted raw as `#markup` inside `<div class="terms-of-use">…</div>`.
