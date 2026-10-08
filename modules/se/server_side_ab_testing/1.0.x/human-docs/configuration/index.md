# Configuration

Experiments in Server-side A/B Testing are managed as Drupal entities through the
admin UI. Setting up a test means defining an experiment, pointing it at the right
nodes, and choosing its status — plus deciding who is allowed to administer and
bypass experiments.

## Build an experiment

Each experiment is defined by three parts, all of them existing Drupal nodes:

- **Main Page** — the entry-point URL that triggers the experiment. This is what
  visitors request, and where assignment happens.
- **Control Page** — the baseline version of the content, used as the point of
  comparison.
- **Alternative Variants** — one or more additional nodes, each with a **weight**
  that controls how often it is shown relative to the others. Heavier weights are
  served more frequently.

When a visitor hits the Main Page of an active experiment, they are assigned to
the control or one of the variants and served that node transparently, with
experiment metadata attached for analytics and cache variation.

## Choose the experiment status

An experiment's status controls its behaviour:

- **Active** — assignment is applied on the Main Page. Direct access to a variant
  URL redirects to the Main Page.
- **Paused** — no assignment happens on the Main Page, but variant URLs still
  redirect to the Main Page.
- **Draft** / **Finished** — no assignment and no redirect logic apply.

## How visitors are remembered

Assignments are sticky so results stay meaningful:

- **Anonymous visitors** are identified by a long-lived cookie and persisted in
  the database.
- **Authenticated users** have their assignment persisted by user ID.
- When an anonymous visitor logs in, their existing assignment is **migrated
  automatically** to their account.

Database constraints keep these assignments stable and deterministic.

## Permissions

On **People → Permissions**, the module provides a set of permissions to control
who can do what, including administering experiments, changing settings, resetting
data, previewing variants, and a **`bypass server-side ab testing`** permission
that lets a user skip experiment assignment (useful for editors and previews).
Restrict the administration, settings, reset, and bypass permissions to trusted
roles — a user who can bypass testing will not be counted in an experiment, and a
user who can administer experiments controls what every visitor sees.

## Analytics

Experiment data is exposed to **GA4 / Google Tag Manager** through
`drupalSettings` and triggered analytics events, so once your GA4/GTM setup is in
place you can report on how each variant performs.
