# Attempt Management — manual setup guide

**Attempt Management** (`attempt_mgmt`) provides an **"attempt" entity type** and a
field you can attach to any content entity, so a site can record repeated attempts
against something — a quiz, a SCORM package, an exercise — without building that data
model from scratch each time.

Anything a user tries more than once and that records a result — an assessment, an
e‑learning module, a submission that can be retried — needs the same underlying
shape: a per‑user, per‑entity record of each attempt, plus a *type* that defines
what an attempt means and what it stores. This module supplies exactly that as
reusable infrastructure. In fact it is the dependency behind the `scorm_field`
module, which uses it to record SCORM completion and score data.

Because it is a building block rather than a finished feature, what it does on a
given site is defined by the attempt *types* you create and the module (or your own
code) that drives it. On its own it adds the entity type and the field — it does not
produce a quiz or a course by itself. Treat it as the storage layer other features
build on. It runs on Drupal 10 and 11 with no dependencies outside core. Type
management is gated by its own permission, and the settings page by *administer site
configuration*.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define attempt types, attach the
   attempts field, and set the module's options.

## Where it lives in the admin menu

- **Attempt types** are managed under **Structure** at
  `/admin/structure/attempt_mgmt_attempt_types` (add one at
  `/admin/structure/attempt_mgmt_attempt_types/add`), gated by the **Administer
  attempt_mgmt attempt types** permission.
- The module's **settings** form is at **Configuration → System → Attempt
  Management settings** (`/admin/config/system/attempt-management/settings`), gated
  by *administer site configuration*.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Define one or more attempt types and attach the attempts field to the entities
   that should carry attempts (see [Configuration](configuration/index.md)).
3. Let a driving feature — such as `scorm_field`, or your own code using the
   `AttemptFactory` service — create and read attempts against those entities.
