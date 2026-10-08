# State Machine Automated Transition — manual setup guide

**State Machine Automated Transition** (`state_machine_automated_transition`)
automatically applies [State Machine](https://www.drupal.org/project/state_machine)
transitions, moving an entity between workflow states without anyone clicking a
button. Typical uses are time- or condition-based changes such as auto-publishing
content after a date or auto-archiving it after a period. It builds directly on
the State Machine module and cannot work without it.

The automated transitions it applies still go through State Machine's own machinery
— the configured transitions and their guards are respected, so automation cannot
push an entity into a state that State Machine itself would forbid. The module has
no access-control role of its own; it is a workflow-automation helper.

At the time of this writing the module is an early (alpha) release, so treat it as
maturing and test your workflows before relying on it in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required State Machine module) and enable it.

## How to use it

The module has no configuration page of its own. It works together with State
Machine: you define your workflow, states, and transitions with State Machine as
usual, and this module drives the eligible transitions automatically based on
time/condition criteria. Because it respects State Machine's guards, an automated
transition only fires where the workflow itself allows it.
