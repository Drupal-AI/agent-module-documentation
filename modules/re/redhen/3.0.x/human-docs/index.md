# RedHen CRM — manual setup guide

**RedHen CRM** (`redhen`) is a constituent-relationship-management system built
*as Drupal* rather than bolted onto it. Contacts, organisations, and the
relationships between them are ordinary Drupal entities, which means they have
fields, view modes, Views integration, entity access, and revisions like any
other content — and a developer already fluent in Drupal does not have to learn a
second system. It was created and is maintained by ThinkShout, originally for the
CRM needs of nonprofits, membership organisations, and associations.

Like Drupal Commerce, RedHen is modular: the base `redhen` module provides the
shared APIs, and the actual functionality lives in submodules you enable as
needed — **Contact** (`redhen_contact`) and **Organization** (`redhen_org`) are
the core entities, **Connection** (`redhen_connection`) models fieldable
relationships between two CRM objects, and **Dedupe** (`redhen_dedupe`) provides a
find-and-merge interface for the duplicate contacts every CRM accumulates.
Because they are Drupal entities, you customise them the same way you customise
anything in Drupal: the same field UI, the same Views, the same permissions.

Two things are worth saying plainly before you build on it. First, this release is
**3.0.0-alpha1 — an alpha**, so treat it accordingly. Second, and more important,
**a CRM holds the most sensitive data a small organisation has**: names,
addresses, relationships, correspondence, often giving history. That has two
consequences you should design for from the outset rather than retrofit —
**entity access must be deliberately designed** ("authenticated users can view"
is the wrong default for a record holding a supporter's home address), and the
data carries a **retention obligation**, so deletion and anonymisation should
exist *before* your first import, not after your first data-subject request.

RedHen represents an architectural choice. The alternative for many organisations
is **CiviCRM** — a full CRM with its own data model, its own upgrade cycle, and a
large built-in feature set (fundraising, membership lifecycle, event
registration, reporting), installed alongside Drupal or reached over an API.
RedHen's composability is what you gain; everything a mature CRM ships that RedHen
does not is what you give up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the RedHen settings form and where
   the real modelling work (contact types, organisation types, connections)
   happens.

## Where it lives in the admin menu

The base module's settings form is at `redhen.config`. Once the submodules are
enabled, RedHen's day-to-day admin — managing contacts, organisations,
connections, and their types and fields — appears under the site's structure and
content administration, and RedHen's permissions are on **People →
Permissions**.

## A note on getting a working CRM

As with Commerce, enabling the RedHen modules does **not** hand you a finished CRM.
They require configuration and customisation for your organisation: you define the
contact and organisation types, add the fields you need, decide how contacts
connect to Drupal users, and design who can see and edit what. Plan that work
before you begin importing real data.
