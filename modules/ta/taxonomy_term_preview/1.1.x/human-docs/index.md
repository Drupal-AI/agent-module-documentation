# Taxonomy Term Preview — manual setup guide

**Taxonomy Term Preview** (`taxonomy_term_preview`) adds a **Preview** button to
the taxonomy term edit form, giving editors the same "see it before you save it"
experience that content nodes already have. When you are editing a term — its
name, description, or any custom fields you have added to the vocabulary — you can
click Preview and see how the term page will render, then go back and adjust
before committing the change.

The preview respects the term's normal access and rendering, so what you see is
what a visitor would see; the module plays no access‑control role of its own. It
depends only on core's **Taxonomy** module and works the moment you enable it —
there is nothing to configure.

One thing to know before you install: this module **replaces the default form
class** used for taxonomy terms. That means it is **not compatible with other
modules that do the same thing** to the term form. If you already run a module
that swaps out the taxonomy term form (or you later want a broader preview tool),
consider the [All Entity Preview](https://www.drupal.org/project/all_entity_preview)
project as an alternative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled there is no setup. Go to **Structure → Taxonomy**,
choose a vocabulary, and add or edit a term. The term form now shows a **Preview**
button alongside **Save**. Click it to render the term as it will appear, review
it, then return to the form to save or keep editing.
