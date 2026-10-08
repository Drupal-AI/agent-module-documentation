# Mentions — manual setup guide

**Mentions** (`mentions`) brings Twitter-style @-mentions to Drupal. It records
every reference to a user — written as `[@username]` or `[@#uid]` in content —
and, through an input filter, turns those tokens into a link to the user's
profile (so `[@deciphered]` and `[@#103796]` render as `@deciphered`). It can
track mentions on any entity and gives you a centralized place, via Views, to see
who has been mentioned and where.

The problem it solves is community engagement: letting people reference each
other in comments, posts, and other content, with the mention rendered as a link
and — through integrations — reacted to (for example, notifying the mentioned
user). Input and output patterns are customizable and support Tokens, so you can
tune exactly what editors type and what the site displays.

Because mention patterns come from **user-authored content**, the care in a
mention system is in safe rendering: the resolved link and label are what appear
on the page, so confirm mentions render as safe, escaped links and that
mentioning a user respects that user's visibility — a mention should not disclose
an account a viewer could not otherwise discover. Mentions integrates with
**Rules** (react to created/updated/deleted mentions), **Views** (list all
mentions, mentions by user, and more), and can use a **Machine name** field as a
mention source; the **Token** and **Libraries API** modules are recommended
companions (Libraries API enables the jQuery textcomplete autocompletion that
suggests usernames as you type).

Mentions does **not** work on enable alone — you must turn on the Mentions filter
for the text formats where you want it, and (optionally) tune the input/output
patterns. Its only hard dependency is core's **Filter** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the filter on your text
   formats and customize the mention input/output patterns.

## Where it lives in the admin menu

Two admin pages matter. You enable the Mentions filter per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and you tune the mention patterns at the
Mentions settings form, **`/admin/config/content/mentions`**.
