# State Machine UI — manual setup guide

**State Machine UI** (`state_machine_ui`) adds an administrative interface for the
[State Machine](https://www.drupal.org/project/state_machine) module. State Machine
on its own defines workflows in code and configuration; this module lets site
builders manage those workflow groups, states, and transitions — plus a custom
widget — through the admin UI instead of only in code. In short, it makes State
Machine's workflows configurable from the browser. It depends on State Machine and
targets Drupal 11.1 and newer.

The module provides its own permissions to control who can manage workflows, and it
ships an admin UI rather than a single settings form. At the time of writing it is
an early (alpha) release, so test it before relying on it in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required State Machine module) and enable it.

## How to use it

Once enabled, State Machine UI lets you create and edit workflow groups, their
states, and the transitions between them directly in the admin interface. Grant the
module's permissions to the roles that should manage workflows on the **People →
Permissions** page (`/admin/people/permissions`), then use the workflow-management
screens it adds to build and adjust your State Machine workflows without editing
code or configuration files by hand.
