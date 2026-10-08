# Views Filters Populate — manual setup guide

**Views Filters Populate** (`views_filters_populate`) lets one Views filter copy its
value into several other filters, so a single input can search across multiple
fields at once. The classic use is a single "keyword" search box that quietly
narrows a listing by title *and* body *and* a custom field — without you having to
expose five separate filter widgets or write any custom code.

It works by adding a special Views filter. That filter does not narrow the query
itself; instead, you point it at one or more **other, non-exposed** filters in the
same display. When the filter's value is set — usually the value a visitor types
into the exposed search box — it copies that value onto each of those target filters
before the query runs. Each target then does its normal job (a "contains" match on a
text field, a numeric comparison, and so on) using the shared value. The net effect
is one box that filters many fields together.

There is a nice bonus: if the populate filter is exposed and the visitor leaves it
empty, the whole group (the populate filter and its targets) is dropped from the
query for that request, so it behaves as an **optional** filter rather than matching
an empty string against everything. The module has no settings page, permissions, or
Drush commands — you configure it entirely inside a View. It works on Drupal 10 and
11 and depends on core's **Views** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds **no page of its own**. Its only footprint is a new filter you can
add inside any View, and an **"Available filters"** multi-select on that filter's
own configuration form.

## How to use it

1. Edit the View and, under **Filter criteria**, add the **Views Filters Populate**
   filter. Usually you **expose** it, so visitors get a search box.
2. Add the other filters you want it to drive — for example a filter on the node
   **title** and one on the **body** — and make sure each of those is **not
   exposed**. Only non-exposed text (string) and numeric filters are eligible
   targets.
3. Open the Views Filters Populate filter's settings and, in **Available filters**,
   tick the target filters it should populate.
4. Save the View. Now a value typed into the one exposed box is copied into each
   target filter, so the results are narrowed by all of them at once. Leave the box
   empty and the whole group is skipped.

A couple of practical notes: the target filters must stay non-exposed and must be
string or numeric filters — Views will flag a validation error when you save if a
listed target no longer exists or has been exposed. And if no eligible target
filters exist yet, add them first; the populate filter refuses to save with nothing
to populate.
