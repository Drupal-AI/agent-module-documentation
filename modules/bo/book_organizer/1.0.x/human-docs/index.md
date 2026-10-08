# Book Organizer — manual setup guide

**Book Organizer** (`book_organizer`) gives you a Views‑powered, hierarchical
overview for managing core **Book** content. Instead of the default book
administration screens, it shows the book tree in a single manageable interface,
so editors can see a book's structure and organize its pages more easily.

It is an administration/content tool built on top of core Book. It reflects your
existing book content and respects the usual book and node access rules — it does
not grant any access of its own beyond the permission it provides for reaching the
overview. It targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Book).

## How to use it

Once enabled, the module adds an administrative, Views‑powered overview of your
book hierarchy within the book/content administration area. Open it to see the
book tree laid out and organize the pages within it. Because the overview is built
from your book content, it only shows what your book and node permissions already
allow you to see, and the module provides its own permission controlling who may
reach the overview (set roles under **People → Permissions**).
