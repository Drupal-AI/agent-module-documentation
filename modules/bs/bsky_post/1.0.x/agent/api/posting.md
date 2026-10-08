<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Posting flow & the BskyPost service

## The tab form — `BskyPostForm`
`src/Form/BskyPostForm.php`, form id `bsky_post_form`, route `bsky_post.tab` = `/node/{node}/bsky`, permission `post to bluesky`, `_admin_route: TRUE`.

Constructor (via `create()`) injects `bsky_post.bsky_post` (the `BskyPost` service) and `current_route_match`. From the `{node}` route parameter it precomputes:
- `title` = `$node->getTitle()`.
- `text` = `$node->get('body')->summary`; if empty, `text_summary($node->get('body')->value, 1, 300)` (first ~300 chars).
- `link` = `$node->toUrl()->setAbsolute()->toString()` (absolute node URL).

`buildForm()` renders editable `title` (textfield), `text` (textarea) and `link` (textfield) with those defaults plus a submit button. If no node is present it renders a "This should never happen." item.

`validateForm()` rejects the post when `mb_strlen(title . "\n" . text) > 300` (Bluesky's character limit).

`submitForm()` builds `$message = title . "\n" . text`, reads `link`, and calls `$this->bskyService->post($message, $link)`. On success (`FALSE` return) it adds a status message and redirects to `entity.node.canonical`; on failure it shows the returned error string and rebuilds the form.

## The service — `BskyPost`
`src/BskyPost.php`, service id `bsky_post.bsky_post`, args `['@bsky.post_service', '@config.factory']`. Constructor caches `system.site:name` as `$this->site`.

`post($message, $link)`:
1. `$post = $bskyConnector->createPost($message)` — bsky's `PostService::createPost()` (throws if bsky has no credentials).
2. `$post = $bskyConnector->addCard($post, $link, $this->site, "Read the full post.")` — attaches a website card using the site name as the card title and a fixed description; delegates to the phluesky library's `addWebsiteCard()` (no image path passed).
3. `$bskyConnector->sendPost($post)` inside try/catch; on `HttpStatusCodeException` returns `$e->getMessage()` (the error string), otherwise returns `FALSE` (success sentinel).

## Where credentials & HTTP live (not here)
bsky_post delegates every network call to `bsky` (`Drupal\bsky\PostService`, service `bsky.post_service`). bsky reads `bsky.settings:handle` + `app_key`, resolves the app password through the **Key** module (`KeyRepositoryInterface`), and drives the vendored `potibm/phluesky` `BlueskyApi`/`BlueskyPostService`. bsky_post holds no keys, makes no direct HTTP requests, and adds no config of its own beyond the `types` selection.

## Operate it
1. Configure bsky (handle + app-password Key).
2. At `/admin/config/services/bsky-post-settings`, select the content types that should show the tab.
3. Grant `post to bluesky` to the roles that may share, and `administer bsky_post configuration` only to admins.
4. On a node of a selected type, open the **Share to Bluesky** tab, edit the pre-filled title/summary/link, keep it under 300 chars, and submit.
