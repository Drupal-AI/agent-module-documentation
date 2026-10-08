# DubBot Toolbar — agent index

Submodule of **DubBot**. Adds a single admin-toolbar item linking to the current page's DubBot
report. Pure glue: one `hook_toolbar()` implementation (via `Drupal\dubbot_toolbar\ToolbarHandler`)
that renders a `toolbar_item` built from the parent's `dubbot.link_generator` service.

No config, no settings form, no permissions, no config schema of its own — it reuses DubBot's
`dubbot.settings` and the `access dubbot report` / per-pane `view dubbot * tab` permissions. See
the parent: [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md).

Key facts:
- Depends on core `toolbar` and `dubbot`. Enable with `drush en dubbot_toolbar -y`.
- Toolbar item is weight 125, cached by `user.permissions` + `url`, hidden on 403/404 and on
  pages anonymous users cannot view (uncrawlable), or when no report link exists.
- Attaches the `dubbot_toolbar/toolbar` CSS library.
