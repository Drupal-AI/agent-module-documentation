Voting API is a developer framework for building content voting and rating systems in Drupal. It stores individual votes and automatically tallies aggregate results (count, average, sum, min, max, median) for any entity, but provides no end-user voting widget itself.

---

Voting API maintains a shared bin of vote and rating data that other modules build on. Each cast vote is a `vote` content entity (base table `votingapi_vote`) that records the voted entity type and ID, a numeric value, a value type (e.g. `points` or `percent`), the voter (user ID plus a hashed IP `vote_source`), a timestamp, and a vote type (bundle). Vote types are `vote_type` config entities (bundles of `vote`); the module ships one default type, `vote` ("Normal vote"). Whenever votes change, a set of `VoteResultFunction` plugins recalculate aggregate results — Count, Average, Sum, Minimum, Maximum, Median — which are stored as `vote_result` content entities (base table `votingapi_result`) for cheap reads. Recalculation timing is configurable: immediately on each vote, at cron, or manual/never (for modules managing their own cycle). It supports multi-criteria voting (multiple vote types on one entity), anonymous voting throttled by an IP-hash rollover window, and Views integration for both raw votes and results. Modules extend it by adding new result-function plugins or by altering results, metadata, and Views formatters via hooks. A `votingapi_tokens` submodule exposes vote aggregates as tokens.

---

- Add a star-rating or thumbs-up/down system to nodes, comments, users, or any other entity type by casting `vote` entities against them.
- Record votes programmatically from a custom module or REST endpoint by creating and saving `Vote` entities.
- Support multi-criteria ratings (e.g. rate a game on video, audio, and replayability) using multiple vote types on the same entity.
- Store `+1/-1` sentiment votes using a vote type whose `value_type` is `points`.
- Store percentage or star ratings using a vote type whose `value_type` is `percent`.
- Automatically tally the number of votes cast on an entity (Count result function).
- Compute and cache the average rating of an entity (Average result function).
- Compute the total/sum of all vote values (Sum result function).
- Show the highest and lowest vote received (Maximum / Minimum result functions).
- Compute the median vote value to reduce the effect of outliers (Median result function).
- Define your own aggregate calculation (e.g. standard deviation, weighted score) by adding a `VoteResultFunction` plugin.
- Read cached aggregate results for an entity via the result-function manager's `getResults()`.
- Force a full recalculation of an entity's results with `recalculateResults()` or `drush voting:recalculate`.
- Defer heavy result tallying to cron on high-traffic sites via the calculation schedule setting.
- Let a companion module fully own the vote lifecycle by setting the schedule to "manual".
- Throttle anonymous double-voting from the same computer using the anonymous IP-hash rollover window.
- Throttle repeat votes from the same registered user using the user rollover window.
- Create additional vote types (bundles) through the Vote Types admin UI or config for different rating dimensions.
- Automatically purge an entity's votes and results when the voted entity is deleted (entity_delete hook).
- Build Views of raw votes or aggregate results (the module ships a `votingapi_votes` view and Views data for both entities).
- Expose vote aggregates as tokens for use in labels, messages, or other token-aware fields via the `votingapi_tokens` submodule.
- Alter another module's calculated results before they are stored via `hook_votingapi_results_alter()`.
- Rename or relabel built-in result functions via `hook_vote_result_info_alter()`.
- Seed a site with dummy voting data for testing or theming with `drush voting:generate`.
- Wipe all voting data (or just one entity type/ID) with `drush voting:flush`.
- Migrate legacy Drupal 6/7 votes and vote types into Drupal 11 using the bundled migrations.
- Swap the vote storage backend by overriding the `votingapi_vote_storage` state variable.
- Restrict who can view their own vs. any voting data, delete votes, or administer vote types via the module's permissions.
