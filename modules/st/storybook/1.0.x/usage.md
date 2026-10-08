<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Storybook connects Drupal's Twig rendering to a Storybook front-end: you write stories in Twig using two new tags (`{% stories %}` and `{% story %}`) in `*.stories.twig` files, compile them to `*.stories.json` with a Drush command, and Storybook renders each story by calling a Drupal endpoint that returns the real Twig-rendered markup.

---

Built on the `e0ipso/twig-storybook` library, the module registers a Twig extension providing the `stories`/`story` tags so component stories live next to your templates. A Drush command (`storybook:generate-all-stories` / `storybook:generate-stories`) scans `modules`, `profiles`, and `themes` for `*.stories.twig` files and compiles each into a sibling `*.stories.json` that the Storybook application understands, embedding the URL of Drupal's render endpoint (overridable with `--uri` or omittable with `--omit-server-url`). The render endpoint is the route `storybook.render_story` at `/storybook/stories/render/{hash}`, gated by the `render storybook stories` permission and guarded by a custom access check; it returns the story's markup so Storybook's iframe shows genuine Drupal output. To make that work in development the module ships a theme negotiator (renders in your front-end theme), an outbound path processor and a decorated file URL generator (force absolute URLs so the iframe loads assets), and decorators that disable page cache, render cache, and asset optimization when the `storybook.development` container parameter is TRUE. Actually viewing components requires the **external Storybook application** (an npm/Node dev server started with `npx storybook init --type server` then `yarn storybook`) plus CORS enabled on Drupal — an out-of-Drupal dependency; the Twig tags, Drush compilation, route, and permission are all usable and testable inside Drupal without it. It is a development tool: keep the render permission and development mode disabled in production.

---

- Write Storybook stories for Drupal components directly in Twig (`*.stories.twig`).
- Document and showcase Single Directory Components (SDC) and theme templates.
- Group related stories with `{% stories %}` and define each variant with `{% story %}`.
- Pass `args` in a story and have them exposed as Twig variables for the template.
- Compile all Twig stories to JSON with `drush storybook:generate-all-stories`.
- Compile a single template's stories with `drush storybook:generate-stories <path>`.
- Force regeneration of unchanged stories with `--force`.
- Omit the server URL from compiled JSON for static/multi-env deploys (`--omit-server-url`).
- Override the render endpoint domain with Drush's `--uri` option.
- Render each story with real Drupal Twig output via the `/storybook/stories/render/{hash}` endpoint.
- Preview components in your actual front-end theme (via the storybook theme negotiator).
- Build a living component library / design system reference for a Drupal theme.
- Let front-end and back-end developers share one source of truth for markup.
- Disable render/page/asset caching on the render route during development (`storybook.development`).
- Serve absolute asset URLs so components render correctly inside Storybook's iframe.
- Restrict who can hit the render endpoint with the `render storybook stories` permission.
- Grant that permission to anonymous only in local/dev so Storybook can fetch renders.
- Integrate the Storybook preview into CI/PR environments (e.g. Tugboat).
- Migrate from CL Server to Storybook for component rendering.
- Watch for story changes and recompile continuously (`watch --color drush storybook:generate-all-stories`).
- Keep component examples versioned alongside templates in the repo.
- Test how a component looks with different argument combinations quickly.
- Onboard new developers by browsing the component catalogue in Storybook.
