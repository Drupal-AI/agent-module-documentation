<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multistep Form Framework Examples (multistep_form_framework_examples) — agent index

Reference/demo submodule of `multistep_form_framework`. Implements a runnable four-step
"buy a book" wizard so developers can read a complete, working implementation. Example code —
enable in development only, not production.

- Machine name: `multistep_form_framework_examples`. Part of project `multistep_form_framework`.
- Dependencies: `multistep_form_framework`, and core `node`, `text`, `options`, `image`, `file`, `user`.
- No permissions, services, or config schema of its own. Ships a `book` content type + fields as
  optional config under `config/optional/`.

## What it provides

- Wizard definition `multistep_form_framework_examples.multistep_wizard.yml`
  (key `multistep_form_framework_examples_book_buy_multistep`, `ajax: TRUE`, four steps, custom
  `class: BookWizard`).
- Route `multistep_form_framework_examples.book_buy_multistep` (`multistep_form_framework_examples.routing.yml`)
  serving `BookBuyMultistepForm`.
- `Drupal\multistep_form_framework_examples\Form\BookBuyMultistepForm` — `MultistepForm` subclass;
  `getFormId()` returns the wizard key; `prepareWizard()` seeds an empty `book` node.
- `Drupal\multistep_form_framework_examples\BookWizard` — `Wizard` subclass with `getBook()`/`setBook()`.
- Steps under `src/Form/BuyBookStep/`: `BaseStep` (adds title + step-id class, uses
  `EntityWidgetsTrait`), `Greetings`, `BookAttributes`, `Description` (saves the node), `Congratulation`
  (AJAX redirect to `<front>`).

## Reading order

- [agent/examples/book-wizard.md](examples/book-wizard.md) — the four-step flow class by class:
  seeding the node, rendering field widgets, saving, step jumping, and the final AJAX redirect.

See the parent index at `../../../2.x/agent/start.md` for the framework API itself.
