# Voting API (votingapi) 4.0.x

Developer framework for voting/rating. Stores individual votes (`vote` content
entity, table `votingapi_vote`), tallies aggregates into `vote_result`
(table `votingapi_result`) via `VoteResultFunction` plugins. Vote types are
`vote_type` config-entity bundles. No end-user widget is provided — you cast
votes in code and read cached results. Requires no other module (the
`votingapi_tokens` submodule needs `token`).

- [Cast votes & read results in code](api/vote-service.md) — Vote entity fields, casting a vote, `getResults()`, `recalculateResults()`.
- [Result-function plugins](plugins/vote-result-function.md) — the 6 built-in aggregators and how to add your own.
- [Configure tallying & vote types](configure/settings.md) — settings keys, calculation schedule, rollover windows, vote types.
- [Hooks](hooks/alter-hooks.md) — alter results, result-function info, and metadata.
- [Permissions](permissions/permissions.md) — the five permissions and what they gate.
- [Drush commands](drush/commands.md) — generate, recalculate, and flush voting data.

Submodule: [votingapi_tokens](../../modules/votingapi_tokens/4.0.x/agent/start.md) — exposes vote aggregates as tokens.
