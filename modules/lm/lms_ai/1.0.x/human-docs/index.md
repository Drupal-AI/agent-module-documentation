# LMS AI — manual setup guide

**LMS AI** (`lms_ai`) adds AI-powered capabilities to the Drupal
[LMS](https://www.drupal.org/project/lms) module. At this stage the main module
is a small base ("stub") that wires AI into LMS, with the working feature
delivered as an activity-answer plugin submodule: an **AI text-field activity with
feedback**, where a learner's free-text answer is evaluated by an AI model
asynchronously (the evaluation runs from cron) and feedback is returned.

Because it builds on LMS, it fits into the same course → lesson → activity →
answer model: you add an AI-evaluated activity to a course much as you would any
other activity type, and the AI scoring/feedback happens in the background rather
than blocking the learner.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside LMS and the AI Providers API, and connect an AI provider.

LMS AI has no settings form of its own. The AI connection it relies on — which
provider to call and the API key to authenticate with — is configured in the
**AI Providers API** module, not here (see below).

## What it depends on, and the cost/privacy angle

LMS AI requires the **AI Providers API** module (it deliberately does *not*
require the full AI module package). The AI provider and its **API key** are
configured through that module. Two things are worth keeping in mind before you
switch this on:

- **Store the API key as a secret.** Configure your provider's credentials
  through the AI Providers API module, keeping the key in an environment variable
  and/or a Key entity rather than hard-coding or committing it.
- **Every evaluation is an outbound API call that may cost money.** Because
  learner answers are sent to an external AI provider for evaluation, expect
  per-call cost and be aware that answer text leaves your site — factor in the
  provider's pricing and any data-handling/privacy considerations for learner
  submissions.

## How to use it

1. Install and configure LMS, and configure an AI provider + API key in the AI
   Providers API module.
2. Enable LMS AI and its AI activity-answer submodule.
3. Add an AI text-field activity to a course.
4. When learners submit, evaluation and feedback are produced asynchronously on
   the next cron run, so make sure cron runs regularly.

This is a **1.0.0-alpha2** release for Drupal 11, so treat it as early software.
