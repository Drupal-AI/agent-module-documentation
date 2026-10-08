<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shorthand — agent index

Integrates a Shorthand.com account: browse remote stories, download them locally (extracted zip),
and render one via a `shorthand_local` field. Config at `/admin/config/services/shorthand`
(`configure` = `shorthand.settings_form`). Requires core `text`. Optional Metatag integration.
Ships a Drush command and a `shorthand_example` submodule.

- **Token settings, the remote list + download flow, the field type/widget/formatter, routes, permissions** →
  [configure/setup.md](configure/setup.md)
- **`shorthand_api` service methods (getStories, getStory, validateApiKey, publishAssets)** →
  [api/service.md](api/service.md)
- **`drush shorthand:clean-up` (shcu)** → [drush/commands.md](drush/commands.md)

Submodule:
- `shorthand_example` → [../../modules/shorthand_example/5.0.x/agent/start.md](../../modules/shorthand_example/5.0.x/agent/start.md)

Key facts:
- Config object `shorthand.settings` → `shorthand_token` (string). API base
  `https://api.shorthand.com/`, auth header `Token <token>`.
- Downloads land in `public://shorthand/stories/<story-id>/<updatedAt>/` (extracted `article.html`,
  `head.html`, `assets/`, `static/`).
- Field type `shorthand_local` (stores `<story-id>/<version>` path), widget
  `shorthand_local_story_select`, formatter `shorthand_local_story_render`.
- Permissions: `administer shorthand` (`restrict access: true`), `download shorthand content`.
  Note: route `shorthand.remote_collection` requires `access shorthand story overview`, which the
  module does NOT define — so that list page is reachable only by uid 1 until the permission exists.
