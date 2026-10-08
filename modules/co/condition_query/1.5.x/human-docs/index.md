# Condition Query — manual setup guide

**Condition Query** (`condition_query`) adds a **Request Param** condition so you
can show or hide blocks based on the URL's query‑string parameters — for example,
show a promotional block only when the URL contains `?campaign=summer`, or hide
the sidebar when a page is opened in an app webview with `?app=true`.

It plugs into Drupal's standard **Condition API**, which is the same system that
powers block visibility, and which Rules, Page Manager, and similar tools also
use. So although the most common use is block visibility, the exact same
condition works anywhere conditions are exposed.

The condition matches on `key=value` pairs (array‑style parameters like
`?visibility[]=show` are supported too), returns true when *any* configured pair
matches the current request, and can be inverted with the standard **Negate the
condition** option — letting you show a block only when a parameter is *absent*.
It also declares the right cache context (`url.query_args`) so pages cache
correctly per query string. There is no settings page, no permission, and no
dependency beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Condition Query has no admin page of its own. The **Request Param** condition
appears wherever Drupal's Condition API is exposed — most commonly under a
block's **Visibility** settings on **Structure → Block layout**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and configure (or place) a block.
3. Under **Visibility**, open the **Request Param** tab.
4. In **Query Parameters**, enter one parameter per line, in `key=value` form:

   ```
   visibility=show
   app=true
   ```

   Use bracket syntax for array parameters, for example `visibility[]=show`.
5. Optionally tick **Negate the condition** to invert the rule (show the block
   only when the parameter is *absent*).
6. Save.

### Good to know

- Matching is **case‑insensitive** on both key and value, and looks for an exact
  `key=value` — there is no partial or numeric‑range matching.
- If you list several parameters, the condition passes when **any one** of them
  matches (any‑of, not all‑of).
- Because it is a standard condition plugin, the same configuration also works in
  Rules, Page Manager, and other condition consumers.
