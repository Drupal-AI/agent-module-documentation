# Sample Content — manual setup guide

**Sample Content** (`samples`) lets you keep demonstration and development content
on a live site without exposing it to the public. Sample nodes behave exactly
like ordinary content, except that they are restricted to users who have
permission to view or manage them — so you can share representative pages with a
client or designer, or keep reference content for visual regression testing, on
your canonical/production environment where it will not be overwritten by routine
database syncs.

The important thing to know is *how* it restricts that content, because it does it
the right way. Rather than hiding samples only in the admin UI, the module
implements Drupal's **node access grants system** (`hook_node_access_records()`).
That means the restriction is a real, grant‑based access control honoured
everywhere Drupal checks node access — the canonical page route, **Views,
JSON:API/REST and search** — not just in one interface. This is the robust pattern
you want for keeping non‑public content genuinely non‑public.

The module needs a little setup rather than working purely on‑enable: after
enabling it you configure permissions and then **rebuild node access permissions**
(see installation), because node access grants only take effect once they are
built. It depends on core's **Node** module, provides its own permissions, and has
no submodules. It is compatible with the Devel module and `devel_generate`, but
serves a different purpose — representative content you keep and share, rather than
throwaway random content.

The key thing to get right is the permission that grants viewing of sample
content: gate it to exactly the audience who should see the samples, and remember
that changing the grants requires a rebuild.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it,
   configure permissions and rebuild node access.

## How to use it

Once installed and configured, create sample content as you would any other
content; it stays hidden from the public but visible to permitted users. Use it to
share in‑progress pages with stakeholders, or to capture a piece of content that
reproduces a styling bug so a developer can fix it and later use it as a visual
regression reference.
