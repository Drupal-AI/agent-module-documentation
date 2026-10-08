<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Driplet Notify pushes real-time toast notifications to the browser when nodes change or the cache is rebuilt.

---

`driplet_notify` is a Driplet example submodule. Its `.module` file implements node hooks
(`hook_node_insert`, `hook_node_update`, `hook_node_delete`) and `hook_rebuild()`, each building a
Driplet message on the `driplet-notify` topic through `driplet.service`: node CRUD events target the
`authenticated` role (persistent `notify-persist` cards), and a cache rebuild targets `administrator`
(a timed `notify` card). On the client, `hook_page_attachments_alter()` adds the `driplet_notify/
notify` library to every page and `hook_page_bottom()` injects a `<div id="driplet-notify-wrapper">`;
`js/notify.js` subscribes to `driplet-notify` and renders each incoming message as a dismissible
notification card (timed cards auto-remove after 12s). Requires `driplet`.

---

- Show a live "new page created" toast to all authenticated users.
- Notify users in real time when content is updated or deleted.
- Alert administrators the moment the cache is cleared.
- Display dismissible toast cards in a fixed page-bottom wrapper.
- Auto-dismiss transient ("notify") cards after 12 seconds.
- Keep persistent ("notify-persist") cards until the user closes them.
- Learn how to emit Driplet notifications from Drupal hooks (worked example).
- Target notifications to a role (authenticated vs administrator) via message targeting.
- Provide no-config, drop-in real-time notifications once Driplet is set up.
- Use it as a starting point for custom event-driven notifications.
- Style notification cards via the shipped `css/notify.css`.
- Verify end-to-end Driplet delivery by creating a node and watching the toast appear.
