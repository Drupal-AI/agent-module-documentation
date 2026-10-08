# FlowDrop Node Session — manual setup guide

**FlowDrop Node Session** (`flowdrop_node_session`) adds entity‑context support to
**FlowDrop** playground sessions. It lets you start a workflow session pre‑loaded with
a specific Drupal entity — a node, a taxonomy term, or any other content entity — so a
FlowDrop AI workflow can operate against a real piece of content instead of an empty
canvas. It can optionally load a specific entity **revision**, and it can launch the
playground straight from a URL.

Inside the FlowDrop editor you add an **EntityContext** node, which outputs the full
serialized entity plus its `entity_type`, `entity_id`, `bundle`, `revision_id`, and an
`is_default_revision` flag for the rest of the workflow to use. You then open the
playground for that entity by visiting a URL with query parameters — for example
`/admin/flowdrop/workflows/{workflow_id}/playground/entity?entity_type=node&entity_id=1`
— optionally adding `bundle`, `revision_id`, or `session_name`. For developers there
is also a REST endpoint and a service (`flowdrop_node_session.service`) for creating
entity‑context sessions programmatically.

This is an integration/developer feature with **no settings page of its own**; its
behaviour is driven by the EntityContext node in your workflow and by the URL or API
call you use to launch a session.

> **A note on status.** This release is an early (alpha) version and is **not covered
> by Drupal's security advisory policy**. Treat it accordingly — keep it to trusted
> users and test before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its FlowDrop dependencies.

There is **no configuration page** for this module. You use it through the
EntityContext node in the [FlowDrop](https://www.drupal.org/project/flowdrop) editor
and by launching the playground with entity parameters — see [How to use it](#how-to-use-it).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In the FlowDrop editor, add an **EntityContext** node to your workflow. It outputs
   the full entity plus its type, id, bundle, revision id, and default‑revision flag.
3. Launch the playground with an entity by visiting
   `/admin/flowdrop/workflows/{workflow_id}/playground/entity?entity_type=node&entity_id=1`,
   optionally adding `bundle`, `revision_id`, or `session_name` query parameters.
4. The session opens pre‑loaded with that entity's data, ready for the rest of the
   workflow to act on.
