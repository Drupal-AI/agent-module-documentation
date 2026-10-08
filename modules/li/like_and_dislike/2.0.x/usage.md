<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Like & Dislike adds a thumbs-up / thumbs-down widget to any content entity type or bundle you enable, recording two separate Voting API vote types (like and dislike) that are mutually exclusive per user, with counts that update in place over AJAX.

---

Like & Dislike (`like_and_dislike`) builds on Voting API to give entities a social-style like/dislike widget. On a settings page you choose which content entity types and bundles expose the widget; the module then adds a `like_and_dislike` display component (and a matching Views field) that renders two thumbs with live tallies. A permitted user clicks a thumb and an AJAX POST to `/like_and_dislike/{entity_type}/{vote_type}/{entity_id}` creates or cancels a `vote` entity — liking removes any prior dislike and vice versa. Voting is gated by dynamic per-type/bundle permissions (`add or remove like|dislike votes on …`); `allow_cancel_vote`, `hide_vote_widget`, and `check_vote_init` tune the interaction. It requires the Voting API module (`drupal/votingapi:^3.0`) and provides no Drush commands.

---

- Add a like/dislike widget to article nodes.
- Let members react to blog posts with thumbs up/down.
- Enable voting on comments.
- Add reactions to user profiles.
- Show like and dislike counts on content.
- Let users cancel a vote by clicking the same thumb again.
- Prevent a user from both liking and disliking the same item.
- Restrict voting to authenticated users via permissions.
- Grant a role the right to like only certain bundles.
- Hide the widget entirely from users who cannot vote.
- Disable (grey out) the widget for anonymous visitors.
- Highlight a user's existing vote when the page loads.
- Add the like/dislike widget as a Views field in a listing.
- Rank a content listing by like tallies (via Voting API results).
- Surface a "most liked" block using Voting API vote sums.
- Collect quick feedback on documentation pages.
- Gauge sentiment on landing pages.
- Add thumbs to media entities.
- Place the widget in Manage display for a specific view mode.
- Render the widget programmatically via the vote_builder service.
- Migrate existing Voting API like/dislike data without changes.
- Expose likes/dislikes in a decoupled front end through the vote endpoint.
- Enable reactions per node type without touching the theme.
- Track positive vs negative reactions separately.
- Let editors A/B popular content by like count.
