# Exposed Filter Data — manual setup guide

**Exposed Filter Data** (`exposed_filter_data`) gives you a simple way to **print
the current exposed-filter values of a View**. When a visitor filters a listing —
say by choosing a category or typing a search term — you often want to echo that
choice back on the page ("Showing results for: Category = News"), especially when
the exposed filter form sits in a separate block and the connection between the
form and the results isn't otherwise obvious. This module supplies the plumbing to
display those active filter values.

It depends on core **Views** and provides a template-level output of the exposed
filter values, which you place in a View's header (or a template) and theme to
taste. It reflects the values the visitor submitted, so present them through the
normal escaping you would use for any request-derived value. The module has no
access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module. You use it inside a View, as
described in "How to use it" below.

## Where it lives in the admin menu

Exposed Filter Data adds no admin configuration page. You use it entirely from the
**Views UI** (**Structure → Views**), by adding its output to a View's header and
optionally overriding its template in your theme.

## How to use it

1. Build (or edit) a View that has one or more **exposed filters** — for example a
   content listing where visitors can filter by category.
2. In that View, add the module's exposed-filter output to the **Header** area so
   the active filter values render above the results. This is especially useful
   when the exposed filter form is displayed as a separate block, away from the
   result list.
3. To control exactly how the values look, override the module's template in your
   own theme and format the output however you like. The submitted exposed-filter
   values are made available to the template for you to render — escape them as you
   would any user-supplied value.

> **Note:** The stock output is intentionally basic (it does not, on its own, carry
> nicely formatted filter labels). Plan to theme it to get labels and wording that
> read well to your visitors.
