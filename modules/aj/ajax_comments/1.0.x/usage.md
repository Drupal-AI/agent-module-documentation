<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AJAX Comments makes posting, replying to, editing and deleting comments happen inline via AJAX, so the page never fully reloads when a visitor interacts with a comment thread.

---

The module attaches AJAX behaviors to the comment field's markup by altering comment links and the comment form, then routes add/reply/edit/save/delete/cancel actions through its own controller (`AjaxCommentsController`) under `/ajax_comments/*` so responses come back as Drupal AJAX commands that update just the comment wrapper. Whether AJAX is active is decided per comment field, per view mode, via a **third-party setting** `ajax_comments.enable_ajax_comments` stored on the comment field's formatter component in the `entity_view_display` config; it defaults to enabled (`'1'`) on every comment field, and you toggle it on the field's display settings (the widget cog on *Manage display*). A global settings form at `admin/config/content/ajax_comments` (route `ajax_comments.settings`, config object `ajax_comments.settings`) offers three site-wide options: `notify` (show a status message after posting), `enable_scroll` (scroll to the relevant comment after an AJAX action), and `reply_autoclose` (close any other open reply form when a new one opens). Two services support it: `ajax_comments.field_settings_helper` (reads the per-field enable flag from the display) and `ajax_comments.temp_store` (private tempstore used to track in-progress AJAX state). It has no permissions of its own — normal core comment permissions (`post comments`, `edit own comments`, `administer comments`) still govern access.

---

- Let visitors post a comment without the page reloading.
- Reply to a comment inline and have the new reply appear in place.
- Edit your own comment through an inline AJAX form.
- Delete a comment via a modal confirmation dialog without a full page load.
- Cancel an open reply/edit form and restore the thread without navigation.
- Enable AJAX comments on an Article's comment field but leave it off elsewhere.
- Toggle AJAX behavior per view mode (e.g. on for full view, off for teaser).
- Show a status message ("Your comment has been posted") after an AJAX submit.
- Automatically scroll the browser to the newly added or edited comment.
- Auto-close any other open reply form when a visitor starts a new reply.
- Improve the commenting UX on a busy blog without custom JavaScript.
- Keep comment access governed by core comment permissions (no new permissions).
- Turn AJAX comments off globally by disabling the flag on each comment field's display.
- Use the settings form to find every entity/bundle that has a comment field.
- Reduce perceived latency on discussion-heavy pages.
- Route comment CRUD through dedicated `/ajax_comments/*` endpoints.
- Preserve threaded/nested reply structure while updating only the affected wrapper.
- Provide inline editing for moderators clearing a comment queue.
- Ship the per-field enablement as exported `entity_view_display` config.
- Configure the global notify/scroll/autoclose behavior once for the whole site.
- Keep the comment form's validation and submission server-side while updating via AJAX.
- Apply AJAX commenting to any entity type that has a comment field (nodes, media, etc.).
