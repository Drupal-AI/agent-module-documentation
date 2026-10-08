# Node Save Redirect — agent index

Per-content-type control of where a user lands after saving a node (create vs. edit separately).
Configured on the content type's *Submission* tab; stored in the content type's third-party
settings. No permissions, no config page (`configure` null), no plugins, no Drush.

- **The settings keys, redirect types, and the submit-redirect logic** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Third-party settings on `node.type.*` under `node_save_redirect`: `save_type`/`save_location`/`save_destination` (new content) and `edit_type`/`edit_location`/`edit_destination` (existing content).
- `*_type`: `0` default, `1` edit page, `2` node view, `3` `/admin/content`, `4` custom `*_location` path.
- Redirect set on node form submit via `$form_state->setRedirectUrl()`, targets validated by `\Drupal::pathValidator()->getUrlIfValid()`.
- `*_destination = TRUE` removes the request `?destination=` param so the configured redirect wins.
- Hooks in `\Drupal\node_save_redirect\Hook\NodeSaveRedirectHooks` (OOP `#[Hook]` + `#[LegacyHook]` shims).
