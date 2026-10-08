# Localization server — manual setup guide

**Localization server** (`l10n_server`) turns a Drupal site into a full
**translation‑management server**. It's the software behind community translation
portals such as localize.drupal.org: it parses the translatable strings out of
packaged project releases, lets a community of volunteers suggest and vote on
translations, and serves the resulting translation files back out for sites to
consume.

This is not a small "translate my own site" helper — it's a collaboration
platform. You stand it up when you want to host translations for one or more
projects and invite a community to work on them together, the way the Drupal
project hosts translations of core and contrib for dozens of languages. It
supports Drupal 10 and 11 and is an active port of the long‑running Drupal 7
version that still powers localize.drupal.org.

Because it is a platform rather than a drop‑in feature, expect real setup work
after installation: defining the projects whose strings you want to host, choosing
how their source strings are imported (from packaged releases or Gettext sources),
enabling the languages your community will translate into, and configuring the
permissions that decide who can suggest, vote, and approve.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module suite with Composer
   and enable it.

There is no single settings form to walk through field by field — configuration
happens across several admin screens (projects, source connectors, languages, and
permissions) as you build out your translation community. See "How to use it"
below for the shape of that setup.

## How to use it

At a high level, standing up a translation server looks like this:

1. **Enable the languages** your community will translate into, under
   **Configuration → Regional and language → Languages**.
2. **Define the projects** you want to host translations for, and choose how their
   translatable source strings are imported — from packaged project releases or
   from Gettext (`.po`/`.pot`) sources.
3. **Set permissions** so the right people can suggest translations, vote on
   suggestions, and approve the ones that become official.
4. **Let the community translate.** Volunteers work through the localization UI,
   and the server serves the resulting translation files back out for sites to
   download.

Because the exact screens depend on which parts of the suite you enable, follow the
in‑UI labels and the project's own roadmap/documentation on drupal.org as you go.
