# Entity CRUD Alter Status Message — manual setup guide

**Entity CRUD Alter Status Message** (`entity_crud_alter_status_message`) lets you
replace Drupal's default "*X has been created / updated / deleted*" confirmation
messages with your own wording. Instead of the generic system text, you can show a
tailored, on‑brand message whenever an editor creates, updates, or deletes a
specific kind of content.

You set up each custom message by picking an **entity type and bundle**, choosing
the **action** (create, update, or delete) that should trigger it, and typing the
message you want shown. Because it depends on the **Token** module, your messages
can include tokens that resolve against the entity — so the confirmation can quote
the title or other fields of the item that was just saved. Out of the box it covers
three entity types: **nodes, taxonomy terms, and media**.

The module needs configuration to do anything: after enabling it you create your
message rules on its listing page. It provides its own permission, affects only the
status messages shown to editors (no content or access behavior of its own), and
token replacement continues to respect normal data access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the Token
   dependency, and enable the module.
2. [Configuration](configuration/index.md) — create custom create/update/delete
   messages per entity type and bundle.

## Where it lives in the admin menu

After installation, the message listing page — where you add and manage your custom
status messages — is reached under the **System** menu. See
[Configuration](configuration/index.md) for the full walkthrough.
