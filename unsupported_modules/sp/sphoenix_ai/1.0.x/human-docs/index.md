# SPhoenix AI Content Assistant — manual setup guide

**SPhoenix AI Content Assistant** (`sphoenix_ai`) connects your Drupal site to
the SPhoenix AI service and gives editors an AI helper for their content. It can
generate new copy, analyse existing content, and answer questions through a
chatbot-style assistant built into the admin interface — so writers get drafting
and review help without leaving the pages they are already working on.

The module talks to an external AI service, so it does not do anything useful
until you have supplied the SPhoenix AI credentials and connected it. Once the
connection is configured, the generation, analysis and chatbot features become
available to editors. It relies only on Drupal core (`node`, `field`, `user` and
`system`) and ships no third‑party PHP libraries, and it runs on Drupal 10 and
11.

A note on security: the SPhoenix credentials are administrator‑configured, and
the module's authentication routes are careful — they return only a redirect URL
and a status, never the secret itself. Even so, treat the credentials as
secrets: store them in an environment variable (or a Key entity) rather than
pasting them into code or committing them.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

> **Package note:** the module's machine name is `sphoenix_ai`, but the Composer
> package is `drupal/sphoenixai` (no underscore). Use the Composer name shown in
> the Installation guide when you require it.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect the module to the SPhoenix
   AI service with your credentials.

## How to use it

Once the connection is set up, editors work with the assistant from within the
content editing experience: generate a draft, ask the assistant to analyse a
piece of content, or chat with it for help. Access is governed by the module's
own permissions, so grant those to the roles you want to give AI assistance to.
