# Entity References Finder — manual setup guide

**Entity References Finder** (`entity_reference_finder`) makes it easy to find
where an entity is used as an entity reference across your site. Point it at an
entity type and bundle — for example an image media bundle — and it reports
which entity-reference fields (and the content types those fields live on) are
configured to point at it, so you can see what could reference an item before you
change or delete it.

The problem it solves is impact assessment. Drupal will let you edit or delete
an entity type that other fields are configured to reference, and you often only
discover the fallout afterwards. This tool turns that into a lookup you can run
first: it reads your field configuration and lists the reference fields targeting
the chosen type/bundle, so restructuring and cleanups become informed decisions.

It provides its own permission and lives in the Administration package. The
report reads only field-configuration entities (not stored content) and is purely
informational. There is no settings form; you simply grant the permission and
visit the report page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is **no configuration page** for this module — it has no settings form.
You use it entirely through its report page, described below.

## Where it lives in the admin menu

The report is at **Reports → Entity Reference Finder**
(`/admin/reports/entity_reference_finder`). Access is governed by the module's
own permission, so grant that at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to run the
report, then open the page and search for references to an entity type.
