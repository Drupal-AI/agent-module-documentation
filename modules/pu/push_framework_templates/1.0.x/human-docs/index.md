# Push Framework Templates — manual setup guide

**Push Framework Templates** (`push_framework_templates`) adds a content-aware
templating system to Push Framework. Where Push Framework handles *delivery* across
channels (email, SMS, web push, and so on), this module controls *what the
notifications actually say* — based on the content that triggered them, using
context supplied by the **DANSE** module. Instead of hard-coding notification text,
you build reusable templates with tokens.

Each template has a **Title** (a human-readable name for the admin list), an
**Event key** (the lookup key that decides when the template is used), a
**Subject** and **Body** (the notification text, with token support), and optional
**per-channel overrides** so a short mobile push and a longer email can differ from
the same template. Templates resolve from most-specific to least-specific by event
key, so a generic template acts as a catch-all fallback unless a more specific one
exists.

It depends on **DANSE** (`danse`) and **Push Framework** (`push_framework`), and
runs on Drupal `^10 || ^11`. Its project page also notes a **patch** to Push
Framework may be required — check the
[project page](https://www.drupal.org/project/push_framework_templates) before
relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside DANSE and Push Framework.

There is no traditional "settings" form to document separately — the module is used
by **creating and managing templates**, which is described in "How to use it"
below.

## Where it lives in the admin menu

Templates are managed at **Administration → Configuration → Push Framework
Templates** (`/admin/config/push-framework-templates`).

## How to use it

### Create a template

1. Go to **Configuration → Push Framework Templates**
   (`/admin/config/push-framework-templates`) and add a template.
2. Fill in the fields:
   - **Title** — a human-readable name for the admin list.
   - **Event key** — the lookup key that determines when this template is used
     (see resolution order below).
   - **Subject** and **Body** — the notification text, with token support.
   - **Per-channel overrides** — optional subject/body for specific channels. The
     override section lists every currently enabled channel plugin, so you can opt
     in to custom text per channel; if no override is set for the active channel,
     the default subject and body are used.

### Event keys and template resolution

The event key determines how specific a template is. When a notification is
dispatched, the module looks for a matching template in this order and uses the
first match it finds:

1. `{entity_type}__{bundle}__{topic}` — most specific
2. `{entity_type}__{topic}`
3. `{topic}` — least specific (catch-all)

For example, when a new **article** node is created, the lookup order is
`node__article__create`, then `node__create`, then `create`. A generic `create`
template therefore acts as a fallback for all content types unless a more specific
one is defined.

### Supported tokens

Templates support standard Drupal tokens plus these provided by the module:

| Token | Description |
|-------|-------------|
| `[user:display-name]` | The notification recipient's display name |
| `[push-object:label]` | The entity label (title) |
| `[push-object:type-label]` | The human-readable bundle name |
| `[push-object:author]` | The display name of the entity author |
| `[push-object:url]` | The canonical URL of the entity |
| `[push-object:parent-label]` | The parent entity label (for comments) |
| `[push-object:parent-url]` | The parent entity URL (for comments) |
| `[site:name]` | The site name |

If the [Token](https://www.drupal.org/project/token) module is installed, a token
browser is available directly in the template form.

### Per-channel overrides

Different channels have different formatting needs — a mobile push may need a much
shorter subject than an email. Each template can carry a separate subject and body
per channel, so you can tailor the wording without creating a whole new template.
