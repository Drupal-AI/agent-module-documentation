<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advent Calendar Quickstart scaffolds a complete advent calendar — content type, vocabulary, per-day door nodes, and a View — in one install.

---

Advent Calendar Quickstart is a one-shot setup submodule for Advent Calendar. Installing it ensures the *Advent
Calendar Door* content type exists, creates the *Year* taxonomy vocabulary with a term for the current year,
creates one door node per day (1–24) with randomised positions and a shipped candle image, and installs a
ready-made View that uses the Advent Calendar Views style. The day nodes are created unpublished so you publish
each one (manually or via a scheduling module) as its day arrives. After it has run, the submodule has no further
job and can be uninstalled; reinstall it the following year to seed that year's entries. It depends on Advent
Calendar plus several core modules (node, taxonomy, field_ui, image, link, menu_ui, views_ui, path, text).

---

- Stand up a working advent calendar without building anything by hand.
- Create the *Advent Calendar Door* content type automatically.
- Create the *Year* vocabulary and a term for the current year.
- Generate 24 day nodes with a placeholder candle image.
- Randomise the on-screen positions of the doors.
- Install a pre-built View wired to the Advent Calendar style.
- Get started, then edit the generated nodes with your real content.
- Publish each day's node on its date (manually or with Scheduler).
- Reinstall next year to create that year's door nodes.
- Uninstall once setup is done — the module has no runtime role.
- Use the scaffolded View as a starting point for your own display.
- Learn the intended field mapping by inspecting the generated content type and View.
- Seed a demo/staging site with a full calendar quickly.
- Reuse the created *Year* term structure across multiple calendars.
- Skip creating duplicates — it only creates nodes/terms that don't already exist.
