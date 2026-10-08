# Layout Builder Sections Access — manual setup guide

**Layout Builder Sections Access** (`layout_builder_sections_access`) adds two
per‑section options to core **Layout Builder**: you can **deactivate** a section, or
**restrict a section to selected roles**. It's for the common case where a whole
section should be shown only to certain roles, or switched off temporarily without
deleting it.

The important thing to understand is the *layer* at which this operates. It controls
whether a section is **rendered**, by role. Because a restricted section is skipped
**server‑side**, its content is not present in the HTML at all for non‑matching
roles — which is better for privacy than hiding it with CSS. For a task like hiding a
marketing block from anonymous users, that is exactly right.

But it is **section‑render control, not deep access control.** Any block placed
inside a restricted section still has its own access rules, and content shown there
should not be treated as protected *solely* because the section is restricted — if
that same content is reachable another way (its own URL, JSON:API, or another
placement) it is still exposed. Use this module for role‑targeted *layout*, and back
any genuinely sensitive content with the block's or entity's own access controls.

The module depends on core Layout Builder and targets Drupal 10 and 11. Note from
the maintainers: the community is working on a visibility feature for Layout Builder
in core, and the module intends to provide an update path if and when that lands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** for this module. The per‑section options
appear inside the Layout Builder UI, described below.

## How to use it

This module extends core Layout Builder, so you use it wherever Layout Builder is
active:

1. Edit a page's layout in **Layout Builder**.
2. Add a new section, or configure an existing one.
3. In the section's settings you'll find an extra option field that controls the
   whole section's visibility: **deactivate** the section, or **restrict** it to one
   or more roles.
4. Save the section, then save your layout. A deactivated or role‑restricted section
   is removed from the rendered markup for anyone it should not be shown to.

Remember: this hides the *section's rendering* by role. For anything sensitive, also
protect the underlying content with the block's or entity's own access controls.
