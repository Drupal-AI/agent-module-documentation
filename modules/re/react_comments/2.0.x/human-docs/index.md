# React Comments — manual setup guide

**React Comments** (`react_comments`) is a drop-in replacement for the front end
of Drupal's core comment system. Once installed, comment fields are replaced by an
interactive **React** application that reads and posts comments over Drupal's
**REST** API — so visitors can comment, reply, and edit **without a full page
reload** or navigating away from the content they are reading.

Beyond the smoother experience, it adds a few nice touches: users with the
*administer comments* permission can moderate directly from the front end (they
see unpublished comments and can publish, unpublish, or delete inline), and the UI
offers reverse-chronological sorting, explicit "reply to", and built-in flagging.
The React application is delivered by the module itself and rendered client-side;
the actual comment data still lives in Drupal and is served through REST.

A few caveats are worth knowing up front:

- It currently supports comment fields **on nodes only** — fieldable comments and
  multiple comment types are not supported.
- To preserve threading, "deleted" comments are not actually removed from the
  database; they are marked deleted in a custom table. They can still be fully
  deleted from Drupal's core comments admin UI (which also deletes their replies).
- If you uninstall the module, all such "deleted" comments become unpublished.

> **Security note.** Because comments are read and posted over REST, the usual
> comment protections still apply and still matter: the comment REST resources
> must be access-controlled (comment permissions govern who can view, post, and
> edit), and you should have spam/flood protection in place, since a JavaScript
> comment form is still a public POST endpoint. Comment content is user input;
> Drupal's comment system sanitises it, but this is worth keeping in mind for any
> commenting feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Comment and REST.

The module registers a settings form (`react_comments.settings`) for tuning the
comment display; the essentials of setting it up are covered under "How to use it"
below.

## Where it lives in the admin menu

React Comments provides a settings form at the `react_comments.settings` route.
Comment fields, comment types, and comment permissions continue to be managed
through Drupal's normal comment administration.

## How to use it

1. Make sure core **Comment** and **REST** are enabled and that your content type
   has a comment field (React Comments works on nodes).
2. Confirm the comment REST resources are enabled and that the right roles have
   the comment permissions they need (view/post/edit), plus *administer comments*
   for front-end moderators.
3. Add spam/flood protection as you would for any public comment form.
4. Visit a node with comments — the comment area is now the React application, and
   commenting, replying, and editing happen inline without a page reload.
