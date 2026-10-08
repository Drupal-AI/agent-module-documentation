# Views Autosubmit — manual setup guide

**Views Autosubmit** (`views_autosubmit`) makes a View's exposed filter form submit
itself automatically — as the visitor types in a text box or changes a select
control — instead of forcing them to click an **Apply** button. The result is an
instant, "live filtering" experience: product catalogs that narrow as shoppers
adjust filters, search boxes that query as you type, and faceted-style browsers,
all using core Views with no custom JavaScript.

It works by adding a single **Autosubmit** exposed-form style to Views. On any view
display, you switch the exposed form style from *Basic* to *Autosubmit* and you're
done. Two small options let you tune the behavior: you can hide the now-redundant
submit button when JavaScript is available (while keeping it as a no-JS fallback),
and you can set a debounce delay so a text filter waits a moment after the visitor
stops typing before it submits.

Views Autosubmit pairs naturally with a view's **Use AJAX** setting, so results
refresh in place rather than reloading the whole page. Everything it does lives in
the view's own display configuration, so it exports and deploys cleanly with the
rest of your Views config. The module has no admin settings page, permissions, or
Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it needs core Views).

## Where it lives in the admin menu

There's no dedicated settings page. You select the Autosubmit style per view
display in the Views editor at **Structure → Views**
(`/admin/structure/views`), under **Advanced → Exposed form → Exposed form style**.

## How to use it

1. Edit the view at **Structure → Views** and open the display you want.
2. In the **Advanced** column, find **Exposed form → Exposed form style** and change
   it from *Basic* to **Autosubmit**. Click **Apply**.
3. On the options screen, set:
   - **Hide submit button** (`autosubmit_hide`, default on) — hides the Apply button
     when JavaScript is enabled. The button still works as a fallback for visitors
     without JavaScript.
   - **Timeout** (`timeout`, default **500** ms, range 0–10000) — how long a text
     input waits after the visitor stops typing before auto-submitting. Lower it for
     snappier response, raise it to cut down on requests while someone is mid-word.

   Click **Apply**.
4. It's usually best to also turn on **Advanced → Other → Use AJAX** so results
   update in place instead of reloading the page.
5. **Save** the view.

Because the setting is per display, you can apply autosubmit to just one display of
a view (for example the page but not a block), and select the same style across
several views to standardize instant filtering site-wide.
