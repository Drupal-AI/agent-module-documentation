# Ajax link — manual setup guide

**Ajax link** (`ajax_link`) uses AJAX to load the content of a link into the
current page instead of navigating away — so "more content" can appear in place,
and the same mechanism can drive **infinite scroll**, loading the next page's
content as a visitor reaches the end of a list.

It is a front-end/UI convenience that saves you from writing custom JavaScript
for these patterns. The content it pulls in is still the linked page or route,
so that content continues to respect its own access rules — Ajax link only
changes *how* it is loaded, not *what* a visitor is allowed to see.

Typical uses are a "load more" link on a listing, or turning a pager into an
infinite-scroll feed. You mark which links should load their target via AJAX
rather than as a normal navigation.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, you designate the links that should load their content via AJAX
(for example on a listing or pager) so their target is fetched into the current
page's DOM rather than triggering a full page load. Used on a "next page" link,
this gives you infinite scroll. Because the loaded content is the linked
route's normal output, its access and rendering are unchanged. See the
[`agent/`](../agent/start.md) docs and the project page for how to apply the
AJAX behavior to specific links.
