# CacheViz — manual setup guide

**CacheViz** (`cacheviz`) is a developer tool that makes Drupal's render caching
visible. When a page is rendered, every element carries invisible caching
metadata — cache *tags*, cache *contexts*, and a *max-age* — that decide when it
is reused and when it is thrown away. CacheViz surfaces that metadata so you can
see exactly why a piece of the page is (or isn't) being cached or invalidated.

It is meant for debugging during development. When something on your site won't
update after a change, or caches in a way you don't expect, CacheViz lets you
inspect the tags and contexts attached to the rendered output and work out what
is keeping it stuck — or what is invalidating it too aggressively.

Because it exposes internal cache information, treat it as a developer-only
window into the site. Grant its permission only to trusted developers, and
prefer to run it on a development or staging environment rather than leaving the
visualization switched on in production. It has no other role — no content, no
public-facing feature — beyond that one permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission to developers.

## Where it lives in the admin menu

CacheViz is in the **Development** package on the Extend (modules) page. It ships
its own permission (set it under **People → Permissions**), which you should
restrict to developer roles. There is no settings form to configure — once the
permission is granted, use the tool to inspect cache metadata on rendered pages.

## How to use it

Enable the module, grant its permission to the developer role you use for
debugging, and then browse the site as that user to inspect the cache tags,
contexts, and max-age attached to rendered elements. Use it to answer questions
like "why didn't this block update?" or "why is this fragment never cached?" —
then remove or restrict the permission again before you ship to production.
