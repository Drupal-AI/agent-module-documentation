# Permissions

Defined in `like_and_dislike.permissions.yml`: one static permission plus a dynamic callback
`Drupal\like_and_dislike\LikeDislikePermissions::buildPermissions`.

## Static

| Permission | Grants |
|---|---|
| `administer like and dislike` | Access the settings form (`like_and_dislike.admin_settings`). Restricted/admin permission. |

## Dynamic (per enabled type/bundle × vote type)

`LikeDislikePermissions::buildPermissions()` iterates `like_and_dislike.settings:enabled_types` and,
for each of the two Voting API vote types (`like`, `dislike`), emits one permission:

| Enabled entry | Permission string emitted |
|---|---|
| Entity type with **no** enabled bundles (empty list) | `add or remove {vote_type} votes on {entity_type_id}` |
| Entity type with enabled **bundles** | `add or remove {vote_type} votes on {bundle} of {entity_type_id}` (one per bundle) |

Examples: `add or remove like votes on article of node`,
`add or remove dislike votes on article of node`, `add or remove like votes on user`.

These permissions only exist while the corresponding type/bundle is enabled in settings — enabling a
type first, then granting the generated permission, is the required order.

## How they gate voting

`like_and_dislike_can_vote(AccountInterface $account, $vote_type_id, EntityInterface $entity)`
(in `.module`) returns TRUE if the account holds **either** the entity-type-level permission
`add or remove {vote_type} votes on {entity_type_id}` **or** the bundle-level permission
`add or remove {vote_type} votes on {bundle} of {entity_type_id}`.

- The vote route's custom access check (`VoteController::voteAccess()`) calls this helper, so a POST
  to the vote endpoint is refused (403) unless the current user holds a matching permission for that
  entity type / bundle and vote type.
- `LikeDislikeVoteBuilder::build()` calls it per vote type to decide whether each thumb is active
  (clickable + JS attached) or rendered disabled/hidden (per `hide_vote_widget`).

There is no separate "view counts" permission — tallies render for anyone who can see the entity
display component; only *casting* a vote is permission-gated.
