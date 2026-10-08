# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Open Y → Settings → Theme Switcher**, or navigate
   directly to `/admin/config/openy/settings/theme-switcher`.

The settings are stored in `lb_theme_switcher.settings`.

## The settings, field by field

- **Theme to switch to** (`theme_name`) — the installed, enabled theme used on
  Layout Builder pages (for example Open Y Carnation). The list is validated
  against the theme handler, so you can only choose a theme that is actually
  installed and enabled. This is the one required choice.
- **Handle HTTP exception routes** (`handle_http_exception_routes`) — when
  enabled, the LB theme is also applied on **404 and 403** error pages. Leave it
  off if you want error pages to keep the site's default theme.
- **Handle webform routes** (`handle_webform_routes`) — when enabled, the LB theme
  is also applied on **Webform** canonical pages and user-submission pages. Useful
  when webforms are meant to look like the rest of your LB content.

Admin routes are **never** switched, regardless of these settings.

Save the form. The negotiator (which runs at priority 1001) then switches the
theme on the Layout Builder override/default view routes, on node pages that use
Layout Builder, and — if you enabled them — on the error and webform routes.

## Resetting shared header/footer sections (Drush)

The module ships a Drush command for maintenance:
`lb_theme_switcher:reset-lb-header-footer` (alias **`lbreset`**). It resets the
shared `ws_header` and `ws_footer` Layout Builder sections on nodes back to the
section template defined on their entity view display — useful after a theme
switch changes the shared header/footer template.

```bash
# Reset one content type (view mode defaults to "default"; some types use "full")
drush lb_theme_switcher:reset-lb-header-footer <bundle> [mode] [--dry-run]

# Reset every LB-enabled node bundle/display
drush lbreset all
```

- `bundle` — the content type to reset, or `all` for every LB-enabled node
  display.
- `mode` — the view mode holding the LB template (default `default`; some content
  types store it under `full`).
- `--dry-run` — report what *would* change without saving anything. Run this first
  to preview.

For each node, the command replaces its header/footer sections with the template
ones **only when they differ**, then saves. It prompts for confirmation, and the
`all` run prints a per-bundle summary of nodes found versus updated. It is an
administrative CLI operation intended to run with full privileges.
