# G2 Glossary — manual setup guide

**G2 Glossary** (`g2`) manages a **node‑based glossary** of terms and
definitions. Unlike term‑based glossary modules, each glossary entry is a full
Drupal node (a term plus its definition), which is what makes G2 suited to
**high‑volume** glossary and dictionary sites — think thousands of entries or
more. It has been around a long time (its lineage goes back to Drupal 4.7) and
the `8.x-1.x` branch targets modern Drupal.

On top of the entries themselves, G2 gives you the pieces that make a glossary
feel like a glossary: alphabetical browsing (an optional "alphabar"),
cross‑referencing between entries, a homonyms/disambiguation page, and blocks such
as a **Word of the Day** and a **random entry**. The Drupal 10/11 rewrite leans on
core fields, Views, and templates, so much of the presentation is exposed to Views
for no‑code reporting (for example, G2 "referrers" reports).

Because entries are nodes, they follow **normal node access** — publishing,
permissions, and moderation all behave as they do for any content type. G2 also
provides its own permissions for administering the glossary. This is a
**beta** release (`8.x-1.0-beta3`) on Drupal `^10.3 || ^11`.

> **A dependency to check before you install:** G2 has historically relied on the
> **XML‑RPC** feature, which was removed from Drupal core and now lives as a
> contrib module. XML‑RPC endpoints have long been an attack surface, so only
> enable the XML‑RPC *server* if you actually need it, and review whether pulling
> in that dependency is acceptable for your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

The glossary is built primarily from content (nodes), blocks, and Views rather
than a single settings form, so setup is covered in "How to use it" below.

## Where it lives in the admin menu

G2 provides its own permissions, managed at **People → Permissions**. Its blocks
(Word of the Day, random entry, footnotes) are placed at **Structure → Block
layout** (`/admin/structure/block`), and its listing pages (alphabetical index,
disambiguation, Word‑of‑the‑Day feed) are Views you can adjust under **Structure →
Views**.

## How to use it

1. After enabling, set the G2 permissions at **People → Permissions** for the
   roles that create and manage glossary entries.
2. Create glossary entries as G2 nodes — each entry is a term with its definition.
3. Place G2's blocks (for example **Word of the Day** or a random‑entry block) in
   regions via **Structure → Block layout** to promote entries around the site.
4. Use the provided Views (alphabetical browsing, disambiguation of homonyms, the
   Word‑of‑the‑Day feed, and referrer reports) as your glossary's navigation, and
   customise them under **Structure → Views** if needed.
