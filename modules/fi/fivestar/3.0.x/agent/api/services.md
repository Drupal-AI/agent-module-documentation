<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fivestar services (programmatic API)

Three autowired services. Interfaces are in `Drupal\fivestar\*Interface` and can be
type-hinted for autowiring.

## `fivestar.vote_manager` — `VoteManagerInterface`

Cast and query Voting API votes.

- `getVoteTypes(): array` — `[vote_type_id => label]` of all `vote_type` config entities.
- `addVote(FieldableEntityInterface $entity, mixed $rating, string $vote_type = 'vote', $uid = NULL): VoteInterface`
  — creates and saves a `vote` entity on `$entity` (rating capped at 100; `$uid` defaults to
  current user). Returns the Vote.
- `getVotesByCriteria(array $criteria): array` — loads `vote` entities by properties
  (`entity_id`, `entity_type`, `type`, `user_id`, `vote_source`).
- `deleteVote(): void` — no-op in this version.

```php
$vm = \Drupal::service('fivestar.vote_manager');
$vm->addVote($node, 80, 'vote');        // 80/100 == 4/5 stars
$votes = $vm->getVotesByCriteria(['entity_type' => 'node', 'entity_id' => $node->id()]);
```

## `fivestar.vote_result_manager` — `VoteResultManagerInterface`

Read Voting API **aggregated** results (delegates to `votingapi`'s
`VoteResultFunctionManager`).

- `getResults(FieldableEntityInterface $entity): array` — all results, keyed by vote type.
- `getResultsByVoteType($entity, string $vote_type): array` — results for one vote type, or
  the default set if none.
- `getDefaultResults(): array` — `['vote_sum'=>0,'vote_user'=>0,'vote_count'=>0,'vote_average'=>0]`.
- `recalculateResults($entity): void` — force Voting API to recompute aggregates.

The per-vote-type result array carries `vote_average` (0–100), `vote_count`, `vote_user`,
`vote_sum`; formatters/elements convert `vote_average` to stars via
`stars = vote_average * stars / 100`.

## `fivestar.widget_manager` — `WidgetManagerInterface`

Discover star skins (see [../plugins/plugins.md](../plugins/plugins.md)).

- `getWidgets(): array` — all skins (`key => ['label','library']`) after
  `hook_fivestar_widgets` + `_alter`.
- `getWidgetsOptionSet(): array` — `[key => label]` for form `#options`.
- `getWidgetInfo($key)`, `getWidgetLabel($key)`, `getWidgetLibrary($key)`.

## Access

Voting access also consults `hook_fivestar_access($entity_type, $id, $vote_type, $uid)` — see
[../hooks/hooks.md](../hooks/hooks.md) — and the **`rate content`** permission.
