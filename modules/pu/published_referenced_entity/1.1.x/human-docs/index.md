# Published Referenced Entity — manual setup guide

**Published Referenced Entity** (`published_referenced_entity`) provides
specialised field formatters for entity reference fields that only display the
referenced item when it is **published** (or, for users, **active**). It's a
handy display‑layer filter: if a field references a mix of published and
unpublished nodes, users, or taxonomy terms, these formatters quietly skip the
unpublished ones when rendering the field.

The module gives you three formatters you can pick on a reference field's *Manage
display*:

- **Published Entity ID** — renders the referenced entity's ID, but only if it's
  published.
- **Published Entity Label** — renders the label/title, only if published.
- **Published Rendered Entity** — renders the entity through a view mode, only if
  published.

These work for reference fields pointing at **nodes, users, or taxonomy terms**.

One important caveat to understand: this is a **display‑layer filter, not access
control**. It changes what gets *rendered* in a field, but it does not restrict
who can access the underlying entity through other routes (direct URLs, the API,
Views, and so on). Use it to keep unpublished items from cluttering a rendered
list — not as a security boundary. For genuine access restrictions, use Drupal's
entity access system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page**. You configure the behavior per field on
its *Manage display*, as described in "How to use it" below.

## Where it lives in the admin menu

The module adds **no admin configuration page**. You use it entirely from
**Structure → Content types (or other entity type) → *(bundle)* → Manage
display**, where the three formatters become available on entity reference
fields.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page for the entity type/bundle that has your
   entity reference field — for example **Structure → Content types → *(your type)*
   → Manage display**.
3. Find the reference field (to a node, user, or taxonomy term) and, in its
   **Format** column, choose **Published Entity ID**, **Published Entity Label**,
   or **Published Rendered Entity**.
4. Adjust any formatter options offered, then **Save**.

From then on, when that field is rendered, any referenced entities that are
unpublished (or users that are blocked/inactive) simply won't appear.
