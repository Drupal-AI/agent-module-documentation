# FlowDrop Field Widget Actions — manual setup guide

**FlowDrop Field Widget Actions** (`flowdrop_field_widget_actions`) connects the
**Field Widget Actions** module to **FlowDrop**, the visual workflow editor. It lets a
content editor trigger a FlowDrop workflow straight from the field they are editing —
no custom PHP and no hard‑coded logic. The workflow can transform, validate, enrich,
or generate content on demand and drop the result back into the field.

When the action runs, the workflow receives values from the **entire entity form**,
not just the field being edited, so it has the full context of what the editor is
working on. A single run can return **one to five suggestions** for the editor to
choose from, and you decide which workflow output key populates the target field. The
context is formatted so it plugs neatly into AI nodes (for example a GPT model), which
makes this a natural fit for AI‑assisted editing. It works with text fields,
textareas, email fields, phone‑number fields, and more. Typical uses are summary
suggestions, an SEO meta‑tag generator, a content‑quality checker, and auto‑tagging.

This module has **no central settings page**. You set up each action on the field
widget itself (via *Manage form display*), and the behaviour is defined by the FlowDrop
workflow you point it at.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its Field Widget Actions and FlowDrop dependencies.

There is **no dedicated configuration page** for this module. Actions are configured
per field widget on *Manage form display*, and the logic lives in the FlowDrop
workflow — see [How to use it](#how-to-use-it) below and the
[FlowDrop](https://www.drupal.org/project/flowdrop) project.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and build the FlowDrop
   workflow you want to run — for example one that summarises a body field or generates
   meta tags.
2. Go to the content type's **Manage form display** (**Structure → Content types →
   *(your type)* → Manage form display**).
3. On the target field's widget, add a **Field Widget Action** of the FlowDrop type and
   choose the workflow it should execute.
4. Configure how many suggestions to generate (1–5) and which workflow output key fills
   the field.
5. Edit a piece of content: the action appears next to the field, and clicking it runs
   the workflow over AJAX and offers the result(s).

> **Review what your workflows do.** The action runs a FlowDrop workflow, which may
> process content and — depending on the nodes it contains — call external services
> such as an AI provider (egress and cost). Review each workflow's behaviour, and note
> that this module adds no access control beyond its own permission, so restrict who
> can use it to trusted editors.
