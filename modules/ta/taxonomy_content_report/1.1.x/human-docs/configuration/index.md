# Configuration

The report needs a little setup before it is useful: it has to know which
vocabulary drives the sidebar, and which field on each content type ties that
content to the vocabulary. All of this is done on one settings form.

## Open the settings form

1. Log in as a user with the module's administer permission.
2. Go to **Administration → Configuration → Content → Taxonomy Content Report
   Settings**, or navigate directly to
   `/admin/config/content/taxonomy-content-report`.

## 1. Choose a vocabulary

Select the **vocabulary** whose term tree will power the sidebar filter. All
content shown in the report is scoped to terms from this vocabulary.

## 2. Map content types to fields

For each content type that should appear in the report, select the
**entity‑reference field** on that type that points to terms in the chosen
vocabulary. Only fields that reference `taxonomy_term` entities *and* target the
selected vocabulary are offered — so if a field you expect is missing, check
that its reference settings include the correct vocabulary.

## 3. Assign Views (optional but recommended)

For each content type you can optionally assign a **View display** to render its
table, chosen from a dropdown in the form of `view_machine_name:display_id`. The
View you assign **must have a contextual filter for Taxonomy Term ID**
(`taxonomy_term.tid`): when a term is selected in the sidebar, the module passes
that term's ID — plus all of its descendant term IDs, joined with `+` — as the
contextual filter argument. If you assign no View for a content type, the module
falls back to a built‑in table.

A View that works well here is set up like this:

1. Create a new View of **Content** (node).
2. Add a **Contextual filter**: *Has taxonomy term ID* (choose your vocabulary).
3. Set *"When the filter value is NOT available"* to **Display all results**.
4. Set *"When the filter value IS available"* to **Limit to selected term and
   its children** (or keep the default "Reduce duplicates" if you rely on the
   `+`/OR behaviour).
5. Add the fields, sorting and pager you want.
6. Save the View and note its machine name and display ID for the dropdown.

## 4. Other settings

- **Tree depth** — how many levels of the taxonomy tree the sidebar renders (1
  to 10).
- **Show unpublished** — whether unpublished nodes are included in the summary
  counts.
- **Chart type** — the summary chart style: **bar**, **pie**, or table‑only.
- **Default date range** — pre‑fills the date filter with a number of months
  back.

## Save

Save the form. The report then reads from these settings: pick a term in the
sidebar and the breadcrumb, summary dashboard, chart and per‑content‑type tables
update to show the matching content (including content tagged with descendant
terms).
