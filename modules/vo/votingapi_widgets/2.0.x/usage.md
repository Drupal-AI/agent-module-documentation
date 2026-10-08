Votingapi Widgets turns [Voting API](https://www.drupal.org/project/votingapi) into a field-based rating system: you add a "Voting API" field to any entity bundle, pick a widget (five-star, like/thumbs-up, or useful up/down), and site visitors cast votes inline via an AJAX form. Results (average, count, useful score) are computed by Voting API result functions and rendered by the field formatter.

---

The module provides a `voting_api_field` field type plus its widget and formatter. The field's *storage* settings choose the Voting API vote type and the **widget plugin** (`fivestar`, `like`, `useful`); the *instance* settings choose the result function and anonymous/registered vote rollover windows; the *formatter* settings choose the visual style, read-only mode, whether to show results, and whether to show the viewer's own vote. Widgets are a plugin type this module **defines** — a `VotingApiWidgetManager` (service `plugin.manager.voting_api_widget.processor`, discovery dir `Plugin/VotingApiWidget`, PHP Attribute + legacy Annotation `VotingApiWidget`, base class `VotingApiWidgetBase`, interface `VotingApiWidgetInterface`) — so you can add custom widgets. It also ships three `VoteResultFunction` derivatives (`vote_field_average`, `vote_field_count`, `vote_field_useful`) that scope Voting API results to a specific field. Voting is gated by dynamic per-field permissions generated in `FieldPermissions.php` (vote / edit own vote / clear own vote / edit voting status, one set per field). The vote form (`BaseRatingForm`) is an AJAX-submitted content-entity form rendered through a lazy builder (`VotingApiLazyLoader`), and saving is refused unless the current user passes the field's `canVote()` permission check. The five-star widget requires the [jQuery Bar Rating](https://github.com/antennaio/jquery-bar-rating) JS library at `/libraries/jquery-bar-rating` (a `hook_requirements` check warns if missing); like/useful widgets do not. Depends on `votingapi` (^4.0) and core `field`.

---

- Add a five-star rating field to article nodes.
- Let users "like" content with a thumbs-up widget.
- Add a useful / not-useful (thumbs up/down) vote to comments or docs.
- Show the average star rating on a node's full view.
- Show a vote count ("42 votes") next to content.
- Display a read-only rating (results shown, voting disabled).
- Let editors open or close voting per node via the field's Open/Closed status.
- Restrict who can vote on a specific field using per-field permissions.
- Allow anonymous voting with an IP-based rollover window to limit double votes.
- Set a rollover window so registered users can change their vote for a period.
- Show the viewer's own cast vote instead of the aggregate result.
- Choose a bar-rating theme (css-stars, fontawesome-stars, bootstrap-stars, bars-*) per formatter.
- Build a custom widget plugin (e.g. a 10-point scale) by extending `VotingApiWidgetBase`.
- Compute a custom aggregate by adding a `VoteResultFunction` derivative.
- Let users clear their own vote where the clear permission is granted.
- Collect star ratings on a product or review content type.
- Add a like button to teasers in a listing view mode.
- Seed an initial vote value from the entity edit form (show-initial-vote widget option).
- Theme the results summary per widget/entity/bundle/field via template suggestions.
- Gate voting-status editing (open/close) to a moderator role only.
- Rate media items or taxonomy terms, not just nodes.
- Expose different result functions (average vs count) in different view modes.
