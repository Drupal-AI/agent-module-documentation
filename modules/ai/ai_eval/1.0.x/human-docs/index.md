# AI Eval — manual setup guide

**AI Eval** (`ai_eval`) is an evaluation framework for **AI agents**. It lets a
team systematically test and score how an AI agent behaves against expected
outcomes, using pluggable **graders**, datasets defined in **YAML**, and judge
validation. Results are annotatable, so reviewers can leave notes as they
inspect them.

The point is to make agent behavior measurable rather than anecdotal. You define
a dataset of cases in YAML, choose graders that score the agent's output, and
optionally validate the judges doing the grading. Run the evaluation and you get
scores you can track over time as you change prompts, models, or agent logic.

Evaluations run through your configured AI provider, so each run may incur
provider cost. The module ships permissions that separate operating it (running
evaluations), administering it, annotating results, and validating judges — so
you can hand out just the access each person needs.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

AI Eval has no single dedicated settings route (`configure` is null); you work
with it through its evaluation screens, gated by its permissions:

- **Operate AI eval** — run evaluations.
- **Administer AI eval** — manage the framework.
- Annotate results and validate judges — review-side permissions.

## How to use it

1. Make sure the AI module has a working provider, with its API key stored as a
   **Key** entity (never in plain config).
2. Grant the appropriate permissions to the people who should operate,
   administer, annotate, or validate.
3. Define a dataset in YAML and choose the graders that will score the agent's
   output.
4. Run the evaluation, then inspect and annotate the scored results — optionally
   validating the judges that produced them.

Because every run calls the AI provider, keep an eye on provider cost when
running large evaluation sets.
