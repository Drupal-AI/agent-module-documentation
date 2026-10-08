<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storybook — agent index

Bridges Drupal Twig to a Storybook front-end. Write stories in Twig (`{% stories %}` /
`{% story %}` tags in `*.stories.twig`), compile them to `*.stories.json` with Drush, and
Storybook renders each via a Drupal endpoint. No `configure` route, no config schema, no
plugin types. Actually browsing components needs the **external Storybook (npm/Node) app** +
CORS — but the Twig tags, Drush compilation, route, and permission work inside Drupal.

- **Render route, `render storybook stories` permission, `storybook.development` mode,
  dev/CORS setup, external Storybook app requirement** →
  [configure/setup.md](configure/setup.md)
- **Drush: `storybook:generate-all-stories` / `generate-stories`, options, cwd gotcha** →
  [drush/commands.md](drush/commands.md)
- **The `{% stories %}` / `{% story %}` Twig tags and authoring `*.stories.twig`** →
  [theming/stories.md](theming/stories.md)

Key facts:
- Render route `storybook.render_story` → `/storybook/stories/render/{hash}`
  (permission **`render storybook stories`**, plus a custom access check).
- Drush writes a sibling `<name>.stories.json` for every `<name>.stories.twig` (scans
  `modules`, `profiles`, `themes`).
- Container parameter `storybook.development` (default FALSE) turns off page/render/asset
  caching on the render route; enable it only in dev (in `*.services.yml` / settings).
- Backed by the `e0ipso/twig-storybook` composer library (`TwigStorybook\*` services).
