# Role Paywall — manual setup guide

**Role Paywall** (`role_paywall`) hides selected fields on premium content from users
who lack a subscriber role — the familiar "read the first paragraph, then subscribe"
pattern that publishers use. It works on a per-field basis, so a visitor still sees
the rest of the page (the title, the teaser, other fields) while the premium fields
are withheld, and a "subscribe to continue" block can be shown in their place.

You choose which content is premium (either mark individual items with a boolean
field, or treat every item of a type as premium), which fields to hide, and which
roles are allowed to see them. The module adds an **Access premium content**
(`access paywalled content`) permission alongside the role list, works with core
nodes and other content entities that have a canonical URL, and keeps the entity
itself accessible (no 403 errors). It also provides a block visibility condition so
your subscribe prompt appears only on content that was actually paywalled.

This module is deliberately just the "wall" part of a paywall — it does not handle
payments. To sell and manage subscriptions, pair it with Drupal Commerce and a
module such as Commerce License.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose premium content, the fields to
   hide, the roles that may see them, and the subscribe block.

## Where it lives in the admin menu

Once enabled, configure the paywall at **Configuration → Content authoring → Role
Paywall** (`/admin/config/content/role_paywall`, the
`role_paywall.role_paywall_entity_form` route), gated by the **Administer site
configuration** permission.

## Important: understand the access model before you rely on it

This is essential to know before using Role Paywall for anything commercial. In the
2.1.x release the paywall is enforced at the **render layer only** — it hides the
configured fields while a page is being built for the *full* view mode. It does
**not** apply an entity-, field-, or query-level access check, which means the
underlying field data is still readable through other channels:

- a core **JSON:API / REST** request can return the paywalled field in full;
- a **teaser or listing** view mode that includes the field will render it, because
  the paywall only acts on the *full* view mode;
- anything else that reads field values (Views field output, search indexing) can
  surface the text too.

In other words, on this release the paywall reliably hides premium fields from the
normal article page, but it is **not** a hard server-side access control over the
data itself. Treat it as a presentation/UX "wall" for the main page, keep truly
sensitive material out of it, and don't expose the paywalled entities over JSON:API
or in teaser displays if that would leak the content. See
[Configuration](configuration/index.md) for how to set it up with these limits in
mind.
