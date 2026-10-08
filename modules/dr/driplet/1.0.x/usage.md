<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Driplet pushes real-time messages from Drupal to the browser over WebSockets, delivered through a companion Driplet Go microservice and targeted at specific users, roles, or topics.

---

Driplet is a bridge between Drupal and the external **Driplet** Go microservice. Backend code builds a message with the `driplet.service` service (a fluent `MessageBuilder`: message body, a topic, and include/exclude targets by uid or role), and `sendMessage()` sends it — via the bundled `make0x20/driplet` PHP library — to the microservice's HTTP message endpoint, signed with an HMAC API secret. The microservice then fans the message out over WebSockets to subscribed browsers. On the frontend, the `DripletClient` JavaScript singleton (in `js/driplet-client.js`) fetches a short-lived per-user JWT from `/api/driplet/jwt`, opens a WebSocket to the configured endpoint, subscribes to topics, and invokes `onMessage` callbacks as messages arrive. The JWT (issued with the user's uid and roles) lets the microservice identify the connecting user so it can honor the targeting on each message. Two example submodules ship with the project: `driplet_log` (streams Drupal log entries to an admin report page in real time) and `driplet_notify` (pushes toast-style notifications on node create/update/delete and cache clear). The module is a thin Drupal integration layer — most real behavior lives in the microservice, the PHP library, and code you write against the service.

---

- Push a real-time notification to a specific set of users by uid.
- Push a notification to everyone in one or more roles (e.g. `authenticated`).
- Broadcast to everyone except a set of users/roles using exclusion targets.
- Group messages by topic so a page subscribes only to what it needs.
- Subscribe a browser to several topics at once and handle each separately.
- Show a live "new content published" toast to all authenticated users.
- Alert editors in real time about a new moderation-queue item.
- Stream the Drupal log (dblog) to an admin report page as events happen.
- Notify administrators the moment the cache is rebuilt.
- Build a real-time chat or chatroom between logged-in users.
- Drive a custom live analytics dashboard inside Drupal.
- Send system/health alerts to admins without page reloads.
- Reflect content updates (edits, deletions) to viewers instantly.
- Issue a per-user JWT so the WebSocket server can identify the connecting user.
- Reuse the `DripletClient` singleton across multiple front-end features on one page.
- Auto-reconnect the browser WebSocket with backoff after a dropped connection.
- Target a message to a combination of uids and roles in a single send.
- Send transient ("notify") vs. persistent ("notify-persist") notifications.
- Point Drupal at a Driplet microservice running locally under DDEV.
- Toggle SSL independently for the REST API leg and the WebSocket leg.
- Integrate real-time delivery into custom modules via the `driplet.service` service.
