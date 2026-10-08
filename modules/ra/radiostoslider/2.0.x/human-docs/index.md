# Radios to Slider — manual setup guide

**Radios to Slider** (`radiostoslider`) is a field **widget** that renders a set of
radio‑button options as an interactive **slider**, using the radios‑to‑slider jQuery
plugin. For a field whose allowed values form a small, ordered set — a 1–5 rating, a
satisfaction scale, a range of discrete choices — a slider often reads better and is
friendlier to use than a stack of radio buttons.

It applies to List (options) fields, including options sourced from a Taxonomy
vocabulary reference, on any fieldable entity type. The module also provides a
**Webform element** so you can get the same slider effect for radio options inside a
Webform. Importantly, this is purely a presentation change: the value stored is still
one of the field's normal allowed options, so there are no access or data implications
— just a nicer input UI.

> **Known limitation:** the widget does not work well for List fields that can hold
> **more than one value**. Use it on single‑value option fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, then download the
   radios‑to‑slider JavaScript library.

This module has **no dedicated settings page** — you enable it as a widget on a
field's *Manage form display*, as described below.

## How to use it

1. Install the module and its external library (see
   [Installation](installation/index.md)).
2. Add (or pick) a single‑value **List** / options field on your entity type — for
   example a 1–5 scale on a content type.
3. Go to that entity type's **Manage form display**
   (**Structure → Content types → *(type)* → Manage form display**), and set the
   field's widget to **Radios to slider**.
4. Use the widget's settings to apply custom slider effects.
5. For Webforms, add the Radios to Slider element to your form to get the same effect
   for radio options.
