# Views Condition — manual setup guide

**Views Condition** (`views_condition`) lets you show or hide a block based on
**which view and display** is being rendered, instead of by URL path. Drupal's
usual way of controlling block visibility is to match request paths, which is
brittle: it breaks the moment a view's path changes, gets an alias, or has
several displays living under different URLs. This module sidesteps that by
looking at the actual view being rendered rather than the address bar.

It supplies a single **condition plugin**. On the condition's form you get a
short list of every view on the site, each shown as a collapsible group with a
checkbox for each of its displays — so you can target, say, the *page* display
of a news listing but not its *block* or *feed* displays. A set of radio buttons
at the top switches the overall mode between "apply to the displays I ticked"
and "apply to everything except them". Because it decides from the current
route rather than the path, aliases and language prefixes make no difference.

Being an ordinary condition plugin, it turns up everywhere Drupal exposes
conditions: block layout visibility, the Context module, Layout Builder section
visibility, and any custom code that evaluates conditions. It has no settings
form of its own, no permissions, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to **Structure → Block layout** and either place a new block or click
   **Configure** on an existing one.
2. Scroll to the **Visibility** section of the block configuration form. You'll
   see a new **Views Condition** tab alongside the usual *Pages*, *Content
   types* and *Roles* tabs.
3. At the top, choose the mode with the radio buttons — apply the block on the
   views/displays you select, or on everything *except* them.
4. Expand the views you care about and tick the specific **displays** where the
   block should appear.
5. **Save block**.

The same **Views Condition** option appears wherever Drupal evaluates
conditions — for example on Layout Builder sections or in Context module
reaction rules — so you can reuse it beyond the block layout screen.

Two things to keep in mind: the condition only matches when a **view** is being
rendered on the route, so on non-view pages it simply does not apply (combine it
with "negate" to mean "everywhere except views"). And a view embedded inside a
node page is identified by the node's route, not the view — so it evaluates
against the node, not the embedded display.
