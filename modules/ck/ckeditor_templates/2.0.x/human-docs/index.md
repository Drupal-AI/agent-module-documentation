# CKEditor Templates — manual setup guide

**CKEditor Templates** (`ckeditor_templates`) adds a **Templates** button to the
CKEditor 5 toolbar. When an editor clicks it, a dialog opens showing a gallery of
predefined HTML snippets — each with a label, a short description and a thumbnail
image — that they can insert into the content with one click, or use to replace
what they have written so far. It is the modern CKEditor 5 equivalent of the
classic "content templates" feature: a sanctioned library of ready-made layouts
that keeps editorial markup consistent.

Templates are stored as configuration, so you create and manage them in the admin
UI (or export and deploy them between environments like any other config). Each
template records its HTML body, the text format(s) it is offered on, a thumbnail,
a description, an enabled/disabled flag and a sort weight. You control which text
formats show the Templates button, and whether the dialog's "Replace actual
contents" option is ticked by default per format.

Two permissions separate the two audiences: a "template manager" role can create
and edit the template library, while ordinary editors only need permission to
*insert* templates. Developers can also supply templates from code instead of
config, because the module defines its own plugin type for that purpose (see the
sibling agent docs).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create templates, add the Templates
   button to a text format, and set the "Replace actual contents" default.

## Where it lives in the admin menu

Once enabled, the template library lives at **Configuration → Content authoring
→ CKEditor Templates** (`/admin/config/content/ckeditor-templates`), where you
add, edit, order, enable and delete templates. The Templates button itself is
added per text format on the CKEditor 5 toolbar under **Configuration → Content
authoring → Text formats and editors**.

## How to use it

First create one or more templates in the CKEditor Templates admin page, giving
each its HTML, a description, a thumbnail and the text formats it applies to.
Then edit the text format(s) where editors should see them and drag the
**Templates** button onto the CKEditor 5 toolbar. From then on, editors working
in that format can click **Templates**, pick a snippet from the dialog, and have
its markup inserted (or replace the current content). See
[Configuration](configuration/index.md) for the step-by-step.
