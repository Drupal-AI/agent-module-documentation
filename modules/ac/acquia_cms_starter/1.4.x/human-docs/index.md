# Acquia CMS Starter — manual setup guide

**Acquia CMS Starter** (`acquia_cms_starter`) fills a fresh Acquia CMS site with
ready-made **example content** — articles, events, pages, documents and videos —
so you can see a populated, realistic site the moment it is enabled instead of
staring at an empty install. It is a demonstration and evaluation aid: a quick way
to show what the distribution's content model looks like once real content is in
place, to train editors on worked examples, or to seed a development environment.

It is not a feature you build a production site around. It is **distribution glue**
— it pulls in the Acquia CMS content-type modules (Article, Document, Event, Page,
Search and Video) plus core's Default Content module and imports their sample
entities. Because it leans on the rest of the Acquia CMS family and on Site Studio
demo content, it belongs on an Acquia CMS install, not on an unrelated minimal
site. Once you have finished evaluating, the usual move is to remove the demo
content again rather than ship it.

Treat the Acquia CMS modules as a set adopted together, not as standalone features
to cherry-pick — Starter in particular expects its siblings and a configured
search index to be present, and will not enable cleanly without them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the dependencies it drags in.

## Where it lives in the admin menu

Acquia CMS Starter has no settings page of its own. Its effect shows up in your
content: after enabling it, go to **Content** (`/admin/content`) and the
**Media** library (`/admin/content/media`) and you will find the imported example
articles, events, pages, documents and videos.

## How to use it

There is nothing to configure. Enable the module on an Acquia CMS site (see
[Installation](installation/index.md)) and it imports its demo content as part of
the install. Browse the site to see the content types populated, use the examples
to train editors or to check theming against realistic data, and then **remove the
module once you are done evaluating** so the demo content does not linger on a site
headed for production.
