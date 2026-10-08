# Feature Toggle — manual setup guide

**Feature Toggle** (`feature_toggle`) gives your site named on/off switches —
"feature flags" — that non-developers can flip from an admin screen (or a developer
can flip from Drush or a deploy script). You define a feature once, then gate blocks,
views, routes, Twig output, and custom code on whether that feature is currently
enabled. It is the classic way to ship a half-finished feature "dark", turn it on for
everyone with a single click, and turn it off just as fast if something goes wrong —
all without a deployment or a config change.

Each feature is just a machine name, a label, and an optional description. You manage
them at **Configuration → System → Feature Toggle**, where the whole set is listed
with a checkbox each; ticking or unticking a box and saving flips that feature on or
off. A useful detail: the feature **definitions** are stored in configuration (so
they export and deploy between environments), but the on/off **status** is stored
separately in Drupal's key-value store. That means toggling a feature is *not* a
config change — production and staging can legitimately have the same features in
different states.

The real value is in how many ways you can consume a flag. Feature Toggle ships a
block-visibility **condition**, three **Views access** plugins (feature only,
permission + feature, role + feature), a **route access** requirement, a Twig
function (`feature_toggle_status('name')`), a Drush command, and it even exposes the
list of enabled features to JavaScript via `drupalSettings`. Switching a feature
fires an event and clears matching cache tags, so anything gated on it rebuilds
cleanly.

Two permissions keep it tidy: one for administrators who create and delete features,
and a lighter one for trusted editors who may only flip existing features on and off.
The module has no dependencies beyond Drupal core.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the services, events, and
integration plugins — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define features, flip them on and off,
   the two permissions, and where the status is stored.

## Where it lives in the admin menu

Once enabled, manage your features at **Configuration → System → Feature Toggle**
(`/admin/config/system/feature_toggle`). From there you add features, toggle them on
the list, and edit or delete them. See [Configuration](configuration/index.md) for a
walkthrough.
