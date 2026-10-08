# Ajax Wrapper — manual setup guide

**Ajax Wrapper** (`ajax_wrapper`) gives developers a reusable pattern for
AJAX-refreshing parts of a page. You define wrapper elements and refresh them via
AJAX callbacks, so a region can update in place without a full page reload.

It is a developer/front-end helper — plumbing rather than a click-to-use
feature. There is no settings page; you use its wrapper-and-callback API from
your own code wherever you want a page region to refresh over AJAX. The content
that gets re-rendered still respects its own access rules (it re-renders content
the user can already see), and the module has no access-control role of its own.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, use the wrapper/callback API in your own code to define a page
region and refresh it via an AJAX callback, updating just that region instead of
reloading the whole page. See the [`agent/`](../agent/start.md) docs and the
project page for the API details.
