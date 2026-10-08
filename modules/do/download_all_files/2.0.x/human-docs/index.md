# Download All Files — manual setup guide

**Download All Files** (`download_all_files`) adds a "download everything" link to
a file field. It ships a field formatter — *Table of files with download all
link* — for core's **File** and **Image** field types, which bundles all of an
entity's attached files into a single zip archive generated on demand. Any page
that carries several documents — a tender with a dozen annexes, a course with its
handouts, a planning application with its drawings, a press kit — becomes a
one‑click download instead of a tedious file‑by‑file exercise.

The design solves a real problem cleanly: the usual alternative is asking editors
to maintain a *second*, hand‑built zip that immediately drifts out of step with
the field it duplicates. Generating the archive straight from the field removes
that whole class of maintenance.

It depends only on core's **File** module and runs on Drupal 10.2 and 11. It is
minimally maintained (maintenance fixes only) but is security‑advisory covered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone settings form** for this module. You use it by choosing
its formatter on a file field's **Manage display**, so there is no separate
Configuration page in this guide.

## How to use it

1. Go to the **Manage display** tab of a content type (or other entity) that has a
   core **File** or **Image** field — **Structure → Content types → *(type)* →
   Manage display**.
2. For that field, set the format to **Table of files with download all link**.
3. Use the formatter's settings gear to adjust the display if you like: the link
   text, whether the link shows as an icon, a collapsible *details* wrapper, the
   link's position (above the table or in its header), a minimal "simple theme",
   and whether to show each file's description instead of its filename.
4. Save. When the entity is viewed, the field renders as a table of its files with
   a single **Download All** link that streams a zip of every file in the field.
