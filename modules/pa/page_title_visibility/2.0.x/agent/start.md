# Page Title Visibility — agent index

Hides the core Page Title block per node (and per content-type default) by adding core's
`visually-hidden` class — the `<h1>` stays in the DOM. No admin settings page of its own
(`configure` null); config is a per-node field + a per-bundle default. Depends on core `block`, `node`,
`system`. Provides one permission and a config schema; no plugins/Drush.

- **The `display_page_title` field, per-type default config, permission, and the hide logic** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Base field `display_page_title` (boolean, default TRUE, revisionable + translatable) added to all
  nodes via `hook_entity_base_field_info`.
- `hook_preprocess_block` adds `visually-hidden` to `plugin_id == 'page_title_block'` when the node's
  flag resolves to hidden; skipped on node edit/delete/version-history routes and non-node routes.
- Per-type default in config `page_title_visibility.content_type.<bundle>` (key `display_page_title`).
- Editing the checkbox/default requires permission `administer page display visibility config`
  (`restrict access: true`); without it the widget is disabled.
- Requires the content type to actually render a page-title block for hiding to have any effect.
