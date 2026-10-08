# Feeds Dependency — manual setup guide

**Feeds Dependency** (`feeds_dependency`) lets you declare that one
[Feeds](https://www.drupal.org/project/feeds) importer **depends on** another, so
the dependency always runs first. It turns an implicit, easy‑to‑forget "run these
in the right order" convention into configuration that the import process
enforces for you.

Real‑world imports are rarely independent. A feed of articles references a feed of
authors; a feed of products references a feed of categories; a feed of content
references media that another feed creates. If the referencing feed runs before
the referenced entities exist, the references dangle or the rows are skipped — and
the usual workaround is to remember to run the feeds by hand in the correct order,
which breaks the first time someone runs them alphabetically or on a schedule.

With this module you mark a feed as depending on another. When you run the
dependent feed, Feeds imports its dependency first, so the referenced entities
already exist by the time the dependent feed looks for them. There's also a handy
option to **clear the dependency feed** when the main feed is cleared (its items
deleted), keeping the two in step.

Its value is entirely in multi‑feed setups — a single, independent feed has
nothing to depend on. Confirm the dependency graph you configure matches the
reference structure of your content, since a wrong or missing dependency
reintroduces the very ordering problem the module exists to solve.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate settings page** for this module. You set the dependency on
the feed's own edit form, described in "How to use it" below.

## Where it lives in the admin menu

Feeds Dependency adds no admin page of its own. Feed types are managed at
**Structure → Feed types**, and the dependency is chosen on individual feeds at
**Content → Feeds → *(your feed)* → Edit**.

## How to use it

1. Create the feed types you need — for example one feed type that imports media
   entities and another that imports the content referencing them.
2. Create the actual feeds from those types at **Content → Feeds**. Often the two
   feeds share the same source URL or file.
3. Edit the **dependent** feed (the one that references the other). Use the
   provided entity‑reference field to select the feed it should depend on.
4. Optionally tick the checkbox to **clear the dependency feed** when this feed is
   cleared, so deleting items in one also clears the other.
5. Run the **Import** operation on the dependent feed. Feeds processes the
   dependency feed first, then the dependent feed — so its references resolve
   correctly.
