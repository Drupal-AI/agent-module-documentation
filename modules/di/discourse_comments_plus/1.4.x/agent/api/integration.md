<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node → topic push, SSO, blocks, service & Drush

## DiscourseApiClient service
`discourse_comments_plus.discourse_api_client` → `Drupal\discourse_comments_plus\DiscourseApiClient`.
Built from `http_client_factory`, `config.factory`, `cache.default`, `datetime.time`,
`entity_type.manager`, `database`, `extension.path.resolver`. The constructor reads the settings
config, sets a Guzzle client (`base_uri` = internal-or-public URL, `timeout` 30) and API headers
(`Api-Key`, `Api-Username`). It uses a `cacheSuffix` (per-domain when `domain_config` is enabled).
TLS uses Guzzle defaults (verification on). Key methods:

- `getTopic(int $topic_id)` — `GET /t/{id}.json`, returns raw body or FALSE.
- `getCategories($ignore_cache=false)` — `GET /categories.json`, cached 12h under
  `{suffix}discourse_category`.
- `post(array $data, $user=NULL)` — `POST /posts.json` with `form_params`; sets
  `Api-Username` to `$user` when given (so replies post as the SSO'd Discourse user).
- `getLatestComments()` — returns the cached `{suffix}discourse_latest_comments` array only.
- `fetchLatestComments($count=5)` — fetches top 20 linked topics' posts, strips tags/truncates
  `cooked` to 100 chars, sorts newest-first, resolves each to a node link, caches for
  `cache_lifetime` minutes. Called by the Drush command.
- `getNodeFromTopicId` / `getTopicIdsWithComments` — query `node_field_data` on
  `discourse_plus_field__topic_id` (parameterised via the DB API).
- `getBaseUrl` / `getPublicUrl` / `getDefaultAvatar` / `getHeaders` / `getClient`.
- `setTemporaryCredentials` / `restoreOriginalCredentials` — swap credentials for the
  settings-form "test connection" AJAX call.

## Publishing a node as a topic
`hook_form_node_form_alter` (`.module`) appends `_discourse_comments_plus_post_node_to_discourse`
to the node form submit handlers. That handler pushes only when the node has no existing
`topic_id`, `push_to_discourse == 1`, and the node is published. It builds the post body from the
node body (rewriting relative `/sites/...` image `src` to absolute using the Domain module host, or
the request host as fallback), appends `_discourse_comments_plus_footer_markup()` (a
`\Drupal::token()->replace()` of the `footer_template`), and calls `post()` with `title`, `raw`,
`category`. The returned `topic_id`, `topic_url`, `reply_count` are saved back onto
`discourse_plus_field`.

## Embedding comments (block)
`Plugin/Block/DiscourseCommentBlock.php` (`discourse_comment_plus_block`): on a node page with a
`topic_id`, fetches the topic, updates the stored `comment_count`, and renders each post
(username, avatar, date, `cooked` HTML) via the `discourse_comment_block` theme
(`templates/discourse-comment-block.html.twig`). If the current session holds
`discourse_comments_plus_sso`, it renders the reply form (`Form\DiscourseCommentForm`); otherwise a
"Login to comment" link to the SSO route. Cache contexts `url.path` + `session`, tag
`discourse_comments_plus.topic_id.{id}`. `Plugin/Block/LatestCommentsBlock.php`
(`latest_comments_plus_block`) renders the cached latest-comments list.

## SSO (DiscourseConnect) flow
Route `discourse_comments_plus.discourse_comments_plus_sso` → `/discourse-comments/sso`
(`_permission: 'access content'`, `no_cache: TRUE`), controller
`Controller\DiscourseCommentsSSOController::__invoke`. Two branches:
- **Initiate** (no `sso`/`sig` query): generate a nonce, build the return URL, base64/HMAC-sign a
  payload with `sso_secret`, and `TrustedRedirectResponse` to
  `{publicUrl}/session/sso_provider?...`.
- **Return** (`sso` + `sig` present): recompute `hash_hmac('sha256', $sso, $sso_secret)` and
  compare with `hash_equals`; on match, base64/parse the payload and store the Discourse user
  attributes in the session key `discourse_comments_plus_sso`, then redirect; on mismatch throw
  `NotFoundHttpException`.

## Posting a reply
`Form\DiscourseCommentForm` (`discourse_comments_plus_comment`) shows a required "Message" textarea
(min 10 chars). `validateForm` requires the `discourse_comments_plus_sso` session key.
`submitForm` reads the node's `topic_id`, appends the footer markup, and calls
`DiscourseApiClient::post(['topic_id'=>..., 'raw'=>...], $sso['username'])` — the reply is posted to
Discourse as the SSO'd username using the site's configured API key — then invalidates the topic
cache tag.

## Drush
`fetch:latest_comments_plus` (alias `fetch_comments_plus`) →
`Commands\FetchLatestComments::fetch()` calls `fetchLatestComments(5)` and invalidates the
`latest_comment_plus_block` tag. Registered via `drush.services.yml`.
