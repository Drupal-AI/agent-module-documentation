# Paragraphs Browser Deploy — manual setup guide

**Paragraphs Browser Deploy** (`paragraphs_browser_deploy`) makes
[Paragraphs Browser](https://www.drupal.org/project/paragraphs_browser)
configuration deployable. Paragraphs Browser gives editors a categorized "palette"
of paragraph types — often with an image for each type — to pick from when adding
content. Those images and their paths are not normally captured in a way that moves
cleanly between environments, so this module adds Drush commands that update the
Paragraphs Browser images and, optionally, change the image folder path, so the
setup can be reproduced through your standard deployment pipeline instead of being
recreated by hand.

It is a **developer / deployment tool**, not something editors interact with. It
depends on the Paragraphs and Paragraphs Browser modules, provides **Drush
commands**, and has no runtime access role of its own.

The key requirement to know up front: you need an **images folder** whose files are
named after the **system (machine) name** of each paragraph type, and the folder's
URL can be changed with the second command below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
drive it entirely with the two Drush commands described in "How to use it" below.

## Where it lives in the admin menu

Paragraphs Browser Deploy adds no admin page. Everything happens on the command
line via Drush and through your normal configuration workflow.

## How to use it

1. Prepare an **images folder** and name each image file after the machine name of
   the paragraph type it represents.
2. Run the deploy command to update the Paragraphs Browser images from that folder:

   ```bash
   drush paragraphs-browser-deploy:deploy
   ```

3. If you also need to point Paragraphs Browser at a different image folder path,
   use the change command, which updates the images **and** changes the browser's
   image folder path:

   ```bash
   drush paragraphs-browser-deploy:change
   ```

4. Export the resulting configuration (`drush config:export`) and commit it, so the
   Paragraphs Browser setup is version‑controlled and can be deployed to other
   environments through your standard config pipeline.
