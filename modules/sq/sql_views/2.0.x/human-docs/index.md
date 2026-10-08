# SQL Views — manual setup guide

**SQL Views** (`sql_views`) is an API module that lets you integrate native
database **SQL VIEWs** into Drupal. A SQL view is a saved query that the database
presents as if it were a table; this module bridges those views into the Drupal
layer so their data can be read and used from within your site — for example as a
data source for reporting or for further integration work.

Because it is an API/developer module, there is no settings screen and nothing to
click through. You enable it, then use its API from your own code (or from modules
built on top of it) to work with the database views you have defined. It depends
only on core **System**, provides its own permissions, and targets Drupal 11.2 and
later. Note the module is minimally maintained and in maintenance‑fixes‑only mode.

This guide is written for a **human** installing the module. Since SQL Views is a
developer‑facing API with no configuration UI, the day‑to‑day details live in the
code and in the linked guide about SQL Views in Drupal on the project page. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.

## How to use it

Once enabled, SQL Views exposes native database VIEWs to Drupal so their rows can
be read and used in code. There is no admin form — you work with the module
through its API. See the "SQL Views in Drupal" guide linked from the project page
for the integration details.
