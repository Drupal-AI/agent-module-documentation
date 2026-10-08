<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST endpoints

Three POST routes (`brightedge_autopilot_page_publisher.routing.yml`), all `methods: [POST]` and
all `requirements: _access: 'TRUE'`. Access is not enforced by the router — each controller instead
calls `BeAPPLibrary::authenticateUser($username, $password)` as its first step. All request fields
are read from the POST body (`$request->request->get(...)`).

## Authentication — `BeAPPLibrary::authenticateUser()` (`src/BeAPPLibrary.php`)

1. `username` + `password` both required (empty → 401 `AUTH_EMPTY_CREDS`).
2. `loadUserByUsername()` → `entityTypeManager->getStorage('user')->loadByProperties(['name' => $username])`.
3. Password verified with `\Drupal::service('password')->check($password, $user->getPassword())`
   (proper hash check; wrong/no user → 401 `AUTH_INVALID_CREDS`).
4. User must be active (blocked → 401 `AUTH_BLOCKED_USER`) **and** hold the **`administer nodes`**
   permission (missing → 401 `AUTH_MISSING_PERMISSION`).
5. Success returns `['status' => TRUE, 'user' => $user]`.

Every endpoint also handles the sentinel `page_url == 'Brightedge_Autopilot_Test'`: it returns
`API_TEST_SUCCESS` plus the authenticated user's roles (comma-joined) — the platform's connectivity
handshake. Responses are built by `BeAPPLibrary::sendResponse($status,$code,$message,$errorCode?,$role?)`
as JSON `{status, message, plugin_version:'1.6.0', error_code?, user_role?}`.

## `POST /beapp/v1/drupal/update-meta` — `UpdateEntityRestController::updateMeta`

Fields: `username`, `password`, `page_url`, `meta_title`, `meta_description`, `find_h1`, `replace_h1`
(the meta/h1 values are passed through `Html::escape()` on read).

- Requires `page_url` plus at least one of `meta_title` / `meta_description` / (`find_h1` **and**
  `replace_h1`) — else `ERROR_INCOMPLETE_DATA`.
- `BeAPPLibrary::getRouteNameAndParams(parse_url($page_url)['path'])` resolves the path via
  `path.validator`; only routes beginning `entity.` are accepted, and the regex
  `/entity\.(.*?)\.canonical.*?:(\d+)/` extracts `entity_name` + `entity_id`. Entity types
  `files`, `media`, `user` are refused (`$restricted_entity_types`).
- **H1**: `find_h1` is normalized (`BeAPP_normalize_string`); if `entity->getTitle()`/`getName()`
  equals it, `setTitle()`/`setName($replace_h1)`. No match → `ERROR_H1_NOT_FOUND`; entity without
  title/name → `ERROR_H1_NOT_SUPPORTED`.
- **Meta**: finds the entity's first field of type `metatag`; if none, **auto-creates**
  `field_meta_tags` (FieldStorageConfig + FieldConfig, `metatag_firehose` widget, empty formatter)
  on the bundle. Existing metatag JSON gets `title`/`description` set and re-`json_encode`d; if the
  field was empty it stores a **PHP `serialize()`d** array instead.
- `entity->save()` → `GENERAL_SUCCESS`.

## `POST /beapp/v1/drupal/read-meta` — `ReadEntityRestController::readMeta`

Fields: `username`, `password`, `page_url`.

- Validates `parse_url($page_url)['path']` is a real route (`getRouteNameAndParamsInArray`).
- Fetches the page server-side: `\Drupal::httpClient()->get($page_url, ['timeout'=>30,'verify'=>true,'allow_redirects'=>true])`.
- Scrapes with regex: `<title>`, `<meta name="description">`, and all `<h1>` (via `strip_tags`).
  Returns JSON `{status, page_type, id, meta_title, meta_description, all_h1[], is_h1_publishing_supported, plugin_version}`.
  `is_h1_publishing_supported` is TRUE only for `node` / `taxonomy_term`.

## `POST /beapp/v1/drupal/update-xpath` — `BeAPPAgentUpdateContent::updateContentViaXpath`

Fields: `username`, `password`, `page_url`, `xpath`, `new_text`, `new_img_src`, `new_href`,
`og_text_val`, `og_img_src_val`, `og_href_val`, `ignore_query_params` (default 1), `wlqp`
(whitelist query params, CSV), `blqp` (blacklist query params, CSV). All the string fields above are
run through `Html::escape()` on read.

- `checkUrlIsValid($page_url)` must pass (valid route) → else `ERROR_PAGE_NOT_FOUND`.
- `wlqp`/`blqp` mutate the `whitelisted_params` config (add/remove) and re-save it — **this is how the
  config object is populated at runtime; there is no settings form.**
- Builds `page_path` from the URL; if the URL has query params and `ignore_query_params` is truthy it
  refuses (`URL_WITH_QUERY_PARAMS_IGNORED`); otherwise it appends whitelisted params
  (`buildUrlPathWithWhitelistedParams`).
- The XPath's last tag must be in a fixed allowlist (`h1..h6, span, a, img, p, pre, div, blockquote,
  li, b, i, strong, em, u, mark, small, textarea, label, summary, article, section`) else
  `XPATH_TAG_NOT_SUPPORTED`.
- `BeAPPLibrary::validateXPath()` re-fetches the page with `?beapp_xpath_mod=false&nocache=<time>`
  (`httpClient()->get`), loads it into `DOMXPath`, and confirms the XPath resolves (and, if an
  `og_*` original value was supplied, that it still matches the live DOM).
- On success, `updateContentOnDbXpath()` upserts the serialized override map into `beapp_seo_references`
  keyed by `page_path` (see [xpath-rewrite.md](xpath-rewrite.md)).

## Response message constants

All human strings live in `src/BeAPPResponseMessages.php` (e.g. `GENERAL_SUCCESS`,
`ERROR_INCOMPLETE_DATA`, `ERROR_UNSUPPORTED_PAGE`, `XPATH_TAG_NOT_SUPPORTED`, `AUTH_*`).
