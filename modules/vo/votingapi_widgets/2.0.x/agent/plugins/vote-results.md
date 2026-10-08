# Field-scoped vote result functions

`VoteResultFunction` is a **Voting API** plugin type (`plugin.manager.votingapi.resultfunction`);
this module adds three that scope aggregation to a single field:

| Plugin id | Class | Result |
|-----------|-------|--------|
| `vote_field_average` | `FieldAverage` | mean of the field's vote values |
| `vote_field_count`   | `FieldCount`   | number of votes on the field |
| `vote_field_useful`  | `FieldUseful`  | count of votes whose value == 1 |

Each is `deriver: FieldResultFunction::class`. `Plugin/Derivative/FieldResultFunction.php`
walks every `voting_api_field` instance (`getFieldMapByFieldType`) and emits one derivative per
`<entity_type>.<field_name>`. So a concrete result key looks like
`vote_field_average:node.field_rating`. Base class `FieldVoteResultBase::getVotesForField()`
filters the passed votes down to those whose `field_name` matches the derivative before the
subclass's `calculateResult(array $votes): float` runs.

The field's **result_function** instance setting picks which one drives the formatter/summary.
`BaseRatingForm` falls back to `vote_field_average:<entity_type>.<field_name>` when none is set.
To add your own aggregate, create a `Plugin/VoteResultFunction/*` class extending
`FieldVoteResultBase` with the same `deriver` and implement `calculateResult()`.
