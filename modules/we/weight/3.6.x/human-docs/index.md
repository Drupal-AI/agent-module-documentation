# Weight — manual setup guide

**Weight** (`weight`) provides a single `weight` field type that you can add to
any fieldable entity — content types, taxonomy terms, custom entities — so its
records can be **manually ordered** rather than sorted only by title or date. If
you've ever wanted editors to drag a list of featured items into exactly the
order they want, or to give taxonomy terms a custom sequence, this is the
straightforward, field‑based way to do it.

Each weight field stores a signed integer and has a **Range** setting (default
`20`). The field's widget — the **Weight Selector** — then offers a select list
of every integer from `-range` to `+range`, so a range of `20` lets an editor
pick any weight from `-20` to `20`. New entities default to `0` (the middle of
the range) until you reorder them. To actually change the *display* order, you
sort a View (or any query) ascending by the weight field's value — lower weights
"float" to the top, exactly like Drupal's familiar weight columns.

Weight also has a nice Views trick: it exposes a **Weight Selector** Views field
handler, and when you add that handler to a *table* View, the module turns the
table into a **drag‑and‑drop** reorder form that saves the new weights back to
every entity at once. There's also a storage‑level **Unsigned** setting to
restrict values to non‑negative integers. The module depends only on core's
**Field** module and adds **no settings page, permissions, or services of its
own** — everything happens through the normal Manage fields, Manage form display,
and Views UIs.

This guide is written for a **human** adding and using the field through the
admin UI. If you want a terse, token‑cheap reference for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Weight has no admin settings page. You use it through the standard field UIs:

- **Manage fields** for a bundle (`.../fields`) — add a *Weight* field and set its
  **Range** and **Unsigned** options.
- **Manage form display** (`.../form-display`) — the **Weight Selector** widget
  presents the range as a select list to editors.
- **Structure → Views** — sort a View by the weight field to apply the order, or
  add the Weight Selector field to a table View for drag‑and‑drop reordering.

## How to use it

1. Go to **Manage fields** on the content type (or vocabulary, or entity) you
   want to order, and add a field of type **Weight**.
2. Set the **Range** — `20` is the default and is plenty for small lists; use a
   larger range (say `100`) when you need finer‑grained ordering of many items.
   Optionally tick **Unsigned** to allow only non‑negative values.
3. On **Manage form display**, the **Weight Selector** widget shows editors a
   simple select list of the available weights.
4. To make the order take effect, either:
   - **Sort a View** ascending by the weight field's value, so items render in
     the chosen order (add a secondary sort like title as a tiebreaker if you
     like); or
   - **Build a drag‑and‑drop screen** by adding the *Weight Selector* Views field
     to a **table** View — the table becomes a draggable reorder form that saves
     new weights to every row (including per‑group tables when the View is
     grouped) on submit.

Common uses: manually ordering nodes, ordering taxonomy terms in a vocabulary,
sequencing promoted or featured items, and giving a "menu‑like" manual sort to
entities that aren't menu links — all without touching code. The field's storage
and settings export as configuration between environments, and the module also
ships a Drupal 7 migrate field plugin and a Feeds target for importing weight
values.
