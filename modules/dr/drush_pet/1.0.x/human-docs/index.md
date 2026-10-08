# Potx Extract Translations (PET) — manual setup guide

**Potx Extract Translations (PET)** (`drush_pet`) adds a Drush command that
extracts translatable strings from your Drupal code and writes them out as PO
translation files, project by project. It builds on the
[POTX](https://www.drupal.org/project/potx) (Translation Template Extractor)
engine and gives module, theme and profile developers a fast, repeatable way to
generate up-to-date translation templates from source code on the command line —
no clicking through UI tools.

The typical use case is a developer who is adding or updating translatable text
in a custom module or theme and wants to regenerate the `.pot`/`.po` files
without leaving the terminal. It supports both single-project extraction and bulk
workflows across many projects at once.

Because it only adds a Drush command, this module is meant for **development
environments** — there is no reason to leave it enabled on production. It depends
on the POTX module, and this `1.0.x` release supports Drupal 10.5+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on versions:** this is the **1.0.x** line. A newer **1.1.x** release
> renames and documents the command in more detail (`potx:extract-translations`,
> alias `pet`) and targets Drupal 11.3+/12. If you are on newer core, see that
> version's guide.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure POTX is present.

There is **no configuration page** for this module — it ships no settings form.
It is used entirely through its Drush command.

## How to use it

PET adds no admin page. After enabling it, run its `pet` command from the command
line to export translations for your project(s). Because it works file by file
through POTX, it can target a single module/theme/profile or extract across a
whole set of custom projects at once. Run `drush help pet` for the exact
arguments and options available in your installed version.
