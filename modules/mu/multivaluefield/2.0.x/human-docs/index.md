# Multi Value Field — manual setup guide

**Multi Value Field** (`multivaluefield`) provides a single Field API field type
that stores **several related sub‑values together in one field**. Rather than
creating a separate field for each piece of a small, repeating structure, you
define one Multi Value Field with a configurable set of columns, and its values
are edited as a set and rendered together. It ships as a complete triad — a field
**type**, a matching **widget**, and a **formatter** — plus a **Feeds target** so
you can import values into it.

Think of it as a lightweight alternative to Paragraphs or Field Collection for
cases where all you need is to keep a few related values atomic — a label/value
pair, a small repeating row — without the overhead of separate entities and
configuration. Its values are stored together in the field (as JSON), the field
configuration lives on the field storage, and there are no extra config entities
to manage. That keeps the field self‑contained and portable.

Because it is a pure field, it has **no routes, permissions, controllers, or
services** of its own: access is governed entirely by the host entity's normal
field, form, and display permissions — exactly like any core field. A bundled
**example submodule** (`multivaluefield_example`) demonstrates the field with a
sample entity so you can see it working quickly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the example submodule.

There is **no configuration page** for this module — it has no site‑wide settings
form. You set it up per field, described in "How to use it" below.

## How to use it

Everything happens in **Field UI** (make sure core's Field UI module is enabled):

1. Go to the bundle you want the field on — for example **Structure → Content
   types → *(your type)* → Manage fields** — and choose **Add field**.
2. Pick **Multi Value Field** as the field type, label it, and configure its set
   of sub‑value columns. Set cardinality as usual if you want multiple rows.
3. On **Manage form display**, arrange the field's widget so editors can fill in
   all the sub‑values together.
4. On **Manage display**, use the field's formatter to render the grouped
   sub‑values together in your theme.

To import data into the field, map your source columns to it through the
module's **Feeds target**. If you would rather see a ready‑made example first,
enable the `multivaluefield_example` submodule and inspect the sample entity it
provides.
