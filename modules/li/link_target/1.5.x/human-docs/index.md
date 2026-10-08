# Link Target — manual setup guide

**Link Target** (`link_target`) adds a small but useful control to Drupal's core
Link field: it lets editors choose, per link, how that link opens — in the same
window, a new tab/window, and so on — right from the edit form, instead of you
having to hard-code `target="_blank"` in a template or teach editors to type raw
HTML.

It works as a field **widget** called **"Link with target"**. Once you select it
on a link field's *Manage form display*, each link item on the edit form gains a
**"Select a target"** dropdown next to the URL and title. The editor's choice is
saved into the link's own data, so nothing changes in your field storage or your
display formatter — Drupal already knows how to output a link's attributes, so the
chosen target just appears in the rendered `<a>` tag.

You can also **restrict** which target choices editors see, per field. The widget
offers four possible targets (current window, new window, parent window, topmost
window), and its settings let you tick only the ones that make sense for a given
field — for example limiting a footer "social links" field to just "new window", or
hiding the rarely-useful parent/top options on a content type's link field.

The module depends only on core's **Link** field module and works on Drupal 8
through 11. There is no admin settings page — everything is set per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

It has no page of its own. You apply the widget on the **Manage form display** tab
of whichever bundle holds your Link field — for example
`/admin/structure/types/manage/page/form-display`.

## How to use it

1. Make sure the field you want is a core **Link** field.
2. Go to the bundle's **Manage form display** tab.
3. Change that field's **Widget** to **Link with target**.
4. Click the gear/cog icon to open the widget settings. Under **available
   targets**, tick which of the four choices editors may pick:
   - **Current window** (`_self`)
   - **New window** (`_blank`)
   - **Parent window**
   - **Topmost window**

   Leave them all unticked to offer all four.
5. Click **Update**, then **Save**.

Now, on the entity edit form, each link row shows a **"Select a target"** dropdown.
Whatever the editor picks is saved with that link and appears as the `target`
attribute when the link is rendered.

> **A note on the "parent" and "top" choices:** as shipped, the parent and topmost
> options are stored without the leading underscore that standard HTML expects
> (they produce `target="parent"` / `target="top"` rather than `target="_parent"` /
> `target="_top"`). The **Current window** (`_self`) and **New window** (`_blank`)
> choices — which are by far the most common — produce correct, standard HTML. If
> you only need "same tab vs. new tab", you're on safe ground.
