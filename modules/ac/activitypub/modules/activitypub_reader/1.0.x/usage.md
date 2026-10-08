ActivityPub Reader plugs ActivityPub timelines into the Personal Reader module so a logged-in user can read and interact with the Fediverse inside Drupal.

---

ActivityPub Reader (`activitypub_reader`) implements the `hook_reader_*` API of the Personal Reader (`drupal/reader`) module. Its `Reader` service exposes ActivityPub channels (home, notifications, direct messages, bookmarks) and renders stored `activitypub_activity`/`activitypub_timeline_item` records — plus remote content — into the reader's timeline, author and single-post views. It provides sources management (follow/unfollow remote actors), per-item and per-post actions (like/announce/reply/bookmark/mute/delete) and pagination, backed by the parent module's timeline manager, outbox and media cache. A settings form controls how many posts appear per timeline.

---

- Show a Fediverse home timeline of followed actors inside the Personal Reader UI.
- Provide a notifications channel (follows, likes, boosts, mentions) for the current user.
- Provide a direct-messages channel and a bookmarks channel.
- Let a user follow and unfollow remote actors from the reader's sources page.
- View a single remote/local post and its context in the reader.
- View an author's timeline of posts.
- Like (Favourite) a post from the reader.
- Boost (Announce) a post from the reader.
- Reply to a post, creating an outbound activity.
- Bookmark and un-bookmark posts.
- Mute/unmute items or authors in the timeline.
- Delete the user's own activities/timeline items from the reader.
- Paginate long timelines with a configurable per-page count.
- Render remote avatars, images and video via the parent module's media cache.
- Surface follow requests awaiting confirmation in the sources list.
- Reuse the parent module's actor, timeline and outbox services for all interactions.
