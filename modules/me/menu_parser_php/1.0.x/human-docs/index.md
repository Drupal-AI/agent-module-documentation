# Decoupled Menu Parser PHP — manual setup guide

**Decoupled Menu Parser PHP** (`menu_parser_php`) is a small developer utility
that reads the *linkset* format Drupal's Decoupled Menus feature exposes and turns
it into a structured PHP data model that server-side code can easily walk, process,
and render. If you are building a decoupled or partly decoupled site and you need
your Drupal (or other PHP) back end to consume a menu that is served as a linkset,
this module gives you a ready-made PHP parser for that job.

It is intended as a PHP alternative to the `decoupled_menu_parser` project. It does
not execute code and it has no editorial or front-end features of its own — it
simply parses linkset data into elements you can work with. Because of that, there
is nothing to configure and no admin screen: you enable it and then call its API
from your own code. It works on Drupal 9, 10, and 11 and has no dependencies beyond
Drupal core.

This is a module for developers, not content editors. If you are looking for a way
to *display* a menu, this is not it — this is the plumbing that helps your code
understand a decoupled menu's data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It exposes a PHP parser for
developers to call; it has no settings form and adds nothing to the admin menu.

## How to use it

Once enabled, the module provides its parser to your custom code. Point it at a
linkset produced by Drupal's Decoupled Menus feature and it returns a normalised,
structured representation of the menu that your PHP can iterate over and render.
The specifics of the API belong in the project's own developer documentation on
[drupal.org](https://www.drupal.org/project/menu_parser_php); this module's role is
purely to be that parsing library.
