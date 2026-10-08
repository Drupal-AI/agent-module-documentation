# AJAX Placeholder — manual setup guide

**AJAX Placeholder** (`ajax_placeholder`) gives developers a render element that
replaces itself via AJAX. The page renders a lightweight placeholder
immediately, and then an AJAX callback fetches the real content — often
something expensive to build or personalized per user — and swaps it in.

The point is performance and cacheability. Deferring the slow or uncacheable
part of a page to a follow-up AJAX call lets the initial response render fast and
stay cacheable, while the personalized fragment loads a moment later. It is a
developer/API feature with no settings page.

Two things to keep in mind when you use it: the callback runs with the **current
user's privileges**, so it sees exactly what that user is allowed to see, and its
output should be built and escaped normally like any other render output. The
module has no content or access-control role of its own.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, use the module's render element in your own code where you want
to defer expensive or personalized output: render a placeholder first, then have
the AJAX callback build and return the real content, which is swapped in on the
client. Build and escape the callback's output as you would any render array.
See the [`agent/`](../agent/start.md) docs for the element and callback details.
