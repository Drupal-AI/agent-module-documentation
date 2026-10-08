# Realistic Dummy Content — manual setup guide

**Realistic Dummy Content** (`realistic_dummy_content`) makes generated demo
content look like *real* content. It plugs into Devel's **Devel Generate** so that,
instead of grey placeholder boxes and `Bfjkl Qwerty` gibberish, your generated
users get real portrait photos and your generated articles get proper stock
photography and plausible text.

That difference matters more than it sounds. A design reviewed against nonsense
text and a grey rectangle is a design nobody has really seen: real headlines run
longer than the mock, real photos are the wrong aspect ratio, real names break the
column — and all of that gets discovered after launch. Generating plausible
content instead surfaces those problems while they're still cheap to fix, and it
makes a stakeholder demo persuasive: people are looking at the product rather than
being asked to imagine it. Because the source images and text come from a
directory you can supply per project, the content can resemble *this* site's
subject rather than generic filler.

The project ships two modules. **Realistic Dummy Content API**
(`realistic_dummy_content_api`) is the engine: it scans every enabled module for a
`realistic_dummy_content/` directory and uses whatever images and text it finds
there to replace dummy values. **Realistic Dummy Content**
(`realistic_dummy_content`, the main module) is a ready‑made set of freely licensed
portraits and stock photos built on that engine. If you'd rather supply only your
own content, you can enable just the API module alongside your own module's
`realistic_dummy_content/` directory.

> **Development only.** This is a developer tool — its own project explicitly says
> **"Do not enable on production sites."** A content generator on a live site is
> one mistaken command away from thousands of entities that then have to be found
> and removed. Keep it in your **`require-dev`** dependencies so it can't be
> enabled where it doesn't belong, and have a plan for removing whatever you
> generate. This 4.0.x release is a **beta** (`4.0.0-beta1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (as a dev
   dependency) with Composer and enable it alongside Devel Generate.

There is **no configuration page** for this module — it has no settings form. You
drive it through Devel Generate, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You generate content through Devel's
tools at **Configuration → Development → Generate** (from the **Devel Generate**
module) or with the `drush` generate commands.

## How to use it

1. Enable this module and Devel's **Devel Generate** module
   ([Installation](installation/index.md)).
2. Generate content as usual — for example via **Configuration → Development →
   Generate → Generate content / Generate users**, or with
   `drush devel:generate-content` / `drush devel:generate-users`. Generated users
   now get portrait photos and generated articles get stock photos and plausible
   text instead of placeholders.
3. To supply your own images and text, reproduce the
   `realistic_dummy_content/realistic_dummy_content/` directory structure inside
   your own custom module (see the project's README for the naming scheme —
   subfolders per entity type, bundle, and field, with optional metadata files for
   things like image alt text and body text formats).

The project also supports "recipes" for generating a set number of entities in a
specific sequence, run with `drush generate-realistic`; see the recipe README in
the module for details.
