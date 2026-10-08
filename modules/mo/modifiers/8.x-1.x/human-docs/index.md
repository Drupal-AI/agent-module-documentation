# Modifiers — manual setup guide

**Modifiers** (`modifiers`) is a framework for applying consistent presentation
adjustments — background, spacing, colour, animation, and the like — to elements
on a page, without editors ever touching CSS. It defines a **plugin type**: each
"modifier" is a declared, discoverable thing with its own configuration and its
own rendering, so the available set of visual options is a developer-managed
vocabulary while the choice of which to apply is an editorial one.

The power of Modifiers is that a modifier is applied to elements identified by a
**selector**. That means the same system can style entities (nodes, blocks,
paragraphs, users), theme regions (header, footer), view modes (full, teaser),
WYSIWYG classes, and more. Under the hood it provides a Modifier interface and
plugin manager, an internal system that turns field content into the configuration
for a modifier instance, and a hook into entity rendering that attaches modifiers
to entities. It is maintained by Morpht, has no dependencies, and runs on Drupal
10.2, 11, and 12 — it is a foundation other modules and themes build on.

Two consequences are worth understanding before you build with it:

- **Modifier values are stored on the entity, so they are content.** They export
  with a migration and appear in revisions — and a modifier that is later removed
  or renamed leaves entities referring to something that no longer exists. Plan
  modifier changes the way you would plan any content-model change.
- **Presentation vocabularies grow unless someone owns them.** The whole benefit
  over a free-text CSS-class field is that the options are finite and named. The
  moment "just add one more modifier" becomes routine, the module has quietly
  become the free-text field with extra steps. Keep the set curated.

Modifiers is a framework rather than a turnkey feature. On its own it defines the
system; you get ready-made modifiers from companion projects — **Modifiers Pack**
provides a broad set of practical modifiers (colours, backgrounds, gradients,
corners, shadows, parallax, and more), and **Look** manages collections of
modifiers applied per page. There is no settings form; setup is a developer/site-
builder activity, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for the base module — it is a framework. You
expose options by enabling modifier plugins (such as those in Modifiers Pack) and
attaching them to entities, as described in "How to use it" below.

## Where it lives in the admin menu

The base Modifiers module adds no central settings page. In practice you work with
it where the modifier field lives — on the **entities, blocks, or paragraphs** you
attach a modifiers field to (via **Structure → … → Manage fields**), and through
the companion modules that supply and organise the modifier plugins.

## How to use it

1. Install and enable Modifiers (see [Installation](installation/index.md)).
2. Install a source of modifier plugins — most commonly
   [Modifiers Pack](https://www.drupal.org/project/modifiers_pack) — and enable
   only the specific modifier submodules whose options you want to expose.
3. Add a modifiers field to the entity, block, or paragraph type you want to be
   able to style, so editors can pick modifiers on that content.
4. Optionally add [Look](https://www.drupal.org/project/look) to manage
   collections of modifiers and apply them per page.
5. As an editor, choose the modifier(s) and their settings on your content; the
   framework converts those values into the configuration for each modifier and
   attaches the resulting styling at render time.

For building your own modifier, see the project's developer documentation linked
from its [project page](https://www.drupal.org/project/modifiers).
