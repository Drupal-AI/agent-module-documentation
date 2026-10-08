# Group Node Request — manual setup guide

**Group Node Request** (`gnode_request`) lets users **request to add a node to a
Group** rather than adding it directly. Instead of publishing content straight into
a group, a user submits a *request*, and a group manager approves or rejects it
through a moderation workflow. On acceptance, the node becomes Group Node content.

It works much like the *Group Membership Request* pattern does for people joining a
group — but for content. That makes it a good fit when a group wants editorial
control over what gets added: proposed content sits in a pending state, group
managers review it, and only approved items land in the group. The approve/reject
lifecycle is driven by the **State Machine** module.

This module builds directly on the **Group** and **Group Node** (`gnode`) modules,
so you need a working Group setup first. Note that it is a young module developed
around a specific production use case (currently a 3.0.x alpha) — evaluate it
against your own needs before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Group /
   State Machine dependencies with Composer, and enable it.

There is **no central settings page** for this module. It works through the Group
module's own configuration — you enable the request behaviour on the group types
where you want it, and the request/approval workflow then appears on those groups.

## How to use it

1. Make sure you have a working **Group** setup with the **Group Node** (`gnode`)
   plugin in use for the content you want to moderate.
2. On the relevant **group type**, enable the Group Node Request behaviour and
   grant the appropriate group permissions — who may *request* to add a node, and
   who may *approve or reject* those requests (the group managers).
3. Users then submit requests to add nodes to a group; group managers act on them
   through the state-machine workflow, and approved nodes become Group Node content.
