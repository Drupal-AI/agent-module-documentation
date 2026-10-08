# Paragraphs Access — manual setup guide

**Paragraphs Access** (`paragraphs_access`) adds **per‑paragraph access control** —
the ability to restrict who can **view** and who can **edit** individual paragraph
items, rather than a whole node. That makes it useful for mixed‑audience content:
gated sections within an otherwise public page, or paragraphs that only certain
roles should be able to change.

It works in two halves, and the distinction matters:

- **Edit access** is enforced directly in the **paragraph widget**. When a user
  lacks edit access to a paragraph, the module rewrites or hides that widget on the
  edit form, so they cannot change it there.
- **View access** is delegated to the **ADVA (Advanced Access)** framework, through a
  `ParagraphAccessConsumer` plugin. Paragraphs Access provides the node‑access‑style
  API and the consumer; **the actual view enforcement is done by ADVA and whatever
  access rules and grants you configure with it.** (The 2.x branch was reworked
  around Advanced Access specifically to give a clean interface to other
  access‑control modules; it was originally built to integrate with Role Access
  Control, RAC.)

Because view enforcement flows through ADVA, treat this as a boundary you must
**verify on your own site**, not one you can assume. Confirm that a restricted
paragraph is genuinely hidden in **every** rendering context, not just the default
themed page — in particular that it does not leak through **JSON:API / REST**,
through **Views that render fields directly**, or through **feeds**. This is the
classic "display access vs data access" concern for entity‑embedded content, and
nested/embedded paragraphs are exactly where it tends to slip. Edit restriction, by
contrast, is handled at the widget.

The module depends on the **Paragraphs** module, supports Drupal 10, 11 and 12, and
is covered by Drupal's security advisory policy. The 2.x branch is the recommended
one; 8.x‑1.x is no longer developed and should not be used.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside the Advanced Access framework and the access rules you
   choose).

Paragraphs Access provides the access **API and enforcement hooks** rather than a
settings form of its own; the actual view rules and grants come from the Advanced
Access framework and companion modules, so there is no standalone Paragraphs Access
configuration page to document.

## Where it lives in the admin menu

Paragraphs Access adds no settings page of its own. Its **edit** enforcement appears
on paragraph **edit forms** (restricted widgets are hidden or rewritten), and its
**view** enforcement is applied wherever the **ADVA** framework and your configured
access rules take effect.

## How to use it

1. Install and enable Paragraphs Access together with the **Advanced Access (ADVA)**
   framework it relies on and the companion module(s) that supply your access rules
   and grants (see [Installation](installation/index.md)).
2. Configure your access rules in that access framework so the right roles/users get
   view access to the right paragraphs. Paragraphs Access's `ParagraphAccessConsumer`
   plugin is what ties those grants to paragraph view access.
3. Confirm **edit** restriction by editing content as a limited user — restricted
   paragraph widgets should be hidden or non‑editable.
4. **Verify view restriction across every delivery path**, not just the rendered
   page: check JSON:API/REST responses, any Views that render paragraph fields
   directly, and any feeds, to be sure restricted paragraphs are not exposed as raw
   data anywhere.
