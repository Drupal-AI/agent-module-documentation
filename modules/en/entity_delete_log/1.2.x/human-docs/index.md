# Entity Delete Log — manual setup guide

**Entity Delete Log** (`entity_delete_log`) keeps an audit trail of deletions.
Every time an entity of a type you have chosen is deleted, the module writes a
row to its own database table recording **who** deleted it, **when**, and **what**
it was — the entity's title, id, type and bundle, its original author, its
created date, and (for revisionable entities) how many revisions it had. Because
the record lives in a separate table, that history survives even though the
entity itself is gone.

This is useful whenever you need accountability or forensics: knowing which
editor removed a node, tracing a taxonomy clean-up, spotting an accidental mass
deletion after a bulk operation, or producing a compliance report. You choose
exactly which content entity types are worth logging (nodes, users, media,
terms, and so on) so you are not flooded with noise.

You review the history on a built-in **Reports** page powered by Views, with
filters for entity type and bundle and columns linking to both the person who
deleted the item and its original author. Two developer hooks let other modules
add fields to a log entry or react after one is written (for example to send a
Slack or email alert on deletion).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choosing which entity types to log
   and where to read the report.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Entity Delete
Log** (`/admin/config/content/entity-delete-log`), which requires the **Administer
site configuration** permission. The report is under **Reports → Entity Delete
Log** (`/admin/reports/entity-delete-log`), which requires the **Access site
reports** permission.

## How to use it

Enable the module, open the settings form, tick the entity types you want to
track, and save. From then on, deletions of those types are recorded
automatically — visit the Reports page to review them. There is nothing to log
until you make a selection: on a fresh install, with nothing ticked, the module
logs nothing.
