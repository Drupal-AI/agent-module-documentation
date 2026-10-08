# Anu LMS — manual setup guide

**Anu LMS** (`anu_lms`) is a learning management system for individual teachers and
educational organisations. A teacher creates a **course**, adds **lessons** with
rich content and **quizzes**, and students work through the material while their
**progress** is tracked. It aims to be "deceptively simple" to author while giving
learners a smooth, app‑like experience.

What sets Anu apart from a traditional Drupal LMS is that it is **decoupled**: the
learner experience is a JavaScript (React) application that talks to Drupal over
REST. To make that feel immediate, a whole lesson — paragraphs nested inside
paragraphs, with media and quiz questions attached — is serialised into a *single*
REST response rather than fetched through a waterfall of separate requests. That is
why it relies on the `rest_entity_recursive` and `rest_paragraphs_recursive`
modules, which serialise an entity and everything nested inside it at once.

It supports Drupal 10 and 11.

## Important compatibility warning

Anu LMS itself is sound, but one of its dependencies has a known problem. **On
Drupal 11.4, `rest_entity_recursive` fatals when its class loads** — this was
verified in practice, and the fatal took Drush down with it, requiring the modules
to be removed directly from `core.extension` to recover. The cause is a PHP
return‑type incompatibility: the contrib normalizer widens a return type that core
narrowed, and PHP does not allow that, so the class cannot load.

Anu LMS is not the module at fault — its dependency is. **Before you plan an install,
check whether `rest_entity_recursive` has a release compatible with the exact
Drupal core version you are on.** If it does not, Anu's decoupled endpoints will not
function on that core version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, plus the dependency caveat above.

## Where it lives in the admin menu

Once enabled, you author courses, lessons, and quizzes as content, and the React
front end presents them to learners over REST. Because the learner experience is a
decoupled application, most of the day‑to‑day work is content authoring rather than
a single settings screen.

## How to use it

1. Confirm `rest_entity_recursive` is compatible with your Drupal core version (see
   the warning above), then install and enable Anu LMS (see
   [Installation](installation/index.md)).
2. Create a course, add lessons with rich content, and attach quizzes.
3. Students work through the lessons in the decoupled front end, with their
   progress tracked.
