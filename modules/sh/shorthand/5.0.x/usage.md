<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shorthand connects a Drupal site to a [Shorthand](https://www.shorthand.com/) account via its API, letting editors browse remote Shorthand stories, download them locally as extracted asset bundles, and render a chosen story through a "Shorthand select" field on any fieldable entity.

---

Configuration is a single API token at `/admin/config/services/shorthand`
(`shorthand.settings_form`), validated against Shorthand's `v2/token-info` endpoint on save. The
`shorthand_api` service (`ShorthandApi`, base URI `https://api.shorthand.com/`) wraps the REST API:
`getStories()` lists stories, `getStory($id)` downloads a story `.zip` to a temp file, and
`validateApiKey()`/`publishAssets()` cover token checks and asset publishing. The remote listing at
`/admin/content/shorthand` (`RemoteCollectionController::list`) shows each story with a download
link; downloading runs a Batch (`downloadStoryBatch`) that fetches the `.zip` and extracts it with
`ZipArchive::extractTo()` into `public://shorthand/stories/<story-id>/<updated-timestamp>/`, then
deletes the temp archive. To display a story, add a **Shorthand select** field (field type
`shorthand_local`) to a content type / taxonomy / user, etc.; its widget
(`shorthand_local_story_select`) offers a dropdown of downloaded story/version folders, and its
formatter (`LocalShorthandFieldFormatter`) reads the extracted `article.html` + `head.html`, rewrites
relative `./assets/` and `./static/` URLs to public-file URLs, strips the `<title>`, and outputs the
story markup. With the optional Metatag module, `hook_metatags_alter()` parses the story's `head.html`
and copies its `<meta>` tags (and og/twitter images) onto the host entity. A Drush command
`shorthand:clean-up` (alias `shcu`) removes downloaded story folders/versions no longer referenced by
any `shorthand_story` node. Permissions: `administer shorthand` (restricted) and
`download shorthand content`. The bundled **shorthand_example** submodule ships a `shorthand_story`
content type wired to a Shorthand field. Requires core `text`.

---

- Publish a Shorthand.com immersive/longform story inside a Drupal page.
- Connect a Drupal site to a Shorthand account with an API token.
- Browse all remote Shorthand stories from within the Drupal admin.
- Download a Shorthand story locally so it is served from the site's own public files.
- Keep a downloaded story in sync by re-downloading when Shorthand shows a newer version.
- Attach a Shorthand story to a content type via a "Shorthand select" field.
- Attach stories to taxonomy terms or user profiles (any fieldable entity).
- Pick which downloaded story/version an entity renders using the widget dropdown.
- Render the story's full HTML with its assets rewritten to local URLs.
- Automatically populate an entity's meta tags from a story's `head.html` (with Metatag).
- Mirror Shorthand og:image / twitter:image tags to locally served asset URLs.
- Build a dedicated "Shorthand story" content type quickly using the example submodule.
- Create clean full-bleed story pages by hiding title/other fields in the display.
- Validate a Shorthand API token before saving it.
- Clean up unused downloaded story folders with `drush shorthand:clean-up`.
- Serve story assets from `public://shorthand/stories/...` without external Shorthand hosting.
- Manage multiple story versions per story id on disk.
- Restrict who can download remote stories via the `download shorthand content` permission.
- Publish story assets back to Shorthand via the API service (`publishAssets`).
- Present the same story across several entities by referencing the same story path.
