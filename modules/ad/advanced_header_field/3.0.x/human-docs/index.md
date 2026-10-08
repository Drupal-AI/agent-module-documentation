# Advanced Header Field — manual setup guide

**Advanced Header Field** (`advanced_header_field`) provides a **field type for
headings**. Instead of typing a heading into the body text, editors get a
dedicated field that stores heading text plus an optional **subtitle**, with a
configurable heading level (the HTML heading markup it outputs). That keeps
headings structured and consistent across content of the same type.

It is a content-editing / fields feature, built on top of the core Link field so a
heading can optionally become a link. It ships an optional
`advanced_header_field_navigation` submodule that adds an in-page jump menu.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the navigation submodule.

## Where it lives

There is no global settings page. The field appears where you add fields to an
entity: **Structure → (content type / entity) → Manage fields**. Its per-field
options (such as the heading level) are set on that field's settings, and how it
renders is chosen under **Manage display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the bundle you want to add a heading to — for example **Structure →
   Content types → [your type] → Manage fields** — and click **Add field**.
3. Choose the **Advanced Header** field type, give it a label, and save.
4. On the field's settings, configure the **heading level / markup** and whether
   the subtitle is used.
5. Under **Manage form display** the field gives editors a heading and subtitle
   input; under **Manage display** you control how the stored heading and subtitle
   are rendered.
