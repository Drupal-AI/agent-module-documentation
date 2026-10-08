# Views Extras — manual setup guide

**Views Extras** (`views_extras`), full name *Views Extras (Session/Cookie/Token
Support)*, adds a handful of Views building blocks that core doesn't provide. Its
headline feature is three new **contextual-filter default value** plugins that
source a filter value from the PHP **session**, a **cookie**, or the private
**TempStore** — each with a token-aware fallback for when the source is empty. It
also adds a configurable **Extra Result summary** area handler for showing a
"Displaying 1–10 of 57" style line in a view's header or footer.

This is a plugin-only module: there is **no admin settings page, no permissions,
and no Drush commands**. You use everything from inside the Views UI (or directly
in a view's configuration). The fallback values run through Drupal's token service
with the current user available, so tokens like `[current-user:uid]` work — and
installing the optional **Token** module adds a token browser to those fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure globally — you wire these plugins up inside a view.

### Session / cookie / TempStore contextual filters

1. Edit a view and add a **Contextual filter**.
2. Under **When the filter value is NOT available**, choose **Provide default
   value**.
3. For **Type**, pick one of the new options:
   - **Session variable from session** — reads a value from `$_SESSION`. Use a
     `key1::key2` path for nested session data. Offers a **Cache Maximum Age**
     (set it to `0` if the value can change within a session).
   - **Cookie variable from cookie** — reads `$_COOKIE['Drupal_visitor_<key>']`;
     the `Drupal_visitor_` prefix is added for you automatically.
   - **TempStore variable** — reads a value another form or wizard step placed in
     the private TempStore.
4. Fill in the key and, optionally, a **fallback value** (a literal or a token
   such as `[current-user:uid]`) used when the source is empty.

Typical uses: personalise a "my items" view from the logged-in user's id, filter
by a saved cookie preference or A/B bucket, or pass a wizard's selected entity id
into a results view.

### Extra Result summary

1. Edit a view and add an item to the **Header** or **Footer**.
2. Choose **Extra Result summary** (in the *Global* group).
3. Set the **Display** string using the supported tokens.

Supported tokens are `@start`, `@end`, `@total`, `@label`, `@per_page`,
`@current_page`, `@current_record_count`, `@page_count`, and `@more` (the number
of results beyond the current page — its line is hidden automatically when zero).
Admin-safe HTML is allowed in the string, so you can style the summary.
