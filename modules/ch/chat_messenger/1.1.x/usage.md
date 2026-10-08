Chat Messenger adds a self-hosted, real-time 1:1 and group chat between site users using AJAX long-polling, with reactions, presence, typing indicators, read receipts, contacts/blocking and private file attachments.

---

Chat Messenger turns a Drupal site into a messaging platform without any external chat server, WebSocket service or Node.js: live updates come from a bounded long-poll endpoint served by normal PHP-FPM workers, protected by a DB-backed concurrency cap. Users get a floating launcher on every page, a conversation list, direct and group threads, an emoji picker and per-message emoji reactions, online/away/busy presence with "last seen", typing indicators, delivered/read ticks, unread badges, per-user "clear chat"/"delete conversation", a mutual-contacts model built on the Flag module, and user blocking. Attachments are stored under `private://chat_messenger` and are downloadable only by members of the conversation they belong to. Message bodies, sender names and attachment filenames are rendered through Twig-escaped templates. Quick-reply suggestions are rule-based by default, or AI-generated through the optional `drupal/ai` module (credentials and provider live in the AI module, not here). Administration lives at Configuration → Media → Chat Messenger and is gated by a restricted `administer chat messenger` permission; day-to-day use requires `use chat messenger`, with separate permissions for creating groups and uploading attachments.

---

- Add private 1:1 messaging between authenticated site users.
- Let users create and manage group conversations.
- Provide a floating, site-wide chat launcher button on every page.
- Deliver new messages live without a page refresh via long-polling.
- Show typing indicators while another member is composing.
- Show delivered and read receipts on the sender's own direct messages.
- Display auto-updating unread-message badges per conversation and in total.
- Offer an emoji picker for composing and per-message emoji reactions.
- Show presence (Available / Busy / Away / Offline) with a "last seen" time.
- Use core user profile pictures as avatars, with initial-based fallbacks.
- Attach images and files to messages, stored in the private filesystem.
- Restrict which file extensions and sizes may be attached.
- Restrict attachment downloads to members of the conversation.
- Let a user "clear chat" to hide history only from their own view.
- Let a user delete a conversation from their own list without affecting others.
- Build a mutual-contacts network (send/accept requests) on top of the Flag module.
- Optionally restrict new direct chats to mutual contacts only.
- Let users block/unblock others, disabling contact in both directions.
- Offer quick-reply suggestion chips when a message is read.
- Generate AI quick replies through a configured drupal/ai provider (optional).
- Cap concurrent long-poll connections to protect the worker pool.
- Run entirely on a standard Drupal/LAMP stack — no WebSocket server or Node.js.
- Power community sites, membership portals and social networks with member chat.
- Add internal messaging to corporate intranets and collaboration portals.
- Add teacher/student or peer messaging to educational platforms.
