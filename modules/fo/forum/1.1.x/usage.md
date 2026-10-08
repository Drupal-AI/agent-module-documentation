Forum provides threaded discussion boards for a Drupal site: a hierarchy of containers and forums (stored as taxonomy terms) in which users post "Forum topic" nodes and reply with comments.

---

Forum turns Drupal's node, taxonomy, comment and history subsystems into a classic message-board experience. Installing it creates a `forums` taxonomy vocabulary, a `Forum topic` content type (`forum`), a `taxonomy_forums` term-reference field that ties each topic to exactly one forum, and a `comment_forum` comment type for replies. Editors manage the board structure at **Admin → Structure → Forums** (`/admin/structure/forum`, route `forum.overview`): they add *containers* (grouping-only terms flagged `forum_container = 1`) and *forums* (leaf terms, `forum_container = 0`) and drag them into a tree. Visitors browse the index at `/forum`, drill into a forum at `/forum/{term}`, and read topics with forum-specific breadcrumbs. Global behavior — topics per page, hot-topic threshold, default sort order, and the item counts for the two forum blocks — lives in `forum.settings` (form at `/admin/structure/forum/settings`, route `forum.settings`). The module ships two blocks, **Active forum topics** (`forum_active_block`) and **New forum topics** (`forum_new_block`), and exposes a `forum_manager` service plus a `forum.index_storage` service for querying the board programmatically. A `ForumLeaf` validation constraint prevents posting a topic into a container, and a set of theme hooks (`forums`, `forum_list`, `forum_icon`, `forum_submitted`, `forum_topic`) control the rendered output. Once core Drupal, now maintained as a contrib module, it depends on `node`, `taxonomy`, `comment`, `options` and `history`.

---

- Stand up a community discussion board / message board on a Drupal site
- Organize discussions into a hierarchy of containers and sub-forums
- Group related forums under a non-postable "container" heading (e.g. "Support", "General")
- Let registered users start new discussion threads as "Forum topic" nodes
- Enable threaded replies to topics via the dedicated `comment_forum` comment type
- Show a "New forum topics" block of the most recently created topics in a sidebar
- Show an "Active forum topics" block of the threads with the most recent replies
- Track read/unread topics per user via core History integration
- Mark high-traffic threads as "hot" once they cross a configurable reply threshold
- Sticky important announcements to the top of a forum listing
- Set how many topics appear per forum page (pagination) site-wide
- Choose the default sort order for topics (newest post, newest topic, most posts, most views)
- Provide forum-aware breadcrumbs that trace container → forum → topic
- Move an existing forum or container to a different position in the tree
- Restrict who can manage the board with the "Administer forums" permission
- Gate topic creation and replies with standard node/comment permissions per role
- Migrate legacy Drupal 6/7 forums into Drupal 11 via the bundled migrate process plugin
- Query the forum index (topic counts, last-post data) from custom code via `forum.index_storage`
- List a forum's child forums/containers and topics through the `forum_manager` service
- Prevent editors from accidentally posting a topic into a container (ForumLeaf constraint)
- Build a knowledge base or Q&A area where each answer is a comment on a topic
- Run a per-project or per-department internal discussion space
- Customize forum listing markup by overriding the `forums` / `forum_list` theme hooks
- Add a custom "new/updated" icon by overriding the `forum_icon` theme hook
- Expose forum topics in Views using the forum Views integration
- Point the module at a different taxonomy vocabulary via the `forum.settings` `vocabulary` key
