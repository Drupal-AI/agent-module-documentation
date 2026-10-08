# Access Records — manual setup guide

**Access Records** (`access_records`) lets you model "who may do what regarding
which content" as ordinary, editable **content entities** — the access records —
and then enforces those rules at both entity and route level. Instead of writing
custom node-access code, you create records that link *subjects* (usually users)
to *targets* (content), and the module grants access accordingly.

You start by defining an **access record type**, which is bound to one target
content entity type. Each record then links one or more subjects to one or more
targets by **matching field values** — a subject can act on a target when they
share at least one of the matched values. Matching is driven by field machine
names, with a small set of prefixes to control which side a field applies to:

- an **unprefixed** field (e.g. `uid`) matches on both the subject and target
  sides;
- a **`subject_`** prefix scopes a field to the subject side only;
- a **`target_`** prefix scopes it to the target side only;
- an **`ar_`** prefix marks a field as descriptive — never used for matching.

Enforcement is deny-by-default and reviewed as sound. The module ships an access
control handler for the records themselves and a **query-access** layer (built on
the contrib Entity API) that injects matching conditions into queries against the
target entity type — so a user with no matching record simply sees no rows, with
nothing leaking. A route requirement (`_access_record`) lets other routes demand
that the current user hold a matching record. Every operation is permission-gated,
and all of the module's permissions are marked as restricted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Entity API module) and enable it.
2. [Configuration](configuration/index.md) — create a record type, add matching
   fields, grant permissions and create records.

## Where it lives in the admin menu

- Record **types** are managed at **Structure → Access record types**
  (`/admin/structure/access-record`).
- The record **overviews** (subjects, targets, and subjects-and-targets) live
  under **Content → Access records**
  (`/admin/content/access-record/{subjects,targets,subjects-targets}`), and need
  the *Access access_record overview* permission.
