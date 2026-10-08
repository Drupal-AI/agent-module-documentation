# Configuration

Getting AI Content Chat working has three parts: set the permissions, place the
chat widget, and index your content so the chatbot has something to answer from.

## Permissions

AI Content Chat provides two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Use AI content chat** (`use ai content chat`) — required to use the chatbot
  and its ask endpoint. This is deliberately **not** granted to anonymous users by
  default: the ask endpoint checks for this permission, so decide which roles
  (including whether the *anonymous* role) may chat.
- **Administer AI content chat** (`administer ai content chat`) — required to
  manage the module and to reindex content. Grant this only to trusted
  administrators.

## Place the chat widget

The chat widget is a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the chat to appear and choose
   the **AI Content Chat** block.
3. Configure the block's visibility as you would any Drupal block (for example
   limit it to certain pages or roles), then save.

Only users with **Use AI content chat** will be able to actually send questions,
regardless of where the widget is shown.

## The ask endpoint

Behind the widget, questions are sent to the ask endpoint at
`/api/ai-content-chat/ask`. It is protected by the **Use AI content chat**
permission, so it is not open to anonymous visitors unless you grant them that
permission. Each question is answered through your configured AI provider, so
usage incurs a per‑request cost.

## Index (and reindex) your content

The chatbot answers from an index of your site content, so that index needs to be
built and kept current. Reindexing is gated by the **Administer AI content chat**
permission. Run a reindex after installing, and again whenever your content
changes enough that answers should reflect it, so the chatbot stays grounded in
the latest content.
