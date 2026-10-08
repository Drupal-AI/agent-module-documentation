Views Extras adds three Views contextual-filter "default argument" plugins that source a value from the PHP session, a cookie, or the private TempStore (with a token-aware fallback), plus a configurable "Extra Result summary" Views area handler.

---

The module registers, via plugin classes only (no config UI, permissions, or Drush), three
`@ViewsArgumentDefault` plugins — `session`, `cookie`, and `tempstore` — that supply the default
value for a Views contextual filter (argument) when none is present in the URL. Each reads a keyed
value: `session` walks `$_SESSION` using a `key1::key2` path, `cookie` reads
`$_COOKIE['Drupal_visitor_' . $key]` (the Drupal user-cookie prefix is added automatically), and
`tempstore` reads `PrivateTempStoreFactory->get($unique_name)->get($key)`. All three accept a
**fallback value** used when the source is empty, and that fallback runs through the token service
with the current user as `user` token data (so `[current-user:uid]` etc. work; the Token module adds
a token browser). `session` and `tempstore` also expose a **Cache Maximum Age** (`cache_time`)
because Drupal's cache API has no session cache context — set it to `0` if the value changes within a
session; `cookie` sets a `cookies:Drupal_visitor_<key>` cache context instead. The fourth plugin is
a Views **area** handler `extra_result` ("Extra Result summary", registered through
`hook_views_data()` on the `views` table) that renders a configurable summary string supporting the
tokens `@start`, `@end`, `@total`, `@label`, `@per_page`, `@current_page`,
`@current_record_count`, `@page_count`, and `@more`. Config schema exists for the three argument
plugins' options; the area handler stores its `content` option in the view.

---

- Filter a view by a value stored in the current user's session (e.g. a selected store or region).
- Drive a view's contextual filter from a cookie such as a saved preference or A/B bucket.
- Use a value placed in the private TempStore by a form/wizard step as a view argument.
- Provide a token-based fallback (e.g. current user id) when the session/cookie value is absent.
- Personalise a "my items" view using the logged-in user's uid via a token fallback.
- Read a nested session value with a `key1::key2` path for structured session data.
- Filter content by a `Drupal_visitor_*` cookie set elsewhere on the site.
- Add a "Displaying 1–10 of 57" style result summary to a view header or footer.
- Show the current page number and total page count in a view via the extra_result area tokens.
- Display a "N more results" hint using the `@more` token (hidden automatically when zero).
- Show the view's human label inline in a summary line with `@label`.
- Combine an exposed pager with the extra_result summary to give users record counts.
- Set the cache max-age to 0 for a session/tempstore argument that changes mid-session.
- Keep per-cookie cache correctness automatically via the `cookies:Drupal_visitor_<key>` context.
- Build a personalised dashboard view keyed off a cookie without writing a custom plugin.
- Pass a wizard's selected entity id (stored in TempStore) into a results view.
- Fall back to a default category when no cookie/session preference is set.
- Localise a summary string with HTML and tokens (the area handler allows admin HTML).
- Segment content per visitor using session data captured at login.
- Provide a lightweight alternative to writing a custom argument_default plugin for session/cookie values.
- Show "page X of Y" navigation context alongside a custom pager.
- Reuse the same summary format across views by configuring the extra_result area consistently.
