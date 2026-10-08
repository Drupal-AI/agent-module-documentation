# Actions, Rules & ECA integration

Ways to add/remove queue items in response to events or in bulk, without custom code.

Core **Actions** (`src/Plugin/Action`), usable as bulk operations / VBO:
- `AddItemToSubqueue` — add the acted-on entity to a subqueue.
- `RemoveItemFromSubqueue` — remove it from a subqueue.

**Rules** actions (`src/Plugin/RulesAction`, requires the Rules module):
- `AddItemToSubqueue`, `RemoveItemFromSubqueue`, `ClearSubqueueItems`,
  `ReverseSubqueueItems`, `ShuffleSubqueueItems`.

**ECA** condition (`src/Plugin/ECA/Condition`, requires ECA):
- `EntityIsInSubqueueCondition` — branch on whether an entity is already in a subqueue.

Use these to, e.g., auto-add newly published nodes to a "Latest" queue, or clear/reshuffle a
featured queue on a schedule. All of them ultimately call the subqueue item methods documented
in [../api/subqueues.md](../api/subqueues.md).
