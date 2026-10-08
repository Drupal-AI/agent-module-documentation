Voting API Tokens exposes Voting API vote aggregates (count, average, best, worst) as dynamic Drupal tokens for any entity type that has received votes.

---

This submodule of Voting API adds token support so vote data can be dropped into any token-aware text. For each entity type that has rows in the `votingapi_vote` table it registers a token group named `votingapi_<entity_type>_token`, each offering four dynamic tokens that take the vote type as their final argument: `vote_count`, `vote_average`, `best_vote`, and `worst_vote`. Count and average are read from Voting API's cached results via the result-function manager's `getResults()`; best and worst are computed on the fly as the max/min raw vote value for that entity and vote type. It requires the contrib `token` module in addition to `votingapi`. It provides no admin UI, permissions, config, or Drush commands — enabling it is all that is needed.

---

- Show a node's total vote count inline via `[votingapi_node_token:vote_count:vote]`.
- Show a node's average rating via `[votingapi_node_token:vote_average:vote]`.
- Show the highest vote an entity received via `[votingapi_node_token:best_vote:vote]`.
- Show the lowest vote an entity received via `[votingapi_node_token:worst_vote:vote]`.
- Insert vote aggregates into automatically generated titles or labels.
- Use vote counts in Pathauto URL alias patterns.
- Include an entity's average rating in outgoing emails (e.g. via Rules or ECA).
- Surface vote data in Metatag / meta description patterns.
- Expose vote aggregates for comment entities via `[votingapi_comment_token:...]`.
- Expose vote aggregates for user entities via `[votingapi_user_token:...]`.
- Reference a specific vote type by passing it as the last token argument.
- Display best/worst scores in views or fields that accept tokens.
- Combine with the Token module's browser to discover the available vote tokens.
- Provide vote-based token values to any contrib module that consumes tokens.
- Avoid custom code for simple "show the rating" needs by using a token instead.
