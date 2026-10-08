# Date Content Augmenter — manual setup guide

**Date Content Augmenter** (`date_content`) lets you attach arbitrary content to a
single date value, through the **Date Augmenter** API. Date Augmenter is Drupal's
mechanism for adding things to a rendered date — the classic example being an
"add to calendar" link. This module extends that idea: it lets you associate any
content with a specific date, including an individual value inside a multi‑value
or recurring date field.

The point is to model content that belongs *to a date* rather than to the page the
date sits on. A recurring monthly meeting can carry a different topic and speaker
each month; a historical date in a timeline can carry its source document; a
deadline can carry the guidance for meeting it. There's no natural place for that
in an ordinary content model, and Date Content gives you one. It works with any
date field a compatible date formatter supports — including core date fields —
though it was designed with **Smart Date** in mind.

To do this the module defines a new **Date Content** entity type, for which you
create one or more **bundles**. Each bundle can hold fields directly (for simple
cases like a text topic and speaker) or entity‑reference fields (to point at a
Speaker user, a Location node with an address, and so on). If you define more than
one bundle, the date field's formatter settings let you choose which bundle(s)
apply. Because it works through the Date Augmenter API rather than a bespoke field,
several augmenters can contribute to the same rendered date without knowing about
each other — an "add to calendar" link and an associated notice can coexist.

Its only dependency is the **Date Augmenter** module. One caveat: this release is
an **alpha** (1.0.0‑alpha8), and it introduces a new entity type with its own
**add** and **administer** permissions. Test it against your workflow before
relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Date Augmenter.

The module has **no single settings form**; you set it up by creating Date Content
bundles, adding fields to them, and turning the augmenter on in a date field's
display settings, as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create one or more **Date Content bundles** and add the fields each should hold
   — plain content fields for simple cases, or entity‑reference fields (to users,
   nodes, and so on) for richer relationships.
3. On the entity/view mode where your date field is displayed, open its **Manage
   display** and configure the date field's formatter. Enable the Date Content
   augmenter, and — if you defined more than one bundle — choose which bundle(s)
   may be associated with that field.
4. Grant the **add date content entities** and **administer date content
   entities** permissions to the appropriate roles under **People → Permissions**.
