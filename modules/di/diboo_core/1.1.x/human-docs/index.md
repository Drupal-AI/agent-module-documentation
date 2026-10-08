# Diboo core — manual setup guide

**Diboo core** (`diboo_core`) provides the base functionality for a **Diboo**
installation. Diboo is a collaborative drawing-and-describing game — like a game
of telephone (or Chinese whispers) played with written sentences and drawings.
A chain starts with a phrase; the next contributor draws it; the next describes
the drawing; and so on. When a chain finishes, all its links are published for
everyone to enjoy in chronological order.

This module is the shared foundation the rest of the Diboo ecosystem builds on. It
brings in the supporting pieces — Views, entity helpers, entity link formatting,
tokens, and label changes — and provides the plumbing for the game's core
concepts: **Rooms** (groups of chains with their own rules), **Chains** (sets of
chain links), and **Chain links** (a phrase or image contribution). It also
implements game mechanics such as chain locking (a chain is unavailable to others
while someone is drawing or describing it, with a per-room time limit) and limits
on how many chains can be open at once.

To run an actual game you'll pair Diboo core with the rest of a Diboo setup: at
minimum a Room content type, a Chain content type, two chain-link types, and a
drawing tool such as the **Diboo signature pad** module. The companion **Diboo
kickstart** module can prepare a basic setup for you. Diboo core requires Drupal
11.2+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.

There is **no single configuration form** for this module — it provides the base
building blocks of the Diboo game. Set up your Room, Chain and Chain-link content
types (per-room settings such as the chain time limit live on the Room content),
or let Diboo kickstart scaffold them.

## Where it lives in the admin menu

Diboo core adds no dedicated settings page. You work with it through the content
types and entities it underpins — Rooms, Chains, and Chain links — and their
associated Views.

## How to use it

A minimal Diboo game needs:

- One **Room** content type — a group of chains, open or closed, holding the rules
  for each chain (including the auto-unlock time limit, 100 minutes by default).
- One **Chain** content type — a set of chain links.
- **Two chain-link types**, one for phrases and one for drawings.
- A **drawing tool** — for example the Diboo signature pad module.

Because chains can unlock automatically after a room's time limit, make sure
**cron runs at least as often** as the shortest room time limit you configure.
