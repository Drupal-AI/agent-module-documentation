# API: service, vote endpoint, helper functions

## Service

`like_and_dislike.vote_builder` → `Drupal\like_and_dislike\LikeDislikeVoteBuilder`
(implements `LikeDislikeVoteBuilderInterface`, `TrustedCallbackInterface`).
Constructor args: `@entity_type.manager`, `@current_user`, `@config.factory`.

```php
$build = \Drupal::service('like_and_dislike.vote_builder')->build($entity_type_id, $entity_id);
```

`build($entity_type_id, $entity_id)` returns the widget render array (`#theme => 'like_and_dislike_icons'`).
It loads the entity, reads `hide_vote_widget` / `check_vote_init`, computes per-vote-type access via
`like_and_dislike_can_vote()`, reads current tallies via `like_and_dislike_get_votes()`, builds a
`like` and/or `dislike` icon (each with `data-entity-id` / `data-entity-type` / `data-entity-op`
attributes; `voted` class if the user already voted and `check_vote_init` is on; `disable-status`
class if the user lacks that vote's permission), attaches library `like_and_dislike/icons`, and
attaches `like_and_dislike/behavior` only when the user may vote. Used by the entity display
lazy builder (see [../hooks/hooks.md](../hooks/hooks.md)) and by the Views field
(see [../views/field.md](../views/field.md)).

## Vote endpoint

Route `like_and_dislike.vote`:

```
/like_and_dislike/{entity_type_id}/{vote_type_id}/{entity_id}
  _controller:     \Drupal\like_and_dislike\Controller\VoteController::vote
  _custom_access:  \Drupal\like_and_dislike\Controller\VoteController::voteAccess
  options._auth:   [ basic_auth, cookie ]
```

`voteAccess()` loads the entity and returns `AccessResult::allowedIf(like_and_dislike_can_vote(currentUser, $vote_type_id, $entity))`
— i.e. the caller must hold the matching per-type/bundle vote permission (see
[../permissions/permissions.md](../permissions/permissions.md)).

`vote()` behavior (returns a `JsonResponse`):

1. Reads current `like`/`dislike` tallies for the entity.
2. Looks up the user's existing votes of this `vote_type_id` on this entity via
   `vote` storage `getUserVotes(uid, vote_type_id, entity_type_id, entity_id)`.
3. **No existing vote** → creates a `vote` entity (`type` = vote type, value 1), saves it, and if the
   user had an opposite-type vote (like vs dislike) deletes that one — the two are mutually exclusive.
   Returns `message_type: status`, "Your vote was added.", and the `operation` map.
4. **Existing vote + `allow_cancel_vote` TRUE** → deletes the user's vote of that type
   ("Your vote was canceled.").
5. **Existing vote + `allow_cancel_vote` FALSE** → no change; `message_type: warning`,
   "You are not allowed to vote the same way multiple times."

Every successful branch resets the entity view builder cache so the next render shows the new tally.
JSON keys returned: `likes`, `dislikes`, `operation` (`{like: bool, dislike: bool}`), `message_type`,
`message`.

The opposite-vote removal is enforced in two places: inline in `vote()` and again by the
`hook_ENTITY_TYPE_insert` implementation `like_and_dislike_vote_insert()` (deletes the opposite vote
type for the voter whenever any `like`/`dislike` vote entity is inserted).

### Client side

`js/like_and_dislike_service.js` exposes `window.likeAndDislikeService.vote(entity_id, entity_type, tag)`
which issues `POST baseUrl + like_and_dislike/{entity_type}/{tag}/{entity_id}` and updates the count
spans and `voted` classes from the JSON. `js/like_and_dislike.js` (behavior `likeAndDislike`) wires
click/keyboard on `.vote-widget--like-and-dislike` links to that service, skipping any link marked
`disable-status`.

## Procedural helpers (in `like_and_dislike.module`)

| Function | Returns | Purpose |
|---|---|---|
| `like_and_dislike_is_enabled(EntityInterface $entity)` | bool | Whether the entity's type (and bundle, if bundled) is enabled in `enabled_types`. |
| `like_and_dislike_get_votes(EntityInterface $entity)` | `[likes, dislikes]` (ints) | Sums `like`/`dislike` `vote_sum` results via `vote_result` storage. |
| `like_and_dislike_can_vote(AccountInterface $account, $vote_type_id, EntityInterface $entity)` | bool | Permission check used by access + widget (type-level OR bundle-level permission). |

Vote data itself lives entirely in Voting API (`vote` / `vote_result` entities); this module adds no
storage of its own. The two vote types `like` and `dislike` are installed as
`votingapi.vote_type.*` config.
