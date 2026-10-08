# Markdownify Views Pages — agent index

Submodule of **markdownify**. Adds Markdown output for Views **page** displays (listing
pages) using the same `.md` / `/markdownify/` patterns. Requires `markdownify` + `views`.

- **Service:** `markdownify_views.route_subscriber` (`MarkdownifyViewsRoutes`, a
  `RouteSubscriberBase`). For every **non-admin** Views route with display plugin `page`
  and `_format: html`, it clones a Markdown route: rewritten path, controller
  `MarkdownifyViewPageController::handle`, `_format`/`_content_type_format = markdown`,
  `Vary: Accept` flag.
- **Controller:** `MarkdownifyViewPageController` extends core `ViewPageController`, renders
  the view, converts HTML→Markdown via `markdownify.html_converter`, prepends the title as `# H1`.
- **No config, schema, permissions, or Drush.** Enabling it is the setup.

**⚠ Known bug (D11, 1.1.x):** the controller's `create()` doesn't initialise the parent
`ViewPageController`'s typed properties, so `parent::handle()` throws
`$contextualLinks must not be accessed before initialization` → the Markdown view route
returns **HTTP 500**. Verified on this site. The feature is broken until fixed upstream.

Parent module (how Markdown is generated + entity access methods):
[../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md).
