# Custom widgets — manual setup guide

**Custom widgets** (`custom_widgets`) provides two field widgets that make data
entry over controlled value lists faster and cleaner. Neither is a page or a
block — they are display widgets you switch on per field on a form's *Manage form
display* screen.

The first is an **autocomplete widget for List fields**. When a
List (text), List (integer), or List (float) field has a long set of allowed
values, the default select box or checkboxes become unwieldy. This widget
replaces them with a type‑ahead text field that suggests matching options from
the field's own allowed‑values list as the editor types. You can cap how many
suggestions come back, choose whether matching is "contains" or "begins with",
and — if you also have the [Select2](https://www.drupal.org/project/select2)
module installed — render the autocomplete through Select2 for a richer picker.

The second is a **flat taxonomy select**. It targets entity‑reference fields
that point at taxonomy terms and flattens the vocabulary's hierarchy into a
single select, relabeling each option with its full parent chain
(`Parent >> Child`). It can also force editors to pick a *leaf* (deepest) term by
hiding the top‑level parents — handy when only the most specific term is a valid
choice.

The module works the moment you enable it — there is no central settings form.
It has no hard dependencies beyond Drupal core, and its autocomplete suggestion
endpoint is protected by a per‑request signature keyed on the site's hash salt,
so it only ever returns a field's *allowed‑values* labels, never arbitrary data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
You configure each widget on the relevant field's display, described in "How to
use it" below.

## Where it lives in the admin menu

Custom widgets adds no admin page of its own. You use it entirely from **Structure
→ Content types (or any fieldable entity's bundle) → Manage form display**, where
you pick one of its widgets for a field.

## How to use it

### Autocomplete over a List field

1. Add or locate a **List (text)**, **List (integer)**, or **List (float)** field
   on your content type (or other bundle).
2. Go to that bundle's **Manage form display**.
3. For the field, choose the **Autocomplete** widget
   (`custom_widgets_text_autocomplete`).
4. Click the gear icon to set its options:
   - **Max number of results** — how many suggestions the autocomplete returns
     (default **15**).
   - **Matching method** — **Contains** (default) or **Begins with**.
   - **Use Select2** — only offered when the Select2 module is enabled; renders
     the picker through Select2.
5. Save. Editors now get a type‑ahead field that suggests from the list's allowed
   values.

### Flat taxonomy select

1. Add or locate an **entity reference** field that targets **taxonomy terms**.
2. On the bundle's **Manage form display**, choose the **Flat select** widget
   (`custom_widgets_flat_select`).
3. In its options, optionally enable **force deepest** to hide top‑level
   (parentless) terms so only leaf terms can be selected.
4. Save. Each option now shows its full `Grandparent >> Parent >> Child` path in a
   single select.
