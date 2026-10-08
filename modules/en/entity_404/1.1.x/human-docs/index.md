# Entity 404 — manual setup guide

**Entity 404** (`entity_404`) makes an entity page **return a 404 (Not Found)**
when the entity fails certain configured conditions. Instead of showing the page —
or returning a 403 that confirms the entity exists — a matching entity is
presented as if it simply isn't there. It has no module dependencies and provides
its own permissions.

Out of the box it applies two checks to an entity being viewed:

- a **full view** must be configured for it, and
- the entity must be **translated, or untranslatable**.

If an entity does not pass the checks you have left enabled, the visitor gets the
site's 404 page. This is handy for hiding entities that shouldn't be reachable —
by state or field value, for example — while avoiding any hint that they exist.

> **Understand what it does and doesn't do.** Returning **404 instead of 403**
> avoids disclosing that a restricted entity exists, which is a nice privacy touch.
> But Entity 404 governs the **rendered page response** only — it is **not a
> substitute for real entity access control**. The entity still exists and may be
> reachable through other routes, APIs, or listings unless those are restricted
> too. Use it *alongside* proper access control, never instead of it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the module settings, where you can
   turn off checks you don't need.
