# FAQ Field — manual setup guide

**FAQ Field** (`faqfield`) adds a field type for frequently‑asked‑question lists.
Attach it to a content type (or any fielded entity — a taxonomy term, a user, and
so on) and editors get an unlimited, drag‑to‑reorder list of question/answer
pairs, each answer stored with its own text format. It is a structured, reusable
alternative to hand‑building an FAQ inside a single WYSIWYG blob.

On display you choose how the list is rendered from five formatters: an animated
**jQuery accordion** (the default), a semantic HTML **definition list**, an
**anchor list** with jump links to each answer, native HTML **details/summary**
disclosure widgets, or bare **simple text** you style entirely in your own theme.
Questions are always output as plain text; answers run through whichever text
format you (or the editor) chose, so some answers can be full HTML and others
plain.

Everything about FAQ Field is configured on the standard Field UI screens — there
is no admin settings page, no permissions, and no routes. It depends on Drupal
core's Field module and the **jQuery UI Accordion** module (which powers the
default accordion display).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

FAQ Field has no settings page of its own. You add and configure it on a content
type's field screens: **Structure → Content types → (your type) → Manage
fields** (add the field), **Manage form display** (the editing widget), and
**Manage display** (the formatter).

## How to use it

### 1. Add the field

Under **Manage fields**, add a field of type **FAQ Field**. Because an FAQ is
always a list, the field is automatically set to hold unlimited values. The field
has one setting:

- **Default text format** — the text format applied to answers that do not carry
  their own. (This choice only appears when more than one text format is available
  to the user.)

### 2. Choose the editing widget

Under **Manage form display**, the **FAQ Field** widget offers:

- **Answer input type** — a plain **Textarea**, a **Formattable textarea** (a
  WYSIWYG/CKEditor box, the default; required if you want rich‑text answers), or a
  single‑line **Textfield**.
- **Question label** and **Answer label** — rename the two inputs to fit your
  content model.
- **Required** — make the question and/or answer required.
- **Advanced** — the question's maximum length and width, how many rows the
  question and answer boxes have (a question with 0 rows is a single‑line field),
  and so on.

### 3. Choose the display formatter

Under **Manage display**, pick one of the five formatters:

- **jQuery Accordion** *(default)* — an animated show/hide panel list. Options
  include which panel is open by default (or none), the height style, whether
  panels are collapsible, the trigger event, and the animation easing and
  duration.
- **HTML definition list** — a clean, script‑free `<dl>`.
- **HTML anchor list** — a list of jump links (bulleted or numbered) at the top,
  linking down to each answer.
- **HTML details** — native `<details>`/`<summary>` disclosure widgets, no
  JavaScript needed.
- **Simple text** — bare markup for you to style in your theme.

Most formatters let you choose the HTML heading tag (h2–h6) used for each
question. Four of the five formatters can be overridden with your own Twig
template; the accordion's markup must stay intact for its JavaScript behavior, so
it is intentionally not meant to be restructured.
