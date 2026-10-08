# Confirm Leave — manual setup guide

**Confirm Leave** (`confirm_leave`) warns an editor before they navigate away from
a form that has unsaved changes. It wires Drupal forms up to the browser's
built‑in "are you sure you want to leave? your changes may not be saved" prompt —
the same safety net you get in a webmail composer — so a mis‑clicked link or an
accidental back button no longer quietly throws away half an hour of writing.

Under the hood it is tiny: a small JavaScript file tracks whether anything on the
page has been modified and, if so, registers the browser's `beforeunload` handler.
There are no dependencies beyond core, no routes, no permissions, and nothing to
configure — it starts protecting forms the moment you enable it. It supports
Drupal 10 and 11. Note that the current release is a **beta** (`8.x-1.0-beta6`).

Two behaviours are worth knowing up front, because they are **browser policy, not
choices this module makes**:

- **The warning message can't be customised.** Browsers have shown a generic
  string for years to stop sites abusing the prompt, so you cannot brand or reword
  it.
- **The prompt only appears if the visitor has actually interacted with the
  page.** A form that was merely opened and looked at, with nothing typed or
  clicked, will not trigger the warning.

It is also worth a quick check against two things on your site: AJAX‑heavy editing
experiences such as Layout Builder or Paragraphs (where there is more changing
state for the dirty‑tracking to keep up with), and core's own unsaved‑changes
warnings, which some editing setups already provide — two prompts firing at once is
worse than one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module has no settings form and needs no
setup. Enable it and it works.

## How to use it

There is nothing to do after enabling. Edit any protected form, change a field,
then try to navigate away without saving: the browser shows its "leave site?"
confirmation. Save the form (or discard your changes deliberately) and the prompt
no longer fires. If you would rather *prevent* loss than merely warn about it, look
at an autosave module instead — this module warns; it does not save for you.
