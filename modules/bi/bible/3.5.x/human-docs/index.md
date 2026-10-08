# Bible — manual setup guide

**Bible** (`bible`) imports and displays Bible translations as browsable content.
It brings scripture into your Drupal site as regular content — books, chapters and
verses — and gives you reading and reference views so visitors can navigate a
translation the way they would a printed Bible. It is aimed at church and religious
sites that want to publish scripture directly on their own pages.

Once a translation is imported, the text behaves like any other Drupal content: it
follows core's normal view access, appears in Views, and can be themed and placed
like the rest of your site. The module does not add any access-control behavior of
its own beyond the permissions it defines — imported scripture is simply published
content. It relies on core's Field, File, Filter, Text, User and Views modules to
store and render the material.

There is no external service and no API involved: you import the scripture text and
the module presents it. Think of it as a content-and-publishing feature for
scripture rather than an integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in the core Field, Views and Text modules it needs).

## Where it lives in the admin menu

Bible does not add a single central settings form. It defines its own permissions
(set them under **People → Permissions**, `/admin/people/permissions`) and provides
reading and reference views that you can find and adjust under **Structure → Views**
(`/admin/structure/views`). Content and imported scripture live with the rest of
your site content.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Review the permissions it adds under **People → Permissions** and grant them to
   the roles that should read or manage scripture.
3. Import a Bible translation, then browse it through the reading/reference views
   the module provides. Because scripture is stored as ordinary content, it obeys
   core's view access and can be themed and placed like anything else on your site.
