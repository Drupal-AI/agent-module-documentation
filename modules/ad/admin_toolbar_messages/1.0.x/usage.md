<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Messages decorates Drupal's core `messenger` service so that status/warning/error messages raised while the user is on an admin route are split out of the page's message region and instead shown in the classic Toolbar or the Drupal 11 Navigation top bar once the user lands on a front-end, non-admin page.

---

The module works purely by service decoration — it ships no configuration, permissions, routes, config schema or Drush commands. `AdminAwareMessenger` (declared in `admin_toolbar_messages.services.yml` with `decorates: 'messenger'`) wraps the core `messenger` service. When `addMessage()` is called on an admin route (detected via the `router.admin_context` service, `AdminContext::isAdminRoute()`), the message is stored under an `admin:`-prefixed type instead of the normal `status`/`warning`/`error` type; off admin routes it passes straight through to the inner messenger unchanged. On the admin page itself the prefixed messages are merged back in by `all()`/`deleteAll()`, so they still display inline there as usual. The visible split appears on the next non-admin page: the core status-messages block returns only the non-prefixed messages, leaving the `admin:` ones queued in the session; a lazy-built toolbar tab (`ToolbarHooks::onBuild`, weight 1100, right-aligned) and — when the core Navigation module is enabled — the `AdminMessagesTopBarItem` plugin in the top bar's Actions region then call `AdminToolbarMessagesBuilder::build()`, which pulls and deletes those admin messages (`deleteAllAdmin()`) and renders them through the `status_messages__admin_toolbar_messages` theme hook (base hook `status_messages`) into a collapsible drawer template. This keeps administrative feedback from an admin action visible after a redirect to the front end, gives messages a stable location that does not push content down, and helps on custom admin themes that forget to print the message region. A `library_info_alter` hook (`ThemeHooks::onLibraryInfoAlter`) swaps `navigation.css` for `navigation.gin.css` when both `navigation` and `gin_toolbar` are enabled. Note there is no hard dependency on `admin_toolbar`, `toolbar` or `navigation` in the info file (`toolbar` and `navigation` are only test dependencies); the module simply produces nothing to display if neither an administrative toolbar nor the navigation top bar is present.

---

- Keep an admin action's confirmation visible after redirecting to the front end.
- Show status messages in the toolbar instead of the page content region.
- Give administrative status messages a fixed, always-visible location.
- Stop status messages from pushing page content down on admin operations.
- Surface a save confirmation that would otherwise be below the fold on a long form.
- Help display status messages on a custom admin theme that omitted the messages region.
- Display admin-generated warnings in a collapsible toolbar drawer.
- Integrate administrative messages into the Drupal 11 Navigation top bar (Actions region).
- Provide a right-aligned "Messages" tab in the classic Toolbar.
- Separate administrative feedback from front-end user-facing messages.
- Reduce scrolling to find post-save feedback in the admin UI.
- Standardise where administrators see status, warning and error messages.
- Add message relocation without writing any configuration.
- Keep the page layout stable when a message is added on an admin page.
- Show queued admin messages the first time the user hits a non-admin route.
- Group toolbar messages by type (status/error/warning) with accessible headings.
- Adopt the newer Navigation module while retaining classic Toolbar support.
- Use Gin-specific styling automatically when running the Gin toolbar with Navigation.
- Avoid losing an admin confirmation when an action redirects to a public page.
- Improve editor confidence that an administrative save succeeded.
- Route messages programmatically as "admin" via `AdminAwareMessenger::addAdminMessage()`.
- Keep front-end message behaviour unchanged for anonymous visitors.
