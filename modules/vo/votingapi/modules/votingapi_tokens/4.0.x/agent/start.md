# Voting API Tokens (votingapi_tokens) 4.0.x

Submodule of [votingapi](../../../../4.0.x/agent/start.md). Exposes Voting API
vote aggregates as dynamic tokens. Requires `votingapi` and the contrib `token`
module. No config, permissions, or Drush — just enable it.

## Tokens

For every entity type that has votes in `votingapi_vote`, a token group
`votingapi_<entity_type>_token` is registered with four dynamic tokens; the
final segment is the vote type (bundle):

- `[votingapi_<entity_type>_token:vote_count:<vote_type>]` — number of votes (from cached results).
- `[votingapi_<entity_type>_token:vote_average:<vote_type>]` — average value (from cached results).
- `[votingapi_<entity_type>_token:best_vote:<vote_type>]` — highest raw vote value (computed via max()).
- `[votingapi_<entity_type>_token:worst_vote:<vote_type>]` — lowest raw vote value (computed via min()).

Example: `[votingapi_node_token:vote_average:vote]`.

Implemented in `votingapi_tokens.tokens.inc` (`hook_token_info` /
`hook_tokens`). count/average come from
`plugin.manager.votingapi.resultfunction`'s `getResults()`; best/worst load the
raw votes for the entity + vote type. Entity types with no votes yet register no
token group.
