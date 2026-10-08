# Riddle Marketplace — manual setup guide

**Riddle Marketplace** (`riddle_marketplace`) integrates Drupal with
[Riddle](https://www.riddle.com/) — a platform for building quizzes, polls, tests,
lists, and other interactive content. The module lets you **import** the riddles
you have created on riddle.com into Drupal and **display** them as native Drupal
**media**, so editors can drop an interactive quiz or poll into content the same
way they add any other media item.

Its main pieces are:

- A **Riddle media entity** (provided together with the bundled
  `media_riddle_marketplace` submodule) so riddles live in Drupal's media system.
- An **import** flow that pulls your riddles in from riddle.com over the Riddle API
  (this version targets Riddle API v3).
- A **CKEditor embed button**, so editors can insert a riddle directly while
  writing in the rich-text editor.

Two things to keep in mind. First, the module authenticates to the **Riddle API
with a token/credentials**, which are secrets — store them in an environment
variable and, ideally, a Key entity rather than pasting them into config that ends
up in Git. Second, the interactive content itself is **hosted and served by
Riddle**: it is a third-party embed, and participant responses are processed by
Riddle, which is a privacy consideration to weigh (and to disclose) depending on
your audience and jurisdiction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its media submodule.
2. [Configuration](configuration/index.md) — enter your Riddle API credentials,
   grant permissions, and import your first riddle.

## Where it lives in the admin menu

Riddles become entries in your **media library** (Content → Media). The module's
own settings — where you enter the Riddle API credentials and manage the
integration — are gated by the module's permission and covered in the
[Configuration](configuration/index.md) guide. Once configured, editors embed
riddles through the media library or the CKEditor embed button while writing
content.
