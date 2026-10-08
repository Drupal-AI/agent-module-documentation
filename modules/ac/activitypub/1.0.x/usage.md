ActivityPub turns a Drupal site into a Fediverse server, letting local users and content be followed, replied to, liked and boosted from Mastodon, Pixelfed, Pleroma and other ActivityPub platforms.

---

ActivityPub (`activitypub`) implements the W3C ActivityPub protocol together with WebFinger and NodeInfo so a Drupal site can federate with the Fediverse. Each participating Drupal user gets one or more ActivityPub *actors* (Person) with a public/private RSA key pair, an inbox, an outbox, and followers/following collections. Content is mapped to ActivityStreams objects through configurable *ActivityPub type* config entities (dynamic types map an entity bundle such as `node:article` to a `Note`; static types cover Follow/Accept/Undo/Delete). Outgoing activities are built and delivered to remote inboxes through queues (cron or manual), signed with HTTP Signatures; incoming activities arrive on per-user and shared inboxes and are stored as `activitypub_activity` entities and surfaced as `activitypub_timeline_item` entities. Bundled submodules add a generic OAuth API layer, a Mastodon-compatible client API, comment federation, a Personal Reader timeline UI, and Scheduler integration. It ships views, blocks (Follow), a search plugin, and Drush commands to operate the queues.

---

- Let external Fediverse users follow a Drupal author and receive their posts in Mastodon/Pleroma.
- Publish nodes (articles, blog posts) automatically as ActivityPub `Note` objects to followers.
- Give each user a federated actor at `/user/{uid}/activitypub/{actor}` discoverable via WebFinger (`@user@yoursite`).
- Expose a per-user inbox and outbox so remote servers can deliver and read activities.
- Run a shared inbox (`/activitypub/inbox`) to reduce per-user delivery load from large instances.
- Receive and display Likes, Announces (boosts) and replies from remote actors as timeline items.
- Follow remote actors from Drupal and build a home timeline of their posts.
- Send Follow/Accept/Undo/Delete activities so relationships stay in sync across the Fediverse.
- Optionally back-fill a remote actor's recent posts into the timeline when a local user follows them.
- Block unwanted domains site-wide or per-user for inbound activities.
- Post with Mastodon-style visibility levels: Public, Unlisted, Followers-only, and Private (direct).
- Configure a site-wide actor so users without their own actor can still publish.
- Add profile metadata fields (PropertyValue attachments) to an actor's Fediverse profile.
- Cache remote avatars, header images, attachment images and videos locally via image styles.
- Serve NodeInfo statistics (`localPosts`, active users) so the instance appears in Fediverse crawlers.
- Process outbox delivery and inbox handling either on cron or via Drush (`drush activitypub:*`).
- Delete old inbound activities and timeline items automatically after N days.
- Provide a Follow block and an ActivityPub search plugin for discovering remote actors/objects.
- Map any entity type/bundle to an ActivityPub object with a field-to-property mapping (dynamic types).
- Send an Update activity to followers when a federated node is edited, and a Delete when it is removed.
- Support account migration: handle inbound Move activities to re-point followers to a new actor.
- Localize actor endpoints on multilingual sites (WebFinger and route handling are language-aware).
- Interact with remote content from node pages (Favourite / Announce interaction forms).
