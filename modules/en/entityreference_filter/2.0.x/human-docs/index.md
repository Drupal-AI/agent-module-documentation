# Views Reference Filter — manual setup guide

**Views Reference Filter** (`entityreference_filter`) adds a Views filter whose
dropdown options are populated dynamically from a *separate* view. Instead of an
exposed filter that lists every taxonomy term, every node, or every user — or a
bare "type an ID" box — you point the filter at an **Entity Reference** view
display and it shows exactly the curated set of entities that view returns, in the
order that view sorts them. It also makes **cascading (dependent) filters**
possible: pick a Country, and a City dropdown updates over AJAX to match.

The module registers a single Views filter and attaches it, in the Views UI, to
every entity-id column (node ID, user ID, term ID) and every entity-reference
field (`*_target_id`). In the filter list these appear as
**"{Field} (entityreference filter)"**. You choose which reference view display
supplies the options, and optionally pass contextual arguments into that view —
including the live value of another exposed filter on the same view, which is what
links two filters into a cascade. Circular dependencies between filters are
detected and blocked when you save.

When the filter is *not* exposed, it behaves as a subquery `IN` / `NOT IN`
condition — the reference view becomes the inner query — giving Views a capability
it otherwise lacks (for example, "rows whose node ID appears in this other view's
results"). An option to hide the exposed widget when the curated list comes back
empty keeps forms tidy.

Everything is configured on the filter handler inside the Views UI — there is **no
separate admin settings page**. It requires only core's Views and Field modules.
An optional submodule (`entityreference_filter_search_api`) adds a Search API
variant, and it pairs well with Better Exposed Filters for relabelling options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the current 2.0.x release is `2.0.0-beta7`, a beta. Test before
> relying on it in production.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Search API submodule.

## Where it lives in the admin menu

The module adds no admin pages of its own (`configure` is null). You use it
entirely from inside the Views UI at **Structure → Views**
(`/admin/structure/views`), on a view's filter criteria.

## How to use it

Two views are involved: a **reference view** that supplies the options, and the
**filtered view** where you add the exposed filter.

1. **Build the reference view.** Create a view whose base entity type matches the
   field you want to filter (a Content view for a node-ID field, a Users view for
   a user-ID field, a Taxonomy terms view for a term-reference field, and so on).
   Add a display of type **Entity Reference**. Sort and filter this view so it
   returns exactly the entities you want offered as options — this view is the
   single source of truth for both the set and the order of the dropdown.
2. **Add the filter to the filtered view.** In that view's *Add filter criteria*
   list, choose the entry named **"{Field} (entityreference filter)"** (e.g.
   "Has taxonomy terms (entityreference filter)"). Expose it to show the dropdown.
3. **Choose the reference display.** In the filter settings, set **Reference
   display** to your reference view and display (`view_name:display_id`).
4. **(Optional) Pass arguments** in **Reference arguments** to scope the options.
   You can use these tokens, `/`-separated, in order:
   - `!n` — argument *n* from the filtered view's URL.
   - `#n` — contextual filter value *n* of the filtered view.
   - `[filter_identifier]` — the live value of another exposed filter on the same
     view. Using this is what makes the two filters **dependent**.
   - any other text is passed literally.
5. **(Optional) Hide when empty.** In the filter's *Expose* section, the **Hide
   empty filter** option (on by default) hides the exposed widget entirely when
   the reference view returns no options.

### Cascading (dependent) filters

Put another exposed filter's identifier — for example `[country]` — in the
Reference arguments. Now, whenever the visitor changes the `country` filter, this
filter's options are recomputed over AJAX (no full page reload), and any selected
value that's no longer valid is dropped. This is how you build "Region → Store" or
"Category → Subcategory" cascades. (If you use Better Exposed Filters with
auto-submit, the standard exposed-form AJAX is used instead of this module's own
cascade.)

### Subquery IN / NOT IN (non-exposed)

If you leave the filter **unexposed**, it becomes a static `IN` / `NOT IN`
subquery: the reference view is the inner query and its result entity IDs are
injected into the outer view's condition. Use the standard operator setting to
choose `IN` (match) or `NOT IN` (exclude). If the reference view returns nothing,
the condition matches no rows.

### Notes

- To reorder the dropdown, sort the reference view — it controls the order.
- Options respect the reference view's own access checks.
- Better Exposed Filters can rewrite the option labels (they're re-sorted back to
  the reference view's order on render).
