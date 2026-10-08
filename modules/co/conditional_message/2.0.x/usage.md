<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Conditional Message shows a configurable coloured banner at the top or bottom of the page, displayed or hidden according to role, path, content type, per-session and user-dismiss (close) conditions.

---

Each message is a `conditional_message` config/content entity (translatable, publishable) with fields for the message HTML, background/font colour, position (top/bottom), target selector, and a set of enabled conditions. `hook_page_attachments()` pushes each published message's front-end-checkable data (message, colours, position, target, conditions, a crc32 hash) into `drupalSettings`, and the behaviour in `js/conditional_message.js` decides visibility: session and close state are tracked in `localStorage`, path and content-type checks run client-side, while **role** checks run server-side. For the role check the JS calls an uncacheable JSON endpoint, `GET /conditional_message_data_output` (`_permission: 'access content'`), whose controller (`ConditionalMessageController::jsonOutput`) returns, per published message, the computed display flags plus the message's configured paths, content types and a close flag.

Administer messages at `/admin/content/conditional-message` (`view conditional message overview`), with create/edit/delete gated by dedicated entity permissions (`add|edit|delete conditional message entities`, `administer conditional message entities`). The JSON endpoint is **read-only** — it performs an access-checked entity query and returns display configuration; it does not mutate any state and takes no request parameters, so there is no CSRF surface. It does expose the configured paths/roles/content-types of published messages to anyone with `access content` (anonymous by default), but that is display metadata intended to reach the browser anyway (see security note in the agent index).

---

- Show a site-wide announcement banner to all visitors
- Show a message only to specific user roles
- Restrict a message to certain URL paths
- Restrict a message to specific content types
- Show a message only once per browser session
- Let users dismiss (close) a message and remember it
- Place the banner at the top or bottom of the page
- Target a specific DOM element as the banner container
- Set custom background and font colours (name or hex)
- Translate a message per language
- Publish/unpublish a message without deleting it
- Run a limited-time promotion notice
- Warn users about scheduled maintenance
- Display a cookie/consent style notice
- Show a different message on the front page vs. articles
- Manage all messages from an admin overview list
- Grant editors message management without full admin
- Combine role + path + session conditions on one message
