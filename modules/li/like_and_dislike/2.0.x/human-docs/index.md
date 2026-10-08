# Like and Dislike — manual setup guide

**Like and Dislike** (`like_and_dislike`) adds thumbs‑up / thumbs‑down widgets and
vote statistics to your content, giving visitors the familiar social‑network way to
react to a node, comment, file, user, or any other entity type. Unlike a single
"score" approach, likes and dislikes are counted **separately** — you see how many
people liked something and how many disliked it, side by side.

Under the hood it builds on the [Voting API](https://www.drupal.org/project/votingapi)
module, registering two vote tags, `like` and `dislike`. That means votes are
stored and tabulated through Voting API's standard schema, so your data lives in a
well‑understood place and other Voting‑API‑aware tools can work with it.

The widgets are **off by default** for every entity type. You explicitly choose
which entity types and bundles show the widgets on the module's settings page, and
you use permissions to control who may vote — which is also how you keep anonymous
voting from being abused.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Voting API with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — choose which entity types show the
   widgets and set the voting permissions.

## Where it lives in the admin menu

The settings page is at **Configuration → Search and metadata → Like and Dislike**
(`/admin/config/search/like_and_dislike`). Permissions are set on the usual
**People → Permissions** page.
