# Casting votes & reading results

## The `vote` content entity

Base table `votingapi_vote`. Bundle = a `vote_type` config entity. Base fields
(from `Vote::baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `id` | integer | auto |
| `uuid` | uuid | |
| `type` | entity_reference → `vote_type` | the bundle / vote type |
| `entity_type` | string | type of the voted entity, default `node` |
| `entity_id` | entity_reference | ID of the voted entity |
| `value` | float | the numeric vote value (required) |
| `value_type` | string | e.g. `points`, `percent`; default `percent` |
| `user_id` | entity_reference → user | defaults to current user |
| `timestamp` | created | defaults to request time |
| `vote_source` | string | sha256 hash of the client IP; default callback |

`\Drupal\votingapi\VoteInterface` getters/setters: `getVotedEntityType()/set`,
`getVotedEntityId()/set`, `getValue()/set`, `getValueType()/set`,
`getCreatedTime()/set`, `getSource()/set`, plus `EntityOwnerInterface`
(`getOwner`, `getOwnerId`, `setOwnerId`).

## Cast a vote

```php
use Drupal\votingapi\Entity\Vote;

$vote = Vote::create(['type' => 'vote']);   // 'vote' is the vote type (bundle)
$vote->setVotedEntityType('node');
$vote->setVotedEntityId($node->id());
$vote->setValueType('points');              // or 'percent'
$vote->setValue(1);                         // e.g. +1
// user_id, timestamp and vote_source default automatically.
$vote->save();
```

On save, if `votingapi.settings:calculation_schedule` is `immediate` (the
default), results for that entity+vote type are recalculated automatically.
Deleting a vote likewise triggers recalculation.

## Read aggregate results

Service: `plugin.manager.votingapi.resultfunction`
(typed: `\Drupal\votingapi\VoteResultFunctionManagerInterface`).

```php
$manager = \Drupal::service('plugin.manager.votingapi.resultfunction');

// Nested array: [vote_type][function_id] = value, e.g.
//   $results['vote']['vote_count'], $results['vote']['vote_average']
$results = $manager->getResults('node', $node->id());

// Force a rebuild of the cached results for one entity + vote type:
$manager->recalculateResults('node', $node->id(), 'vote');
```

Results are stored as `vote_result` content entities (table `votingapi_result`,
columns include `entity_type`, `entity_id`, `type`, `function`, `value`,
`value_type`, `timestamp`). `function` is the plugin id (e.g. `vote_count`).

## Query / delete a user's votes

`VoteStorageInterface` (storage of the `vote` entity) adds:
`getUserVotes($uid, $vote_type_id?, $entity_type_id?, $entity_id?, $vote_source?)`,
`deleteUserVotes(...)`, `getVotesSinceMoment()`, and
`deleteVotesForDeletedEntity($entity_type_id, $entity_id)`.

Storage can be swapped by setting the `votingapi_vote_storage` state variable to
an alternative class.
