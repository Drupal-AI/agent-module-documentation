Tawk.to integrates the tawk.to live-chat widget into a Drupal site: you pick a widget from your tawk.to account through an embedded configuration iframe, and the module renders the chat script in the page footer subject to core visibility conditions.

---

The module embeds the tawk.to chat widget via `hook_page_bottom`, using a lazy-builder placeholder that calls `TawkToEmbedRender::render()`. That service reads `tawk_to.settings` (the selected `tawk_to_widget_page_id` + `tawk_to_widget_id`, optional `user_name`/`user_email` with token replacement, and a `script_load_delay`), checks visibility via a set of core Condition plugins, and returns a `tawk_to` themed render array that prints the `https://embed.tawk.to/<pageId>/<widgetId>` script. Widget selection happens on an admin page (`/admin/config/services/tawk_to/widget`) that loads tawk.to's plugin picker in an iframe (`TawkToWidgetController::widgetsContent`); the iframe posts back to `setWidget`/`removeWidget` controller callbacks (validated with strict regexes for the page/widget IDs) which persist the choice to config, with per-language config override support. An "Extra Settings" form (`TawkToExtraSettingsForm`) builds a visibility UI out of the condition plugin manager (pages, roles, content types, language, etc.), plus user-info tokens and the load delay. All routes are gated by the `administer tawk_to settings` permission (restrict access). Rendering is cached with `session` + `user` contexts and the conditions' own cache metadata. The widget appears only once a page/widget ID is set and the configured conditions pass.

---

- Add a tawk.to live-chat widget to a Drupal site's footer on every page.
- Select which tawk.to property/widget to embed via the built-in configuration iframe.
- Log in to tawk.to inside the admin iframe and pick a widget without copy-pasting embed code.
- Remove/clear the configured widget from the site with one click.
- Restrict the chat widget to specific pages using the request-path visibility condition.
- Show the widget only to (or hide it from) specific user roles.
- Limit the widget to certain content types via the node-type condition.
- Enable the widget per language on multilingual sites (language condition + config overrides).
- Combine multiple visibility conditions (all must pass, AND logic) to scope the widget precisely.
- Pass the current user's name into the chat pre-fill using the `[current-user:name]` token.
- Pass the current user's email into the chat using the `[current-user:mail]` token.
- Delay loading the chat script by N milliseconds to improve perceived page-load performance.
- Store different widget selections per language using Drupal's config language overrides.
- Keep chat off pages where it's unwanted (e.g. checkout, admin) via negated path conditions.
- Gate all widget administration behind the `administer tawk_to settings` permission.
- Lazy-render the widget through a placeholder so page cache isn't polluted by per-user data.
- Provide customer support chat for authenticated users only, or anonymous only, via role conditions.
- Ensure the widget only renders when both a page ID and widget ID are configured.
- Reuse core Condition plugins so visibility behaves like block visibility settings.
