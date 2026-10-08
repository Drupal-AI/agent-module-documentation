# Layout Builder Theme Switcher — manual setup guide

**Layout Builder Theme Switcher** (`lb_theme_switcher`) swaps the active
front-end theme to a Layout Builder–capable theme (such as **Open Y Carnation**)
whenever a visitor views a Layout Builder page — so LB components render correctly
in a theme that supports them, while the rest of the site keeps its own custom
theme. It targets the Open Y / YMCA Website Services stack.

Some sites run a bespoke front-end theme that lacks the regions and markup Layout
Builder components expect. Rebuilding that theme for LB is costly; this module
sidesteps the problem with a theme negotiator that detects LB pages and returns
the configured LB theme just for those requests. It applies on the Layout Builder
override/default view routes and on node pages that use Layout Builder, and —
optionally, per configuration — on 404/403 error pages and on Webform
canonical/submission pages. **Admin routes are always excluded.** For AJAX
requests it honours core's theme token so that in-place LB editing stays
consistent.

Beyond the theme negotiation, the module ships a Drush command that resets the
shared `ws_header` / `ws_footer` Layout Builder sections on nodes back to their
view-display template — handy after a theme switch changes the shared
header/footer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the LB-capable theme.
2. [Configuration](configuration/index.md) — choose the target theme and toggle
   the optional error-page and webform behaviours; plus the Drush reset command.

## Where it lives in the admin menu

Its settings form lives at **Configuration → Open Y → Settings → Theme Switcher**
(`/admin/config/openy/settings/theme-switcher`), gated by the **Administer site
configuration** permission. See [Configuration](configuration/index.md) for a
field-by-field walkthrough.

## How to use it

1. Install and enable an LB-capable theme (for example Open Y Carnation).
2. Enable this module.
3. On the settings form, pick that theme as the one to switch to on LB pages, and
   decide whether error pages and webforms should use it too.
4. Visit a Layout Builder page as a normal visitor — it renders in the LB theme,
   while the rest of the site stays on your custom default theme.
