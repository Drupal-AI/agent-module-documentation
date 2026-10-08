# Field Context — manual setup guide

**Field Context** (`field_context`) adds a Views feature that many site builders
wish core had: it lets an embedded view's contextual filter take its value from a
field on the node of the current page. So an embedded "related content" view can
filter itself by, say, the host node's category — with no custom code.

Views contextual filters can already default from the URL, the current user, or a
fixed value, but not from an arbitrary field on the page's node. Field Context
provides an **argument default plugin** called *Field from route context* that
does exactly this. In its settings you pick a content type and then a field on
that type; at render time the plugin reads the current page's node, pulls the
chosen field's value, and hands it to the contextual filter.

It is careful about failure: if the current page has no node, or the node does not
have the chosen field, the plugin returns nothing and the view falls back to
whatever "when the filter value is not available" behaviour you configured
(usually *Hide view*). It also declares the right cache metadata so embedded views
stay correctly cached per page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Field Context has no settings page of its own. It appears as an option inside the
**Views** UI (Structure → Views) whenever you configure a contextual filter.

## How to use it

Configure it from within a view that has a contextual filter:

1. Edit the view and go to **Advanced → Contextual filters**, then add (or edit)
   the contextual filter you want to drive — for example *Content: Has taxonomy
   term ID* for a category-based "related content" block.
2. Under **When the filter value is NOT available in the URL**, choose **Provide
   default value**.
3. Set the default value **Type** to **Field from route context**.
4. Pick the **content type** and then the **field** whose value should feed the
   filter.
5. Set **When the filter value IS available or a default is provided** to match
   your intent, and set the not-available behaviour (commonly *Hide view*) so the
   view degrades gracefully on pages with no matching node.

Good things to know:

- It works with **nodes only** — the value comes from the node on the current
  route, so it does the right thing on node pages and node-embedded blocks.
- For a **reference field**, the value returned is the referenced entity's id; for
  a **multi-value field** it is a comma-joined list, so configure the contextual
  filter to *Allow multiple values* if you rely on that.
- If there is no node on the current route, or the node lacks the field, the
  filter simply has no value — it does not error.
