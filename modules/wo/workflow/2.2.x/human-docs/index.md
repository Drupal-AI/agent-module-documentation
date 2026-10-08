# Workflow — manual setup guide

**Workflow** (`workflow`) lets you attach a customizable **state machine** to your
content. You define a *workflow* — a set of **states** (for example Draft → Needs Review
→ Published) and the **transitions** allowed between them — and then add a **Workflow
state** field to a content type or any other entity. From then on, editors move content
between states using a widget on the edit form or a block, and every change is recorded
in a full, timestamped history with the author and an optional comment.

What makes Workflow flexible is that transitions are restricted **per role**. You decide
which roles may move content from one particular state to another, so an Author might be
able to send content to *Needs Review* while only an Editor can move it to *Published*.
Each workflow you create also generates its own set of permissions (participate,
schedule, view history, revert, bypass) that you grant to roles.

Beyond the basics, Workflow supports **scheduled transitions** (auto-publish at a future
date via cron), a transition **block**, **Actions** for changing state in bulk (for
example from a View), Views integration for filtering by state, and hooks/events so
developers can run business logic on each change. Six submodules extend it further — most
notably **Workflow Access**, which controls node access based on the current state.

This is the classic Workflow field module. If you're looking for Drupal core's built-in
editorial moderation instead, that's the separate Content Moderation module — Workflow is
an older, field-based, highly customizable alternative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and pick the submodules you need.
2. [Configuration](configuration/index.md) — create a workflow with its states and
   transitions, attach the Workflow state field, configure the widget, and grant
   permissions.

## Where it lives in the admin menu

Workflows are managed at **Configuration → Workflow → Workflow**
(`/admin/config/workflow/workflow`), behind the **Administer workflow** permission. You
attach a workflow to content from the usual **Manage fields** screens on a content type
or other entity bundle.

## How to use it

1. Create a workflow and define its states and per-role transitions (see
   [Configuration](configuration/index.md)).
2. Add a **Workflow state** field to the content type you want to govern, binding it to
   that workflow.
3. Grant the relevant per-workflow permissions to your roles so they can participate.
4. Editors then change the state of a piece of content from its edit form (or a block),
   and the transition history builds up automatically.
