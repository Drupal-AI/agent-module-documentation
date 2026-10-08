# AEO Multilingual — manual setup guide

**AEO Multilingual** (`aeo_multilingual`) helps a multilingual Drupal site be
better understood by search engines and by AI "answer engines" — the systems
behind AI-generated answers. This is search engine optimization (SEO) with an
extra focus on Answer Engine Optimization (AEO): it improves how your translated
content presents itself across languages, using signals such as `hreflang` and
other language hints so the right language version is surfaced to the right
audience.

It builds directly on Drupal's multilingual stack, so it depends on the core
**Language**, **Content Translation**, and **Node** modules. It works with content
you have already translated and does not change who can see that content —
translation access is still governed by core. The module does provide its own
permissions to control who can administer its behaviour.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on these docs:** the available reference material for this module is
> brief. This page describes what the module is for and how to install it; the
> exact settings screens are not documented here. After enabling it, review the
> permissions it adds (under **People → Permissions**) and look for its options in
> the admin menu.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the core multilingual modules.

## How to use it

AEO Multilingual is meant for a site that is already multilingual — with the core
Language and Content Translation modules configured and content translated into
your languages. Once those pieces are in place and this module is enabled, it
works to improve how those translations are presented to search and answer
engines. Assign its permissions to the roles that should manage its behaviour,
then confirm your translated pages emit the expected language signals.
