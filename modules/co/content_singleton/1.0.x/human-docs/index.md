# Content Singleton — manual setup guide

**Content Singleton** (`content_singleton`) provides a fieldable content entity
type where each bundle is a **singleton** — exactly one instance per bundle. It's
the clean way to model site-wide, one-off content: an "About Us" page, a "Contact"
page, a "Privacy Policy", or a "Global banner" / "Homepage settings" block. Rather
than shoe-horning these into a special node type (where nothing stops someone
creating a second "About Us") or building a bespoke config form, you get a proper
content entity with fields, a dedicated URL, revisions, and translations — and the
module enforces that only one of each ever exists.

Because singletons are real content entities, each type can have its own fields
(add any Drupal field type), its own custom frontend path (like `/about-us` or
`/contact`), full revision support (history, revert, restore), multilingual
translation via core's translation system, and publish/unpublish control.
Permissions are granular and per-type — separate view, edit, delete, and revision
rights for each singleton type — and the data is exposed to Views for custom
displays. Access follows normal Drupal entity access plus the module's own
permissions; it adds no special access-control role beyond that.

Setup is structural rather than a settings form: you create singleton *types*
(much like content types), add fields to them, then create the single instance of
each. The module requires **PHP 8.3** and **Drupal 11**, and has no dependencies
beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This is an early release (1.0.0-alpha1) and the project is not covered
> by Drupal's security advisory policy. Confirm your host runs PHP 8.3 or newer
> before installing.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** — you define singleton types and their
fields through Structure, much like content types, described in "How to use it"
below.

## Where it lives in the admin menu

Singleton **types** are managed at **Structure → Content Singleton Types**
(`/admin/structure/content-singleton`). The singleton **content** itself is
created and managed at **Content → Content Singletons**
(`/admin/content-singleton`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content Singleton Types**
   (`/admin/structure/content-singleton`) and click **Add Content Singleton
   Type**. Configure:
   - a **label** and **machine name**,
   - an optional **custom frontend path** (defaults to the machine name — e.g.
     `/about-us`),
   - whether to **enable revisions** by default.
3. Use **Manage fields** on the new type to add whatever fields the content needs,
   and **Manage display** to control how it renders.
4. Go to **Content → Content Singletons** (`/admin/content-singleton`) and create
   the single instance of your type. The module prevents creating a duplicate for
   a type that already has one.
5. Visit the configured path (e.g. `/about-us`) to view the published content.
6. Grant the per-type **view/edit/delete/revision** permissions on **People →
   Permissions** to the appropriate roles.
