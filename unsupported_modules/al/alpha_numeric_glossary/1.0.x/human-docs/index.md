# Alpha Numeric Glossary — manual setup guide

**Alpha Numeric Glossary** (`alpha_numeric_glossary`) adds an **A–Z / 0–9
glossary** to a View — a row of letter and number links that filter the listing
down to entries beginning with that character. It is the classic building block
for glossary-, directory-, or index-style browsing, where visitors jump straight
to the "M" entries or the numbers.

You add it inside Views as a **global area** item (in the header or footer of a
View), so it sits above or below your results and drives the filtering. It builds
on core Views, and the results always respect the View's own access rules — the
glossary has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. You add and configure the glossary from
within a View, in the Views UI at **Structure → Views**
(`/admin/structure/views`), by adding it to the View's global area.

## How to use it

1. Edit (or create) a View that lists the content you want to browse.
2. In the View's **header** or **footer**, add the Alpha Numeric Glossary global
   area item.
3. Save the View. Visitors now see the A–Z / 0–9 links, and clicking one filters
   the listing to entries starting with that character.
