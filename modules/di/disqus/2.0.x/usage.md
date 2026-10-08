<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disqus integrates the hosted Disqus commenting service into Drupal: you set your Disqus site "shortname", attach a Disqus comments field to any entity bundle, and the Disqus thread renders in place of (or alongside) Drupal's own comments.

---

The module is configured at `/admin/config/services/disqus` (`disqus.settings`), where you enter the Disqus **shortname** (`disqus_domain`) and optional behavior, API-credential and Single Sign-On settings. Commenting is enabled per entity type by adding a **Disqus comments** field (`disqus_comment` field type, with matching widget and formatter) to a bundle — each entity then gets a Disqus thread keyed by `entityType/entityId`. It also ships display Blocks (recent comments, popular threads, top commenters, and a combination widget), a Views field for comment counts, a render Element, and migrate plugins for importing D7 Disqus data. When the `disqus/disqus-php` API bindings and a user access token are present, the module can update or close/remove Disqus threads as entities are saved or deleted (`hook_entity_update`/`hook_entity_delete`) and send new-comment notification emails via an event subscriber. SSO lets logged-in Drupal users authenticate to Disqus using your public/secret keys, and `hook_disqus_user_data_alter()` lets you customise the SSO payload. Four permissions gate administration and viewing. Note the comment data itself lives on Disqus's servers, not in Drupal.

---

- Replace Drupal core comments with Disqus threads on articles or blog posts.
- Add third-party commenting to a content type by attaching a Disqus comments field.
- Show a "Recent comments" Disqus block in a sidebar.
- Display a "Popular threads" block to surface the most-commented content.
- Add a "Top commenters" block to highlight active community members.
- Embed the Disqus combination widget block (recent + popular + top) in one place.
- Configure a site's Disqus shortname once and reuse it across all threads.
- Let editors toggle comments on/off per node (via the toggle permission).
- Restrict who can view Disqus threads to specific roles.
- Enable Single Sign-On so Drupal users comment as their site identity.
- Brand the SSO login button with the site logo or a custom 143×32 image.
- Pre-fill the Disqus guest login with the current user's name and email.
- Localise the Disqus embed to the site's language.
- Track new Disqus comments as events in Google Analytics.
- Email content authors when a new comment is posted (with a secret key set).
- Update Disqus thread titles/URLs automatically when a node is edited (via the API).
- Close or remove a Disqus thread automatically when its entity is deleted.
- Expose a Disqus comment count as a Views field for listings.
- Attach Disqus comments to non-node entities (users, media, taxonomy terms).
- Show Disqus comments on user profile pages for chosen roles.
- Migrate Disqus configuration and comments from a Drupal 7 site.
- Customise the SSO user payload with a hook (e.g. use a Real Name value).
- Call the Disqus REST API from custom code via `disqus_api()`.
- Provide a consistent moderation and spam-filtering experience through Disqus.
