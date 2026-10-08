# Auto entity form mode — manual setup guide

**Auto entity form mode** (`auto_entity_form_mode`) automatically registers
entity **form modes** so they are available to custom code without manual
registration. It is a small developer utility that makes programmatic use of
alternate entity edit forms more reliable.

Form modes let you define more than one edit form for an entity type — for
example a slimmed-down form for a particular workflow. Using them from custom
code normally means registering each mode by hand. This module registers them
automatically, so the form modes defined on your site can be referenced from code
and modules without that extra step.

This is a developer / Entity API feature. It only registers form modes; it has no
content or access role of its own. It supports a wide range of core versions —
Drupal 8.8, 9, 10, and 11.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure. Enable the module and the entity form modes
defined on your site are registered automatically, ready to be referenced from
custom code and other modules that work with alternate edit forms.
