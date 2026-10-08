# Scroll Progress — manual setup guide

**Scroll Progress** (`scroll_progress`) shows a progress indicator that fills as a
visitor scrolls through a page, giving readers a clear sense of how far through the
content they are. It is the kind of touch you often see on articles and long-form
pages, and it is purely a front-end/UI feature — it has no content model and no
bearing on access.

Where it stands out is choice of style: the module ships **five** indicator themes
— a **straight line**, a **circular** progress ring, an **animated** progress bar,
a **tooltip** progress indicator, and a **bottom** progress bar — and lets you pick
a **colour scheme** for the indication. You choose the look that suits your design
on the module's settings form.

The module has no other module dependencies and supports **Drupal 9, 10 and 11**.
This 10.1.x branch is a development branch and the project is in maintenance-fixes
mode, so keep that in mind for production use.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — choosing one of the five indicator
   themes and setting the colour scheme.

## Where it lives in the admin menu

Scroll Progress has its own settings form (configuration `scroll_progress.settings`),
reachable from the module's **Configure** link on the **Extend** page — that is
where you pick the indicator theme and colour scheme.
