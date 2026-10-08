# Bootstrap Horizontal Tabs — manual setup guide

**Bootstrap Horizontal Tabs** (`bootstrap_horizontal_tabs`) gives you a **field
type** whose values display as a set of Bootstrap **nav tabs** (or **pills**).
Each value in the field is one tab: a plain-text **label** plus a rich-text
**body**. On display, the labels become the tab strip and the bodies become the
matching tab panes — a clean way to build things like a product page's
*Description / Specs / Reviews* tabs, a step-by-step "how it works" section, or a
tabbed FAQ, all edited as ordinary content.

Because it's a normal Field API field, you add it to any content type (or other
entity) through **Manage fields**, give it multiple values so editors can add as
many tabs as they like, and pick how it renders — tabs vs pills, laid out
horizontally or stacked vertically — per view mode. The generated markup is
properly accessible (ARIA `tablist` / `tab` / `tabpanel` roles, `aria-selected`,
a sensible default active tab) and supports **deep linking**: a link ending in a
tab's anchor opens the page with that tab already active and scrolled into view.

One important thing to understand: the module emits **Bootstrap markup only** — it
ships no CSS or JavaScript. The Bootstrap styling and the tab-switching behavior
must come from your **theme** (for example a Bootstrap 5 theme). A small site-wide
setting lets you tell the module which Bootstrap major version (3, 4, or 5) your
theme uses, so it produces the matching toggle attributes and classes. It depends
on core's Field and Text modules.

This guide is written for a **human** building fields through the admin UI. If you
want terse, token-cheap references for an AI coding agent (the field/widget/
formatter internals, theme hook, and template variables), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

- The field itself is created and configured under your entity's field UI, e.g.
  **Structure → Content types → *(your type)* → Manage fields**, plus **Manage
  form display** (widget) and **Manage display** (formatter).
- One small site-wide setting — the **Bootstrap version** — lives at
  **Configuration → Content authoring → Bootstrap Horizontal Tabs**
  (`/admin/config/content/bootstrap-horizontal-tabs`), and requires the
  *Administer site configuration* permission.

## How to use it

**1. Add the field.**
On **Manage fields**, click **Add field** and choose **Horizontal Tabs**. Set the
cardinality to **Unlimited** (so editors can add as many tabs as they need).

**2. Set the widget.**
On **Manage form display**, the field uses the Horizontal Tabs widget, which gives
editors, per tab, a **Tab Label** (plain text) and a **Tab Body** (a rich-text
editor). Two rules apply: a tab that has a body must also have a header, and tab
headers must be **unique** within the field (the anchor ids are built from them).

**3. Choose how it displays.**
On **Manage display**, open the field's formatter settings:
- **Tab display** — **Tabs** (`nav-tabs`) or **Pills** (`nav-pills`). The *Tabs*
  option also enables the deep-linking behavior.
- **Tab orientation** — **Horizontal** (default) or **Vertical** (stacked tab
  strip beside the content).

A field with only **one** value renders as plain body content with no tab chrome,
which is a nice graceful fallback.

**4. Tell it your Bootstrap version.**
Visit **Configuration → Content authoring → Bootstrap Horizontal Tabs** and pick
**Bootstrap 3, 4, or 5** to match your theme (the default is 5). This decides
whether the markup uses `data-bs-toggle` (v5) or `data-toggle` (v3/4) and where the
active/show classes go. **Saving this form flushes all caches.** You can also set
it from the command line:

```bash
ddev drush config:set bootstrap_horizontal_tabs.settings version 4 -y && ddev drush cr
```

> **Bootstrap must come from your theme.** This module outputs the tab *markup* but
> no Bootstrap CSS or JS. Make sure your active theme loads Bootstrap (and that the
> version setting above matches the theme's Bootstrap major version), or the tabs
> will render unstyled and won't switch.

> **Tab headers are an admin-level HTML sink.** The tab body is filtered by its
> chosen text format as usual, but the tab **header** is emitted as admin-filtered
> markup (scripts are stripped, but a broad set of HTML is allowed). Only grant
> create/edit access on this field to trusted roles. This is standard Field API
> behavior, not a module vulnerability.
