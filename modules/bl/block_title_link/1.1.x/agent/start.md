# Block Title Link — agent index

Adds a "Block Title Link Settings" group to the block configuration form so a block's title becomes a
link. One `.module` file; no config page (`configure` null), no schema, no permissions of its own
(inherits `administer blocks`), no services, no Drush. Depends on core `block` (uses `link`'s widget).

- **The four settings, where they are stored, and how the title is rendered** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `hook_form_block_form_alter()` adds fields under `third_party_settings.block_title_link`:
  `title_link_url` (entity_autocomplete, node target, validated by
  `LinkWidget::validateUriElement`), `link_title`, `title_link_target`, `title_link_enable`.
- `hook_preprocess_block()` replaces `$variables['label']` with a `#type => 'link'` element built
  from `Url::fromUri($title_link_url)` when `title_link_enable` is truthy.
- Blocks rendered without an `#id` (e.g. from Page Manager widgets) are skipped.
- The URL is admin-entered (`administer blocks`) and validated as a link URI; `Url::fromUri()` +
  core link rendering sanitize dangerous schemes. Treat as trusted-admin input.
