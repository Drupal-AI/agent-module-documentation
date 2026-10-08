Views Flag Refresh re-runs an AJAX-enabled View automatically whenever the user clicks a selected [Flag](https://www.drupal.org/project/flag) link on the same page, so flag-filtered lists update without a manual reload.

---

The module adds a Views **display extender** (`views_flag_refresh`, plugin type `views_display_extender`) that appears in the display's *Other* section as "Refresh view by Flag". There you tick which flags should trigger a refresh and optionally disable the post-refresh scroll-to-top. It only takes effect when the display's core *Use AJAX* option is set to *Yes*. At render time `hook_views_pre_render()` attaches the `views_flag_refresh/refresh_ajax` library plus a `drupalSettings.viewsFlagRefresh.flags` map keyed by flag id → view id → display id. A response `EventSubscriber` (`RequestSubscriber`) watches the `flag.action_link_flag` / `flag.action_link_unflag` AJAX routes and appends a custom `viewsFlagRefresh` AJAX command carrying the flag id; the client-side `Drupal.AjaxCommands.prototype.viewsFlagRefresh` then finds matching registered `Drupal.views.instances` and calls their refresh (or re-triggers the exposed form). The same subscriber strips `scrollTop`/`viewsScrollTop` commands from the view's AJAX response when `noscrolltop` is enabled. Settings are stored in the View config entity under the display's `display_options.display_extenders.views_flag_refresh` (schema `views.display_extender.views_flag_refresh`). There is no admin settings page (`configure` is null) and no permissions. Requires the Flag and Views modules.

---

- Auto-refresh a View of flagged (bookmarked/favorited) content when a user flags or unflags an item elsewhere on the page.
- Update a "My favorites" block instantly as the visitor toggles favorite links in a listing.
- Keep a "flagged for review" moderation list in sync as editors flag nodes without reloading.
- Refresh a shopping-style "saved items" View when a wishlist flag is clicked.
- Remove an item from a filtered View the moment its flag is removed (unflag).
- Drive a "like"/"subscribe" counter View to re-query after each flag click.
- Refresh multiple Views on one page from a single flag action.
- Trigger a refresh from more than one flag on the same View.
- Re-run an exposed-filter View (via its exposed form AJAX) when a flag changes.
- Disable the jarring scroll-to-top that normally follows an AJAX view refresh.
- Combine flag-driven refresh with normal AJAX pagers and exposed filters on the same display.
- Build a real-time compare/collection tray that reflects flag state changes.
- Update a count or empty-text region of a View after the last item is unflagged.
- Provide instant feedback for anonymous or authenticated flags on public listings.
- Keep a dashboard of flagged tasks current as team members flag/unflag work.
- Configure per-display which flags matter, so unrelated flags don't cause refreshes.
- Refresh a View placed as a block by selecting that specific view/display in the extender.
- Avoid custom JavaScript for the common "flag then re-list" interaction pattern.
