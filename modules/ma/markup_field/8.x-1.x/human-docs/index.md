# Markup Field — manual setup guide

**Markup Field** (`markup_field`) provides a field type that stores **rendered
markup** — the HTML output together with its dependent assets (attached CSS and
JavaScript libraries). It is meant for situations where you have already‑rendered
content that needs to be stored on an entity and displayed again later with its
associated styling and behaviour intact.

Because the field stores markup that is then output on the page, the trust boundary
matters. Whatever HTML (and any script) ends up in the field is rendered when the
entity is displayed, so **unsanitised or untrusted markup in this field is a
stored cross‑site‑scripting (XSS) vector**. Restrict who can set the field to
trusted users, be deliberate about what generates the stored markup, and sanitise
it where the source is not fully trusted. The field itself has no access‑control
role of its own.

Markup Field supports Drupal 8, 9, 10, and 11. It is in the *Field types* package
and is currently marked as *seeking a new maintainer* on drupal.org.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** for this module. You configure it by adding a
Markup field to an entity, as described under "How to use it" below.

## Where it lives in the admin menu

Markup Field adds no admin settings page. You add the field per bundle under
**Structure → Content types → *(your type)* → Manage fields**, and control its
display under that bundle's **Manage display**.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and **add a
   field** of the **Markup** type.
2. Configure the field as usual, then decide who is allowed to edit it — keep this to
   **trusted users**, because its contents are rendered as markup on display.
3. Populate the field only with markup you trust, or sanitise it before storing.

> **Security reminder:** treat this field like any place that outputs raw HTML. If an
> untrusted user can write to it, they can inject scripts that run for everyone who
> views the content. Limit edit access and control what generates the markup.
