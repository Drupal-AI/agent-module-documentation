# Builder Notes — manual setup guide

**Builder Notes** (`builder_notes`) adds a collapsible "Builder Notes" textarea to
a set of configuration-entity edit forms, so site builders can record *why*
something was set up the way it is — why a field exists, why a display is arranged
a certain way, what a content type or role is for. It turns the configuration
itself into a place to leave documentation, instead of a separate wiki or a
hand-off document that drifts out of date.

The note is stored as a third-party setting on the config entity itself, so it
travels with the configuration in exports and deployments — the explanation stays
attached to the thing it explains. It appears in the form's "additional settings"
group on these config forms: entity form and view display edit, field config and
field storage, node type, user role, image style, and responsive image style.

The module is deliberately lightweight: it adds **no routes, permissions,
services or public output**. The notes are only visible to users who can already
reach those admin configuration forms, which means the existing Field UI and
admin permissions are what control access. It is an in-config documentation aid,
not an access-controlled annotation system. It supports Drupal 8 through 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires Field UI).

## Where it lives in the admin menu

Builder Notes has no settings page of its own. Instead, the notes textarea shows
up directly on the config-entity edit forms listed above, inside their
"additional settings" section.

## How to use it

1. Install and enable `builder_notes` (see [Installation](installation/index.md)).
2. Edit one of the supported config entities — for example a field, an entity
   display, a content type, a user role, or an image style.
3. Open the **additional settings** area of that form and fill in the **Builder
   Notes** textarea with your explanation, rationale, TODO, or gotcha.
4. Save. The note is stored with the config entity and will be included when you
   export configuration, so it deploys alongside the setting it describes.
