# Views Flag Refresh — manual setup guide

**Views Flag Refresh** (`views_flag_refresh`) makes an AJAX-enabled View re-run
itself automatically the moment a visitor clicks a **[Flag](https://www.drupal.org/project/flag)**
link somewhere else on the same page. So a "My favorites" block, a "flagged for
review" moderation list, or a wishlist-style View stays in sync as items are
flagged and unflagged — no manual reload, and no custom JavaScript.

You choose, per View display, which flags should trigger a refresh. When a matching
flag or unflag link is clicked, the module fires the View's normal AJAX refresh (or
re-triggers its exposed filter form). There's also an option to suppress the
slightly jarring scroll-to-top jump that usually follows an AJAX view refresh.

The whole feature is configured on the View itself — there's no global settings
page and no permissions. It does require both the **Flag** and **Views** modules,
and it only takes effect on displays where core's **Use AJAX** option is turned on.

This guide is written for a **human** configuring views through the admin UI. If
you want terse, token-cheap references for an AI coding agent (the display
extender options, the runtime AJAX wiring), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Flag) with
   Composer and enable it.

## Where it lives in the admin menu

There is no admin settings page. You configure it inside the **Views UI**
(`/admin/structure/views`), in the **Other** section of an individual view
display.

## How to use it

1. Edit the View and pick the display you want to keep in sync.
2. In the display's **Other** section, set **Use AJAX** to **Yes**. This is
   required — the refresh only runs on AJAX-enabled displays.
3. Still in **Other**, click the value next to **Refresh view by Flag**.
4. Tick the **flag(s)** under *Refresh display on flags* that should trigger a
   refresh of this display. (The list offers every flag configured on the site.)
5. Optionally tick **Disable scroll to top of this view** to suppress the
   post-refresh scroll jump.
6. Apply, save the View, and clear the cache.

**How it behaves:** the flag link and the View must render on the same page,
because the module matches them by view id and display id. When a flag is toggled,
the View re-queries and re-renders in place. You can point more than one flag at a
single View, refresh several Views from one flag action, and combine this with
normal AJAX pagers and exposed filters on the same display.

**If nothing refreshes,** check the three usual suspects: *Use AJAX* is set to
*Yes*, the flag is ticked in **this** display, and the cache has been cleared.
