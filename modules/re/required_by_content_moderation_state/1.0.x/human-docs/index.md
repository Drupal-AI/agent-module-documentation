# Required by Content Moderation State — manual setup guide

**Required by Content Moderation State** (`required_by_content_moderation_state`)
lets a field be required *only* at certain points in your editorial workflow,
rather than always or never. A field can stay optional while editors are working
on a draft, and become mandatory only when they move the content to a specific
moderation state — for example when marking it *Ready for review*, or when they
try to *Publish* it themselves.

It builds on the **Required API** module (which it pulls in as a dependency) and
on core **Content Moderation**. Because the rule is tied to moderation states, it
only makes sense on content that runs through an editorial workflow.

There is no central settings page. You configure the behaviour per field, on that
field's own edit form, by choosing a "required strategy" and then picking the
moderation states that should make it required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Required
   API dependency) with Composer and enable it.

This module has no configuration page of its own — setup happens on each field's
edit form, described in "How to use it" below.

## Where it lives in the admin menu

There is no dedicated admin page. You work entirely from **Structure → Content
types → *(your type)* → Manage fields → *(the field)* → Edit**, and you need
Content Moderation configured with a workflow on that content type.

## How to use it

1. Make sure the content type has a **Content Moderation** workflow applied
   (**Configuration → Workflows**).
2. Go to the field you want to control: **Structure → Content types →
   *(your type)* → Manage fields**, then **Edit** the field.
3. Under **Choose a required strategy**, select **Required by Content Moderation
   state**.
4. Choose which moderation state(s) should make the field required — for example
   *Published* or a custom *Ready for review* state.
5. Save the field settings.

From then on the field stays optional in states you did not select, and is
enforced only when content is saved into a state you did choose. (This is a
form-validation rule for the editing experience — see the sibling *Required by
role* project for a similar per-role strategy.)
