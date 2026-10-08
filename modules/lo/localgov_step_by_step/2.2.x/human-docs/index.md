# LocalGov Step by step — manual setup guide

**LocalGov Step by step** (`localgov_step_by_step`) provides guided journeys for a
[LocalGov Drupal](https://localgovdrupal.org/) site: a **step-by-step overview**
page that lists a set of ordered **step pages**, plus a "part of" block that shows a
visitor where they are in the sequence. It's the tool for turning a task like
"report a missed bin collection" or a multi-stage application into a clear, ordered
set of steps, each with its own URL, rather than one long how-to page.

The shape mirrors LocalGov Guides but is aimed at sequential tasks. An
`localgov_step_by_step_overview` node holds the ordered list of steps; each
`localgov_step_by_step_page` node points back at its overview via a parent field.
The nice part is that the list maintains itself: when you save a step page, the
module checks whether its overview already references it and, if not, appends it and
saves the overview — so you don't have to hand-maintain the ordered list. (That sync
is one-way and wrapped in error handling, so a failure is logged rather than
blocking your save.) A shipped view renders the steps as a numbered journey, and the
"part of" block shows the containing journey and the current position on each step
page.

Because the module depends on **Preview Link**, a whole journey can be shared with a
reviewer before it's published. It also integrates with the wider LocalGov stack: it
wires in optional fields when LocalGov Services Navigation or Topics are present, and
grants editor/author permissions (including scheduled-transition permissions when
Scheduled Transitions is in use). The module has no admin settings page and no
permissions of its own; it requires **LocalGov Core** and **Preview Link**, plus
core **Path**, **Text** and **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build a journey, place the "part of"
   block, and share a draft with Preview Link.

## Where it lives in the admin menu

There is no settings page. You work with the content it provides:

- **Content → Add content → Step by step overview** and **Step by step page**
  (`/node/add`).
- **Structure → Block layout** (`/admin/structure/block`), to place the *Step part
  of* block.

## How to use it

1. Create a **Step by step overview** node — this is the journey's entry page.
2. Create **Step by step page** nodes, setting each one's parent to that overview.
   As you save each step, it is automatically appended to the overview's ordered
   list.
3. Reorder the steps on the overview if needed.
4. Place the *Step part of* block so visitors see where they are in the journey.

See [Configuration](configuration/index.md) for the details.
