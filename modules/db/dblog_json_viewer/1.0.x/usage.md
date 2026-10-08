Dblog JSON Viewer turns the JSON in a Drupal core dblog (Recent log messages) event page into an interactive, searchable, collapsible viewer.

---

Dblog JSON Viewer is a client-side enhancement for Drupal core's Database Logging module. It attaches a JavaScript library only to the log-event route (`/admin/reports/dblog/event/*`) and only for users who can already read reports, then inspects the log message cell for JSON. When JSON is found it hides the raw text and renders a syntax-highlighted, collapsible tree (via the bundled json-view library) with real-time debounced search, previous/next result navigation, expand/collapse-all, a formatted-vs-raw toggle, copy-to-clipboard for both views, and a fullscreen mode. The detector is heuristic — it strips the cell back to plain text, pulls out one or many JSON objects (including multi-section "Options:/Response:/Headers:" API logs and JSON strings nested inside other JSON), and scores candidates by structural complexity and by a configurable list of "API key" patterns to display the most relevant object. The module has no entities, services, plugins, hooks beyond `hook_help`/`hook_page_attachments`, or Drush commands; a single admin settings form lets you retune every UI label, the search delay, a debug-log toggle, and the pattern lists. It works with any admin theme and is tuned for the Gin theme's light/dark modes.

---

- Enable it alongside core `dblog` to make watchdog log entries containing JSON readable at a glance.
- Inspect an external API response logged by an integration module without scrolling through a single unformatted line.
- Debug webhook payloads captured in the log by expanding only the branches you care about.
- Search a large logged JSON blob for a specific key or value and jump between matches with previous/next.
- Expand or collapse every branch of a logged object at once while triaging an error.
- Toggle between the formatted tree and the original raw message text when you need to see exactly what was logged.
- Copy the formatted JSON (pretty-printed) to the clipboard to paste into a ticket or a diff tool.
- Copy the raw log content to the clipboard when you need the verbatim message.
- Open the viewer in fullscreen to read a deeply nested structure, and press ESC to exit.
- Read multi-section API logs where one entry contains several labelled JSON blocks (e.g. `Options: {…} Response: {…}`), each shown as its own collapsible section.
- Automatically unwrap JSON that was double-encoded as a string value inside another JSON object.
- Let the complexity/pattern scorer pick the most meaningful object when a message contains several JSON fragments.
- Customise which key names (e.g. `data`, `response`, `order`, `payload`) boost an object's relevance score, from the settings form.
- Customise which section labels (e.g. `Response`, `Headers`, `Error`, `Token`) are recognised as multi-section markers.
- Rename every button and status label (Expand All, Copy JSON, Fullscreen, "No results found", etc.), including for translation into another language.
- Tune the search debounce delay to trade responsiveness against typing load on very large logs.
- Turn on browser-console debug logging temporarily to see how a specific message was parsed while troubleshooting the detector.
- Give support staff who hold only "access site reports" a friendlier log-reading experience without granting extra access.
- Review structured error contexts and stack traces that some modules log as JSON.
- Analyse queued/cron event payloads recorded in the log during site monitoring.
- Read the viewer comfortably on a tablet or phone thanks to the responsive layout.
- Keep the enhancement scoped to the log-event page only, leaving the rest of the admin UI untouched.
