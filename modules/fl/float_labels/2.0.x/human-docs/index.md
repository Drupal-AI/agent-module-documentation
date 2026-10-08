# Float Labels — manual setup guide

**Float Labels** (`float_labels`) applies the popular "floating label" pattern to
Drupal forms. A floating label starts life as placeholder text inside the field,
then animates up and stays affixed above the field once the user focuses it or
types a value — saving vertical space while keeping the label visible. Fields with
a value show their label pinned to the top; empty, unfocused fields look like a
placeholder; the focused field is ready for typing. Select fields are supported
too: their default value is replaced with the label, and the label is then hidden.
The transitions use CSS3 animations.

The appeal is that you get this with **configuration rather than custom CSS/JS**.
There is a small settings form where you enter the **form IDs** you want the effect
applied to, and beyond styling tweaks for your own theme, that is generally all
that is required.

Float Labels is a front-end enhancement with no security surface. The one thing
worth checking is **accessibility**: a floating label must remain a real,
associated `<label>` for screen readers — not merely placeholder text — so confirm
the behaviour works with your theme and does not degrade the experience for
assistive technology.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form where you list the
   form IDs to apply the effect to.

## Where it lives in the admin menu

Float Labels provides a settings form where you enter the form IDs it should apply
to; reach it from the module's **Configure** link on the **Extend** page, or under
**Configuration**. See [Configuration](configuration/index.md) for what to enter.
