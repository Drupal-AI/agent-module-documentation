# CKEditor5 Bootstrap Tabs — manual setup guide

**CKEditor5 Bootstrap Tabs** (`ckeditor_bootstrap_tabs`) adds a toolbar button to
CKEditor 5 that lets content editors insert and manage Bootstrap-style **tabbed
content** directly inside the WYSIWYG. Editors click the button, choose how many
tabs to insert, and get an interactive tab set — with a context menu to add a tab
before or after, remove a tab, or rename a tab title. Multiple independent tab
widgets can live on the same page.

Under the hood the module produces the exact markup Bootstrap expects for tabs —
a `ul.nav.nav-tabs` list of triggers plus a `div.tab-content` of `div.tab-pane`
panels — so a Bootstrap-based theme renders them natively. It's ideal for tabbed
FAQ or documentation layouts, product pages with Description / Specs / Reviews
sections, and any place editors would otherwise be hand-coding tab HTML.

You enable it by adding the **Bootstrap Tabs** button to a text format's CKEditor 5
toolbar. The only dependency is core's **CKEditor 5** module. Two things to keep in
mind: if the format uses *Limit allowed HTML tags*, you must allow the tab markup so
it isn't stripped; and the module does **not** ship Bootstrap's own CSS framework —
your theme is expected to provide the Bootstrap tab styling. (The module does load a
small bundled script/stylesheet so the tabs switch for visitors.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. You enable the widget per text format at **Configuration
→ Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by adding the **Bootstrap Tabs** button to that
format's CKEditor 5 toolbar.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a CKEditor 5 format (for example *Full HTML*).
2. In the **Toolbar configuration**, drag the **Bootstrap Tabs** button from
   *Available* into the *Active toolbar*.
3. If the format uses **Limit allowed HTML tags** (the *Limit allowed HTML tags and
   correct faulty HTML* filter), add the tab elements and attributes so the markup
   survives filtering. Formats that allow full HTML need no change.
4. **Save.** Editors using that format now see a **Bootstrap Tabs** button.

To author tabs, an editor clicks the button, chooses the number of tabs, and fills
in each panel. The context menu on a tab lets them add, remove or rename tabs. On
the rendered page, the bundled library makes the tabs switch; your Bootstrap theme
supplies the look.
