# Voting API Reaction — manual setup guide

**Voting API Reaction** (`votingapi_reaction`) adds Facebook/Disqus-style
reactions to your content. Users click a reaction (like, love, laugh, and so on)
and can switch or remove it — all without a page reload — while the counts update
live. It ships six ready-made reactions (angry, laughing, like, love, sad,
surprised) and lets you create your own.

Under the hood it's a **Field API field**, so you turn reactions on wherever you
want them simply by adding a *Reaction* field to a content type, comment type,
taxonomy term, or any other entity bundle. The reactions themselves are **Voting
API vote types** flagged "Use as a Reaction," which means every reaction is a real
vote you can query, aggregate, and report on with Voting API's tooling. Each
reaction can show an uploaded icon, a remote image, or an icon-font element.

You get fine-grained control: per-field settings choose which reactions are
available and how anonymous voting is handled; per-display (formatter) settings
control whether the icon, label, count, and summary appear and how reactions are
sorted; and each individual entity carries an *Open / Closed / Hidden* status so
you can turn reactions off on a single item. Access is governed by dynamic,
per-field permissions (view / create / modify / control status).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Voting API
   dependency, then enable it.
2. [Configuration](configuration/index.md) — add the field, tune field and
   formatter settings, define your reactions, and grant the per-field permissions.

## Where it lives in the admin menu

There is no single settings page. You configure reactions in three familiar
places: the **Manage fields** / **Manage display** tabs of whatever bundle you're
adding reactions to, the **Voting API vote types** admin (where you flag and style
reactions), and **People → Permissions** (for the per-field access permissions).

## How to use it

Enable the module, add a **Reaction** field to a bundle (for example the *Article*
content type), choose which reactions to offer and how the widget looks, then grant
the *view* and *create* reaction permissions to the roles that should be able to
react. See [Configuration](configuration/index.md) for the full walkthrough.
