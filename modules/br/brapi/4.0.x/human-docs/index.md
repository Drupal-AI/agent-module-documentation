# Plant Breeding API — manual setup guide

**Plant Breeding API** (`brapi`) is a BrAPI server implementation for Drupal.
BrAPI — the Breeding API — is a standardized REST specification used across
agricultural research so that breeding databases and tools can exchange data in a
common format. This module turns a Drupal site into one of those data sources: it
exposes plant-breeding data such as germplasm, studies, and observations through
the BrAPI endpoints, so other breeding systems and tools can read (and, with the
right permissions, edit) it.

A few landing pages are public by design — the BrAPI landing page (`/brapi`), its
documentation (`/brapi/doc`), and the token page (`/brapi/token`). Actual data
access, though, uses BrAPI **token authentication** together with Drupal
permissions, so you decide which data types are readable or editable and by whom.

This is a substantial integration module (currently a 4.0.x beta) that supports
Drupal 9, 10, and 11 and depends on core's Datetime module.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (core Datetime),
   installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — permissions, token authentication,
   and configuring which data types are exposed.

## Where it lives in the admin menu

The public-facing pages sit at `/brapi`, `/brapi/doc`, and `/brapi/token`.
Administration is governed by the module's permissions — `use brapi`,
`edit brapi content`, and `administer brapi` — with the `administer brapi`
permission controlling the setup of the server and its data-type access.

## How to use it

Enable the module, then decide which breeding data types you want to expose and
configure their access. Grant the BrAPI permissions to the appropriate roles:
`use brapi` for consuming data, `edit brapi content` for writing, and
`administer brapi` for setup. Consumers authenticate with a BrAPI token (obtained
via the token page) and then call the standard BrAPI endpoints to read your
germplasm, studies, and observation data. Because the landing, documentation, and
token pages are public, treat only the token-authenticated data endpoints as the
place where access control matters — and configure that access deliberately.
