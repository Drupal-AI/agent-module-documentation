# ECA Metatag — manual setup guide

**ECA Metatag** (`eca_metatag`) connects the
[ECA](https://www.drupal.org/project/eca) no-code automation framework to the
[Metatag](https://www.drupal.org/project/metatag) module. It adds two ECA actions
that let a model add a meta tag or set a tag's value while an event is being
processed — so your SEO meta tags can be driven by business rules instead of being
hard-coded in configuration.

ECA (Events–Conditions–Actions) lets site builders model behaviour visually,
without writing PHP, and Metatag holds a site's meta tags. Until this module,
changing a tag from a model meant custom code. ECA Metatag supplies two action
plugins that appear directly in ECA's model editor:

- **Metatag: add tag** (`eca_metatag_add_tag`) — adds a meta tag to the current
  metatag context.
- **Metatag: set tag value** (`eca_metatag_set_tag_value`) — sets the value of an
  existing meta tag.

Because they are ECA actions, their inputs accept **ECA tokens**, so a value can
be assembled from the triggering event's entity, from earlier actions in the
model, or from anything else in the token context. That lets you do things like
set a page's meta description from a field, add `robots: noindex` when content is
unpublished, or drive Open Graph tags from a taxonomy term — all visually, in a
model.

Everything is configured inside ECA models: there is no configuration page, no
permissions and no Drush commands of its own.

This guide is written for a **human** building ECA models. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Metatag.

## Where it lives in the admin menu

ECA Metatag adds no admin pages. Its two actions appear inside the **ECA** model
editor (for example the BPMN modeller), where you add them as steps in a model.
Meta tags themselves continue to live in the **Metatag** configuration.

## How to use it

1. Install and enable ECA, Metatag and an ECA modeller (see
   [Installation](installation/index.md)).
2. Create or edit an ECA model and add an **event** where meta tags are being
   assembled — typically an entity event such as entity presave or entity view.
3. Add one of this module's actions to the model: **Metatag: add tag** or
   **Metatag: set tag value**.
4. In the action's value field, type a literal value or reference an **ECA token**
   (for example a field on the event's entity) to compose the value dynamically.

A couple of things to keep in mind:

- The actions operate on the **metatag context of the current request or entity**,
  so they belong in models triggered where meta tags are actually being built.
  Using them in an unrelated event has no visible effect.
- Tag names are Metatag plugin ids — `description`, `og:title`, `robots`, and so
  on. See the [`agent/`](../agent/start.md) docs for a quick way to list the
  available tag ids.
