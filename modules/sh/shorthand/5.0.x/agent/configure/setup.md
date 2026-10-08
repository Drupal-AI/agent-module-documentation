<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & use Shorthand

## 1. API token

`/admin/config/services/shorthand` (`ShorthandSettingsForm`, route `shorthand.settings_form`, perm
`administer shorthand`). Single required field **API token** → stored in config object
`shorthand.settings` key `shorthand_token` (schema `shorthand.settings`). On submit, `validateForm()`
calls `shorthand_api::validateApiKey()` against `v2/token-info/`; an invalid token blocks saving.
(The form also references an optional `request_timeout` setting used by the API service.)

## 2. Download stories

Remote list: `/admin/content/shorthand` (`RemoteCollectionController::list`). It calls
`getStories()` and lists each story with image, status, dates, external URL, and a **Download**
action linking to `shorthand.download.story` (`/admin/content/shorthand/download/{storyid}`,
CSRF-protected, perm `download shorthand content`).

Download runs a Batch (`downloadStoryBatch`): `getStory($sid)` saves the `.zip` to a temp file, then
`ZipArchive::extractTo()` unpacks it into
`public://shorthand/stories/<storyid>/<updatedAt-timestamp>/` and the temp archive is deleted. A
story already present at the current timestamp shows "up to date"; an older local copy shows
"Update story".

> Route caveat: `shorthand.remote_collection` requires the permission
> `access shorthand story overview`, but `shorthand.permissions.yml` only defines
> `administer shorthand` and `download shorthand content`. Since that permission id is never
> declared, no role can hold it and only uid 1 (which bypasses access) can open the list page. Grant
> access by defining the permission or adjusting the route requirement.

## 3. Display a story on an entity

Add a field of type **Shorthand select** (`shorthand_local`, category *Reference*) to any fieldable
entity (content type, taxonomy vocabulary, user…). Ensure a full-HTML-capable text format exists
(README).

- **Widget** `shorthand_local_story_select` (`LocalShorthandStorySelectFieldWidget`): a `<select>`
  whose options are the locally downloaded `story-id/version` folders (labelled with the remote
  story title). Stores the chosen `<story-id>/<version>` path string.
- **Formatter** `shorthand_local_story_render` (`LocalShorthandFieldFormatter`): reads
  `public://shorthand/stories/<path>/article.html` + `head.html`, rewrites relative `./assets/` and
  `./static/` URLs to public-file URLs, strips the `<title>`, and outputs the story markup
  (`article.html` as `#markup`, `head.html` as `#prefix`). If `article.html` is missing the item is
  skipped.

For a clean full-page story, hide the entity's other fields and customize `page.html.twig` /
Layout Builder / Context for story bundles (README).

## 4. Metatag integration (optional)

If the Metatag module is enabled, `shorthand_metatags_alter()` loads the story's `head.html`, copies
its `<meta name|property … content>` tags onto the host entity (skipping ones already set and the
`generator` tag), and rewrites `og:image` / `twitter:image` to locally served asset URLs.

## Permissions

`shorthand.permissions.yml`:
- `administer shorthand` — `restrict access: true`; configure settings / access the settings form.
- `download shorthand content` — download remote stories locally (not restricted).

(See the route caveat above for the undefined `access shorthand story overview`.)
