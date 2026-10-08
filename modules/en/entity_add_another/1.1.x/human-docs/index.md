# Entity Add Another — manual setup guide

**Entity Add Another** (`entity_add_another`) adds a **"Save and Add Another"**
button to entity creation forms. When an editor is creating a batch of similar
items — several events, a run of products, a list of team members — they normally
have to save, then navigate back to the add form for each one. With this button
enabled, saving returns the editor straight to a fresh, empty add form for the same
entity type, so they can keep going without the round trip.

It works across **any** content entity type, which is what sets it apart from some
older "add another" helpers that only supported nodes. You decide exactly where the
button appears: after installing, a settings page lets you pick which entity types
and bundles should include it on their creation forms.

The module is a content-editing/workflow convenience only. Creating entities is
still governed by Drupal's normal *create* access, and the module adds no
access-control behaviour of its own beyond a permission to use the button and a
permission to administer its settings. It has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types and bundles
   show the "Save and Add Another" button, and set the permissions.

## Where it lives in the admin menu

Once enabled, the settings live at **Configuration → Content authoring → Entity Add
Another** (`/admin/config/content/entity_add_another`).
