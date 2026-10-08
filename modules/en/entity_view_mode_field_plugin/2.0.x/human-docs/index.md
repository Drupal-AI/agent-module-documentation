# Entity View Mode Field Plugin — manual setup guide

**Entity View Mode Field Plugin** (`entity_view_mode_field_plugin`) is a small
developer helper that **attaches computed metadata to content entities as
pseudo-fields**. It defines a plugin type whose plugins each compute one value
from an entity, and it ships five of them out of the box: an entity's **bundle**,
its **ID**, its **UUID**, and its **URL alias** (with separate plugins for nodes
and taxonomy terms).

For every content entity type and bundle, the applicable plugins are registered
as extra fields that show up on the *Manage display* screen (hidden by default),
and whenever an entity is loaded each computed value is attached to it as a
property named after the plugin — for example `$node->entity_uuid`. Despite the
project name it does **not** expose the render view mode ("full", "teaser", and so
on).

The module does not render these values into HTML itself. Its intended use is
serialization: the attached properties are meant to be picked up when entities are
serialized, pairing with **RESTful Web Services** and the companion **Entity View
Mode Normalize** module so the metadata travels with API output.

This is a developer-oriented helper with a narrow job. It works across Drupal 8
through 11 and has **no central settings page**, no permissions and no routes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — the plugins register
themselves automatically once the module is enabled.

## How to use it

Once enabled, the shipped plugins appear as extra-field rows on the *Manage
display* form for content types, taxonomy terms, users, paragraphs and (for the
ID plugin) commerce products, and each computed value is attached to loaded
entities as a property. Because the values are designed to travel with serialized
output, the module is most useful when serializing entities over REST — the
companion **Entity View Mode Normalize** module complements it there. To compute
your own value, developers can add a new plugin of the `EntityViewModeFieldPlugin`
type (see the agent docs).
