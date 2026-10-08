# Forms Steps — manual setup guide

**Forms Steps** (`forms_steps`) lets you turn a long entity form into a guided,
multi‑step wizard — the kind of "page 1 of 3, Next / Previous" flow you'd want
for an application, a registration, a survey, or any onboarding sequence. Instead
of writing a custom form controller, you build the wizard entirely from
configuration.

The trick is that each step reuses a Drupal **form mode**. You decide which
entity type and bundle a step edits and which form mode it shows — and because
form modes are managed with the normal Field UI, you control exactly which fields
appear on each page. Forms Steps then strings the steps together in order, gives
each one its own URL, adds Next / Previous / Cancel / Delete buttons with labels
you choose, and can show a progress bar.

Behind the scenes, every run of a wizard gets a unique instance ID (a UUID that
travels in the step URLs), so step 2 can keep editing the same entity that step 1
created — or create additional, linked entities as the user advances. The
front‑end step pages are reachable by anyone with the core "access content"
permission, so anonymous visitors can complete a public flow. Data is saved
incrementally as the user moves from step to step.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it pulls in Field, Field UI, and Block).
2. [Configuration](configuration/index.md) — build a workflow, add its steps and
   progress‑bar items, set redirection, and place the progress‑bar block.

## Where it lives in the admin menu

Forms Steps lives at **Configuration → Workflow → Forms Steps**
(`/admin/config/workflow/forms_steps`), gated by the **Administer forms steps**
permission. From there you create workflows, add and order their steps, and
manage the progress‑bar items.

## How to use it

1. In **Field UI**, create the entity **form modes** you want each step to show
   (Manage form modes), and place the right fields in each.
2. Go to **Configuration → Workflow → Forms Steps** and add a workflow.
3. Add one **step** per page, each pointing at an entity type/bundle, a form
   mode, and a URL fragment.
4. Optionally add **progress steps** for the progress bar, set where the wizard
   redirects on completion, and place the **Forms Steps progress bar** block.
5. Visit the first step's URL to walk the wizard; each run is tracked by its own
   instance ID.
