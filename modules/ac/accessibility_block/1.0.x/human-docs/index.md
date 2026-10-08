# Accessibility Block — manual setup guide

**Accessibility Block** (`accessibility_block`) provides a **block of visitor
accessibility tools** — on-page controls such as **text resize** and **contrast
adjustment** that let visitors adapt a page to their needs. You place the block in
a region of your theme, and the controls appear for everyone who views the site.

The controls are client-side preferences: they change how the page looks in the
visitor's own browser and do not alter your content or anyone's permissions. The
module has no content model and no access role — it is purely a front-end
presentation aid. It works across Drupal 10 and 11.

Use it when you want to offer visitors simple, familiar accessibility controls
directly on the page — for example on a public-facing site where some visitors may
not know how to change their browser or operating-system settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. (The agent docs for this module are
brief — this guide reflects what they describe.)

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You add the tools by placing the block at
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region where the controls should appear (a header or sidebar region
   is common) and click **Place block**.
3. Find and place the **Accessibility Block**.
4. Configure the standard block settings (region, visibility conditions, title)
   and save.

Once placed, visitors see the accessibility tools — such as text resize and
contrast controls — and their choices are applied client-side as they browse.
