# Paragraphs Role Visibility — manual setup guide

**Paragraphs Role Visibility** (`paragraphs_role_visibility`) lets you hide or show
an individual paragraph based on the visitor's user role. Instead of building
separate paragraph types for each audience, or duplicating a whole page, you drop
in one paragraph and say "only members can see this" — right on that single item.

The important part is *how* it hides content. This module does not just visually
tuck the paragraph away with CSS, where a curious visitor could still find it in
the page source. It enforces the restriction at Drupal's real access layer
(`hook_paragraph_access`). When a user is not allowed to see a paragraph, that
paragraph is genuinely withheld — it is never rendered and never lands in the
cached output for that user. Caching is handled correctly (results vary by the
`user.roles` cache context), so it is safe to use as actual access control, not
just cosmetic hiding.

It works as a **Paragraphs behavior plugin**, so it slots neatly into the existing
Paragraphs editing experience — no extra fields to add, no settings page to visit.
You enable the behavior on a paragraph type, and from then on each paragraph gets a
*Behavior* tab where an editor picks the roles that may view it. It requires the
[Paragraphs](https://www.drupal.org/project/paragraphs) module (1.6 or newer) and
supports Drupal 10.1, 11, and 12. It adds no permissions of its own and ships no
Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is **no dedicated settings page**. The module works through the Paragraphs
UI you already use:

- **Structure → Paragraphs types → (edit a type) → Behaviors** — turn the
  **Paragraph visibility** behavior on for the paragraph types that need it.
- **The paragraph's *Behavior* tab** (inside whatever node, block, or entity hosts
  the paragraph) — where the editor actually chooses the roles for that one
  paragraph.

## How to use it

1. **Enable the behavior on a paragraph type.** Go to *Structure → Paragraphs
   types*, edit the type you want to control (for example "Text" or "Call to
   action"), open its **Behaviors** section, and tick **Paragraph visibility**.
   Save. Repeat for any other paragraph types that should support role gating.
2. **Set roles on an individual paragraph.** Edit any content that contains one of
   those paragraphs. On the paragraph, open its **Behavior** tab. You will see a
   list of **Available roles** (with a handy *Select all* checkbox) and an
   **operand** choice:
   - **Any** (`or`) — the user needs at least one of the selected roles to see the
     paragraph.
   - **All** (`and`) — the user must hold every selected role to see it.
3. **Save.** The paragraph is now visible only to users who satisfy the rule.
   Everyone else simply won't see it — it is removed at the access layer before
   rendering.

A quick note on defaults: if you leave a paragraph with no roles configured, it
stays visible to everyone (access is left "neutral" and deferred to Drupal's other
checks). The behavior form starts with all roles selected, so out of the box a
paragraph remains public until you narrow it down.

Typical uses:

- Show a paragraph only to authenticated users and hide it from anonymous
  visitors (or the reverse — a "please log in" call-to-action shown only to
  anonymous users).
- Restrict a promotional, pricing, or subscriber-only paragraph to a "member"
  role.
- Reveal internal notes or a QA/beta preview paragraph only to editors,
  administrators, or a QA role on an otherwise public page.
- Build audience-specific sections inside a single flexible content page — mixing
  public and role-gated paragraphs in the same layout.

If you are upgrading from a pre-2.x version, the module automatically migrates your
old role-visibility settings into the new structure across all paragraph revisions
when you run database updates — no manual re-entry needed.
