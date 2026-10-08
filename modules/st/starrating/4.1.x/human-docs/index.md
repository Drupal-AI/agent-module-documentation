# Starrating — manual setup guide

**Starrating** (`starrating`) adds a simple star‑rating **field** to Drupal. You attach
it to a content type (or any fieldable entity) and an editor picks a whole‑number
score on the edit form; on the page it renders as a row of icons — stars, hearts,
thumbs‑up, dollar signs, and more. It is an **author‑set rating**, not an end‑user
voting widget: think of a reviewer scoring a restaurant's food, price, and service, or
a staff‑assigned score on a movie or product review. There is no AJAX voting and no
voting API — just a clean, lightweight rating value the content author controls.

Under the hood it is a single field type storing one small integer, with a
select‑list widget (0 to your chosen maximum, where 0 means "not selected") and three
display formatters:

- **Icons** — draws the score as a row of icons, with a choice of 17 icon sets, eight
  color variants, and the option to also show empty icons up to the maximum.
- **Value** — prints the raw number.
- **Value / rating** — prints the score as `rate/max`, for example `8/10`.

Because it is a normal field, you can add several independent rating fields to the same
content type (say, separate food, price, and service scores with different icons), show
ratings in Views, and mix numeric and icon formatters across different view modes. It
depends only on core's Field module and stores its settings as configuration, so
everything exports and deploys cleanly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a rating field, set its maximum, and
   choose how it displays (icons, colors, or plain text).

## Where it lives in the admin menu

Starrating has **no central settings page**. You configure it entirely per field,
through **Field UI** — a bundle's **Manage fields** and **Manage display** screens
(for example **Structure → Content types → [type] → Manage fields**).

## How to use it

Add a **Star rating** field to a content type, set the maximum score, and then choose a
display formatter on the Manage display screen. Editors then set the rating right on
the entity's edit form. The step‑by‑step is in [Configuration](configuration/index.md).
