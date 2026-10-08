# Entity Type Behaviors — manual setup guide

**Entity Type Behaviors** (`entity_type_behaviors`) brings the "behavior plugin"
idea that Paragraphs users know and love to *any* fieldable entity type — nodes,
media, taxonomy terms, users, or your own custom entities. A behavior is a small,
reusable bundle of display logic: a developer writes it once, a site builder
switches it on for the bundles that need it, an editor fills in the values while
creating content, and those values then quietly reshape how the entity renders on
the page.

Think of things like a "background color" picker, a "spacing / padding" control,
or an "image position" toggle — options that used to require a one-off field or a
custom preprocess hook for each content type. With this module you package that
option as a single `EntityTypeBehavior` plugin and reuse it everywhere. Each
behavior exposes two forms: a **config** form (shown once per bundle, for the site
builder, to restrict or parameterize the behavior) and a **values** form (shown on
every entity, for the editor). The stored values are then read back at render time
and used to alter the entity's render array.

This is a **developer framework**, not a point-and-click feature. It adds no admin
settings page of its own, defines no permissions, and ships no Drush commands.
Behaviors are turned on from the bundle edit form, and the values widget is placed
via *Manage form display* like any other field. It depends only on Drupal core and
supports Drupal 8.8 through 11. A bundled example submodule and optional GraphQL
Compose integration round it out.

This guide is written for a **human** setting the module up through the UI and for
developers writing their first behavior. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead
— they cover the plugin API, storage internals, and hook cascade in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

## Where it lives in the admin menu

There is **no dedicated settings page**. Once the module is enabled, everything
happens in two familiar places:

- **The bundle edit form** (for example *Structure → Content types → Article →
  Edit*). If any behavior plugin targets that entity type, an **Additional
  settings → Behaviors** section appears. Tick *Enable behaviors on this entity
  type*, choose which behaviors to switch on, fill in each behavior's config form,
  and save. Export your configuration afterward — the config file is the source of
  truth.
- **Manage form display** (for example *Structure → Content types → Article →
  Manage form display*). Enabling behaviors adds a dynamic `behaviors` base field
  to the entity type; place its widget on the form so editors can enter values.
  The widget renders each enabled behavior's form inside its own collapsible
  section.

## How to use it

**For site builders.** Install a module that provides behaviors (or the bundled
`entity_type_behaviors_example`), open the bundle you want to enhance, enable the
behaviors under *Additional settings → Behaviors*, and place the `behaviors`
widget on *Manage form display*. Editors will then see the behavior fields when
they create or edit that content, and the values take effect when the entity is
displayed.

**For developers.** Create an `EntityTypeBehavior` plugin under
`src/Plugin/EntityTypeBehavior/` in your own module. Implement `getForm()` for the
per-entity editor form and, optionally, `getConfigForm()` for the per-bundle site
builder form. Read the stored values back at render time in one of two ways —
either the plugin's own `view()` method, or a `hook_entity_type_behaviors_alter__…`
implementation (there is a cascade from most general to most specific: by behavior,
by behavior + entity type, and by behavior + entity type + bundle, and each also
works as a theme function). A minimal plugin skeleton and the full hook list are in
the [`agent/`](../agent/start.md) docs, and the shipped
`entity_type_behaviors_example` submodule is the fastest way to see a working
behavior — including a config form that restricts which colors an editor may pick.

Common things people build with it:

- A background-color or CSS-class control on any entity type.
- Configurable margins/padding on a node or media bundle, no custom field type.
- An image-positioning toggle stored per entity and applied via a hook.
- Reusable, shareable display-behavior packages distributed as small modules.
- Behavior values exposed through GraphQL via the optional GraphQL Compose plugins.

Stored values live in a revisionable, translatable `behaviors` base field, and the
per-bundle configuration exports as normal Drupal config
(`entity_type_behaviors.entity_type_bundle.*`), so everything moves cleanly between
environments.
