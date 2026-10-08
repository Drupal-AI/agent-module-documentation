<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content model & backpack award flow

The module ships three node types (config in `config/install/`), all managed by import, not by
hand.

## Content types & fields
- **`badgr_account`** — one node per connected Badgr account (`field_badgr_identifier` = 1 marks
  the primary). Fields: `field_badgr_access_token`, `field_badgr_refresh_token` (both
  `string_long`), `field_badgr_email`, `field_badgr_identifier`.
- **`badgr_issuer`** — imported issuing org. Fields: `body`, `field_badge_account` (ref to
  account), `field_badges_reference` (refs to its badges), `field_issuer_contact_email`,
  `field_issuer_entity_id` (Badgr id), `field_issuer_image`, `field_issuer_website_url`.
- **`badgr_badges`** — imported badge class. Fields: `body` (description), `field_badge_account`,
  `field_badge_earning_criteria`, `field_badge_earning_url`, `field_badge_entity_id` (Badgr id),
  `field_badge_image`.

## BadgrHelpers (`badgr_badge.helpers`)
Class `Drupal\badgr_badge\BadgrHelpers` (args `@entity_type.manager`, `@file_url_generator`,
`@file.repository`):
- `getBadgeClassData()` / `getIssuerClassData()` — build the API POST body; embed a local image as
  a base64 `data:` URI (via `file_get_contents` on the generated absolute URL).
- `getBadgeAssertionData($achieved_date, $user)` — builds the assertion recipient block using
  `$user->getEmail()` (`type: email`, `hashed: TRUE`).
- `createBadgesContent()` / `createIssuersContent()` — upsert `badgr_badges` / `badgr_issuer`
  nodes from API results, matched by entity id; `createBadgesContent()` also appends the badge to
  the issuer's `field_badges_reference`.
- `attachImage()` / `attachIssuerImage()` (protected) — download the API-provided image with
  `file_get_contents()` and save it to `public://` via `fileRepository->writeData()`.

## View & teaser link
`views.view.badgr_badges` renders badges (page `/badgr-badges`, teaser mode).
`badgr_badge_node_view()` (in `.module`) adds an AJAX `#link` (`use-ajax`, `core/drupal.ajax`) to
each `badgr_badges` teaser pointing at route `badgr_badge.addtobackpack` with `badge` = node id and
`acheived_date` = `time()`; teaser cache is disabled (`max-age = 0`).

## Backpack award route/controller
Route `badgr_badge.addtobackpack`: path
`/badgr/addtobackpack/{badge}/{acheived_date}/{nojs}` (`badge` and `acheived_date` constrained to
`\d+`), permission `access content`, `badge` upcast to a node.
Controller `Controller\AddToBackpack::add()`:
1. Reads the badge's `field_badge_entity_id` and its `field_badge_account` (→ access token).
2. `BadgrService::getAwardedBadges()` for the current user's email; if none held,
   `awardBadges()` posts an assertion built by `getBadgeAssertionData()` — recipient is always the
   **current logged-in user's own email**, so a user can only award badges to themselves.
3. Returns an `AjaxResponse` with a `ReplaceCommand` on `#backpack{nid}` carrying a success /
   already-awarded / error message.
