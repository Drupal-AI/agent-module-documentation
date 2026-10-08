# Views Row Insert — manual setup guide

**Views Row Insert** (`views_row_insert`) is a Views **style plugin** that mixes an
extra "inserted" row into a view's results after every Nth row. The inserted row
can be either a rendered Drupal **block** or a piece of **custom HTML** you type in.
The classic use is injecting in-feed ads (such as a Google AdSense unit) or promo
blocks between the rows of a listing, but it works equally well for call-to-action
banners, newsletter-signup blocks, or dividers.

You choose it from a view display's **Format** section, just like the Unformatted
list, Grid, or Table styles. Its options let you decide what to insert, how often
(after every Nth row), and whether to also insert a row at the very top (a header)
or the very bottom (a footer). You can cap how many inserted rows appear per page,
add CSS classes to both the inserted rows and the original rows, and optionally
re-add Views' default row classes and odd/even striping.

Because everything lives in the view's configuration, there is no separate admin
settings page — you configure it entirely in the Views UI. That is why this guide
has no configuration page of its own; the how-to below covers it.

> **Security note:** the **Custom content** option renders whatever HTML (and
> JavaScript) you type, verbatim, to every visitor — it is not filtered. Only put
> content you trust there, and only let trusted users edit these views.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token-cheap references for an AI coding agent — including the full option
list and how to override the row template — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Row Insert adds no admin pages. You use it from the Views UI at **Structure
→ Views** (`/admin/structure/views`), inside a view display's **Format** settings.

## How to use it

1. Edit a view at **Structure → Views** and pick the display you want.
2. In the **Format** section, change the style to **Row Insert** and open its
   settings.
3. Choose what to insert:
   - **Block** — pick any block (including a custom block content block) from the
     list.
   - **Custom content** — type the HTML you want in the textarea.
4. Set **Insert after every Nth row** to control the spacing (for example every 3
   rows).
5. Optionally enable:
   - **Header row** — insert one row before all results.
   - **Footer row** — append one row after the last result.
   - **Limit** — cap the number of inserted rows per page (for example at most 2
     ads).
   - **Class name** — a CSS class wrapping each inserted row (handy for targeting
     ads in CSS), and **row class** — a class added to each original row.
   - **Default rows / strip rows** — re-add Views' standard `views-row` classes and
     odd/even, first/last striping if your template dropped them.
6. Save the view.

There is also a master **on/off** toggle for the plugin, so you can disable the
inserted rows on a display while keeping the style configured for later.

### Customizing the markup

Developers can override the `views-row-insert.html.twig` template in their theme to
fully control how rows are wrapped. Inserted rows and original rows are told apart
by the CSS classes you set above, so set those if your override needs to target
them. See the [`agent/`](../agent/theming/template.md) docs for details.
