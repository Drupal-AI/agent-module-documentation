<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Assignments Hootsuite turns each enabled Hootsuite social profile into an Assignments bundle so that scheduling an assignment on a node publishes a scheduled Hootsuite post.

---

Assignments Hootsuite extends the Assignments module with a Hootsuite REST-API integration authenticated over OAuth2. An administrator enters the Hootsuite client ID/secret and OAuth2 + API endpoint URLs on the settings form, authorizes the site against Hootsuite (the authorization code is exchanged for access/refresh tokens, which are stored in Drupal `state`), then picks which Hootsuite social profiles to manage. Each selected profile is materialized as an `assignment` bundle (`social_profile_<id>`) with a fixed set of `field_hs_*` fields (post text, schedule date, image, profile id/name, Hootsuite post id, and optional Pinterest board/url). Content editors attach those assignments to nodes via a `field_hs_assignment` reference; node insert/update/delete hooks (in `assignments_hootsuite.module`) drive `HootsuitePostManager`, which schedules, replaces, or deletes the corresponding Hootsuite posts. Post text is token-replaced against the node, images are registered with Hootsuite and uploaded to the returned AWS URL, and Instagram posts are checked for a square image. Requires the `assignments` and `oauth2_client` modules; supports Drupal 10 and 11.

---

- Connect a Drupal site to a Hootsuite account over OAuth2.
- Schedule social-media posts from an editorial (Assignments) workflow.
- Turn each Hootsuite social profile into its own assignment bundle.
- Post to Twitter/X, Facebook, Instagram, LinkedIn, Pinterest, and other Hootsuite-managed profiles.
- Schedule a post to publish at a specific date/time via `field_hs_date`.
- Compose post text with Drupal tokens resolved against the host node.
- Attach an image to a scheduled post (registered with Hootsuite, uploaded to AWS).
- Enforce square images for Instagram before posting.
- Set a Pinterest board id and destination URL for Pinterest assignments.
- Automatically create the scheduled post when a node is inserted.
- Re-schedule (delete + recreate) the post when the node is updated.
- Remove assignments that were detached from a node on update.
- Delete the Hootsuite post when the node or assignment is deleted.
- Skip scheduling for unpublished nodes (unless a future `publish_on` covers it).
- Refresh the OAuth2 access token automatically on 401 responses.
- List and select Hootsuite social profiles from the profiles admin form.
- Store the Hootsuite client ID/secret and endpoint URLs as site config.
- Gate all Hootsuite administration behind one restricted permission.
- Clear the assignment reference on new entity translations.
- Track the Hootsuite post id back on the assignment for later updates/deletes.
