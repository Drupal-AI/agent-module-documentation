# AI Empathy Evaluation — manual setup guide

**AI Empathy Evaluation** (`ai_empathy`) is a testing tool for the *empathetic*
and *ethical* side of AI behavior. It runs AI responses against a set of ethical
dilemma scenarios and scores how well the AI reasons about sensitive situations,
so a team can measure — and then improve — how their AI features handle empathy
and ethics.

The idea is to treat empathy like any other quality you'd want to test. Rather
than hoping an AI feature responds appropriately to a difficult, human situation,
you run it through dilemma scenarios, score the results, and use those scores to
refine your prompts, models, or configuration over time.

The evaluations run through your configured AI provider, so each run may incur
provider cost. The module ships permissions that separate administering it,
running evaluations, and viewing or rating the results — so you can let some
people run tests while keeping configuration locked down.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its AI dependency.

## Where it lives in the admin menu

AI Empathy Evaluation has no single dedicated settings route (`configure` is
null); you work with it through its evaluation screens, which are gated by its
permissions:

- **Administer AI empathy** — manage the module and its scenarios.
- **Run AI empathy evaluation** — kick off an evaluation run.
- View and rate results — inspect and score the outcomes.

## How to use it

1. Make sure the AI module has a working provider, with its API key stored as a
   **Key** entity (never in plain config).
2. Grant the appropriate permissions to the people who should administer,
   run, or review evaluations.
3. Run an evaluation against the ethical-dilemma scenarios; the AI's responses
   are scored for empathy and ethical reasoning.
4. View and rate the results, and use what you learn to refine your AI features.

Because every run calls the AI provider, keep an eye on provider cost when
running large evaluation batches.
