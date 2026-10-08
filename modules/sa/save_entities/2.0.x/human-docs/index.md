# Save Entities — manual setup guide

**Save Entities** (`save_entities`) is a simple maintenance tool that lets you
re‑save nodes and media in bulk from a form. Re‑saving an entity runs its full
save pipeline — all the save hooks and processors that fire when content is
edited — so it is the go‑to way to make a change take effect across many entities
at once without opening each one by hand.

It solves the "I just changed something that only applies on save" problem. After
adding a new field, enabling a processor that runs on save, or introducing a
module that generates derived data when content is saved, you often need existing
content to be re‑saved so the change actually lands. Save Entities does that in
bulk: you pick which content types or media types to process, optionally limit to
published content, and optionally update each entity's changed date, then submit.

The module needs a little configuration in the sense that you choose what to
re‑save each time you use it, but there is nothing to set up before first use
beyond permissions. It requires no modules outside Drupal core, provides its own
permissions, and has no submodules.

Please use it deliberately. Re‑saving runs the full save pipeline and can create
new revisions, and bulk‑saving a large number of entities has a real performance
cost and can trigger side effects. It acts with the privileges of whoever runs it
and has no access‑control role of its own, so restrict access to trusted
administrators through the permissions page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the save‑nodes and save‑media forms,
   their options, and setting the permissions.

## Where it lives in the admin menu

Save Entities provides two forms:

- **`/admin/config/content/save-nodes`** — bulk‑save nodes.
- **`/admin/config/content/save-media`** — bulk‑save media.

Access to these pages is controlled by permissions, so grant them only to the
roles that should be allowed to run bulk re‑saves.

## How to use it

Open the relevant form, select the content or media types you want to re‑save,
tick any extra options you need (published‑only, update changed date), and press
save. The selected entities are re‑saved, running their save hooks.
