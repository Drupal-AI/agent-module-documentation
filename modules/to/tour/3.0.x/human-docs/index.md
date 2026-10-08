# Tour — manual setup guide

**Tour** (`tour`) shows guided, step‑by‑step tooltip walkthroughs of your site's
interface. You define a tour as an ordered list of tips, each one anchored to a
spot on the page (a button, a field, a region), and when a user runs the tour a
series of small pop‑ups walks them through those spots in order. It is the
classic way to onboard new editors or administrators — "this is the title field,
this is where you set the publishing status, click here to save" — without
writing a separate help page.

This project is the maintained **contrib successor to Drupal core's Tour
module**, which is deprecated and removed in newer Drupal. It provides the same
capability for Drupal 11.3+ and 12. Each tour is a configuration entity that lists
the **routes** (pages) it should appear on and its ordered **tips**; you can
target very specific pages, right down to a particular content type's add form or
a single taxonomy vocabulary, using route parameters.

Tours can be authored entirely in the admin UI — add, edit, clone, enable, disable
and delete them and their tips without touching YAML — or shipped inside a custom
module as configuration. A user with the right permission gets a **Tour** button
in the toolbar (or as a block, or in the Navigation top bar) whenever the page
they are on has a tour; they can also trigger it with the `?tour` URL parameter or
the `alt+t` keyboard shortcut. The bundled **tourauto** submodule can even
auto‑open a tour for users who have not seen it yet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional submodule.
2. [Configuration](configuration/index.md) — creating and managing tours and their
   tips in the admin UI, plus the global settings.

## Where it lives in the admin menu

Tours are managed at **Configuration → User interface → Tours**
(`/admin/config/user-interface/tour`), with a global **settings** form under it.
The tours themselves appear as a **Tour** button in the toolbar on any page that
has a matching tour.

## How to use it

1. Enable the module and grant the *Access tour* and *Administer tour* permissions
   (see [Installation](installation/index.md)).
2. At **Configuration → User interface → Tours**, add a tour, choose the page(s) it
   applies to, and add tips pointing at the elements you want to highlight.
3. Visit one of those pages as a user with *Access tour* and click the **Tour**
   button to run the walkthrough.
