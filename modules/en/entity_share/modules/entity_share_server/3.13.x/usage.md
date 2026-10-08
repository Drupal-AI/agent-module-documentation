Entity Share Server is the **server side** of Entity Share: enable it on the site that holds content, and define **Channel** config entities (`channel`) that expose an entity type + bundle + language as an access-controlled JSON:API collection for remote clients to pull.

---

Entity Share Server is a submodule of **entity_share**. It defines the `channel` config entity type and its admin UI at **Config → Web services → Entity Share → Channels** (`entity.channel.collection`). Each Channel selects one `channel_entity_type` (e.g. `node`), `channel_bundle` (e.g. `article`), and `channel_langcode`, then optionally narrows the exposed set with JSON:API `channel_filters`, `channel_sorts`, `channel_groups`, and `channel_searches`, and caps results with `channel_maxsize`. Access is governed per channel by `access_by_permission`, `authorized_roles`, and `authorized_users` (UUIDs). The module registers a JSON:API entry-point route (`Drupal\entity_share_server\Routing\Routes`) so clients can discover channels. It depends on core **JSON:API** and the base `entity_share` module, and provides the permissions `administer_channel_entity` and `entity_share_server_access_channels`. It has no plugin types or Drush of its own — a channel is pure exported configuration.

---

- Expose a specific content type (bundle) to remote Entity Share clients.
- Publish only one language of a bundle through a channel.
- Restrict a channel to selected roles so only trusted sites can pull it.
- Grant channel access to specific users by UUID.
- Authorize any user holding the pull permission via `access_by_permission`.
- Filter a channel to only published nodes with a JSON:API condition.
- Filter a channel by a taxonomy term, author, or date range.
- Sort channel output for deterministic, paged pulls.
- Group filter conditions with AND/OR conjunctions.
- Cap channel page size with `channel_maxsize` for large datasets.
- Serve multiple channels (one per bundle) from a single hub site.
- Expose media or file entities as a channel for asset syndication.
- Provide a stable JSON:API collection URL for downstream clients.
- Export channels as configuration for deployment across environments.
- Make an authoring site a content source for many satellite sites.
- Combine with core JSON:API access without writing custom REST resources.
- Add or edit channel filters/sorts through the channel sub-forms in the admin UI.
- Create channels in code via the `channel` entity storage for automated provisioning.
- Audit which bundles are shared by listing all `channel` config entities.
- Let one site be both a server (channels) and a client (remotes) simultaneously.
