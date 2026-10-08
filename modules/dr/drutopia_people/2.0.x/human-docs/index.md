# Drutopia People — manual setup guide

**Drutopia People** (`drutopia_people`) adds a **People** content type to a
[Drutopia](https://www.drupal.org/project/drutopia) site, so you can publish
profile pages for staff, volunteers and contributors — and attribute articles
and blogs to those people. Enable it and you get a `people` node type with a
position/title field, a profile type, body and summary, a portrait image, and a
`people_type` classification vocabulary, along with a people listing view, a
"content by author" view, Pathauto aliases and Metatag/SEO defaults.

A person profile can double as an author reference: because articles and blogs
can point at a People node, each profile can show a "content by author" list of
that person's posts. The listing view carries an "Add person" action link so
editors can create profiles quickly.

Everything is delivered as configuration — there is no custom PHP, no routes and
no permissions of its own. Access is governed by core node permissions and the
Drutopia editorial roles (contributor/editor/manager) the feature augments via
its config actions. It builds on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) and
[`drutopia_seo`](../../drutopia_seo/2.0.x/human-docs/index.md), and wires in
Display Suite, Field Group, Paragraphs, Pathauto, Metatag, Search API and Views
Plain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Drutopia and supporting dependencies.

## Where it lives in the admin menu

There is no settings form. The People content type appears under **Structure →
Content types** (`/admin/structure/types`); create profiles from **Content → Add
content → People** (`/node/add/people`) or via the "Add person" action link on
the people listing. The `people_type` vocabulary is under **Structure →
Taxonomy** (`/admin/structure/taxonomy`).

## How to use it

Add a person profile with their position, type, portrait image and a body, and
save. The people listing view presents everyone; the content-by-author view
gathers a person's articles and blogs. Index profiles in Search API to make them
searchable, and adjust the card/teaser/full displays to theme the profiles as
needed.
