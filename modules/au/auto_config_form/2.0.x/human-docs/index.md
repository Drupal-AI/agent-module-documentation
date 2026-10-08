# Auto Config Form — manual setup guide

**Auto Config Form** (`auto_config_form`) is a developer tool that **generates a
custom module's configuration form automatically from its config schema**.
Instead of hand-writing a settings form for every module you build, you let this
module build the admin config form for you from the schema you have already
defined.

Defining a module's settings twice — once as a config schema and again as a form
with matching fields — is repetitive and easy to get out of step. Auto Config
Form removes the second copy: it reads the schema and produces an admin-gated
configuration form that matches it, so a module's settings page follows its
schema automatically.

This is a developer / site-building aid. The forms it generates are ordinary
admin-gated config forms, and the module has no content or access role of its
own. It targets Drupal 11.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Auto Config Form is used by developers as scaffolding: define your module's
config schema as usual, then use Auto Config Form to generate the matching
settings form rather than writing the form class by hand. There is no site-wide
settings page to fill in — the value is in what it generates for the modules you
build. Because the generated forms are admin-gated config forms, they are
reached and protected exactly like any other module's settings page.
