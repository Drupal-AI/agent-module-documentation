# Contribution Records — manual setup guide

**Contribution Records** (`contribution_records`) provides the contribution‑records
system used by the new www.drupal.org site. It stores contribution records and
credits — for both individuals and organizations — as structured content, kept
separate from the actual issues they relate to (whether those live on
www.drupal.org or GitLab). Each record is modelled as structured content built on
**Paragraphs**, with integration into the **drupalorg** module.

This is a very specialised module. It is designed for the drupal.org site itself
and **assumes the surrounding www.drupal.org site configuration already exists** —
particular content types, fields, and views that the module expects to be present.
It is not a general‑purpose contribution tracker you would drop onto an arbitrary
Drupal site; outside the drupal.org context it will not have the environment it
needs. Administration of records is gated by the `administer contribution records`
permission.

It depends on the **Paragraphs** module, core **Node**, and the **drupalorg**
module, and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (within a drupal.org‑style environment).

There is **no standalone settings page** for this module; it relies on the
surrounding site's content types, fields, and views, as described in "How to use
it" below.

## Where it lives in the admin menu

The module does not add a general configuration form. Records are managed as
content, and access to administer them is controlled by the **administer
contribution records** permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Ensure you are working within an environment that provides the www.drupal.org
   site configuration the module expects (content types, fields, views).
2. Enable the module and its dependencies (see [Installation](installation/index.md)).
3. At **People → Permissions**, grant **administer contribution records** to the
   roles that should manage records.
4. Create and manage contribution records as structured content, capturing credits
   for individuals and organizations separately from the underlying issues.
