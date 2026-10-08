# Broken Configuration — manual setup guide

**Broken Configuration** (`broken_config`) is a diagnostic tool that scans your
site's active configuration and reports entries that are broken or invalid — for
example configuration that references a module, plugin, or dependency that is no
longer present. It helps operators find and fix configuration problems before they
turn into runtime errors.

It is a read‑only, developer/operations aid: it inspects configuration and reports
what looks wrong, but it does not change anything itself. Running the scan is gated
by its own **Scan broken configuration** permission, so only trusted users can use
it. It depends on core's **Configuration Manager** (`config`) and supports Drupal
10 and 11.

This is useful after upgrades, module removals, or configuration imports, when
stale references can linger and cause hard‑to‑trace errors. Use it to get a list of
problematic configuration, then fix or remove those entries yourself.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

The module adds a scan gated by the **Scan broken configuration** permission
(`scan broken configuration`), which you grant under **People → Permissions**
(`/admin/people/permissions`). There is no settings form to fill in — it is a
diagnostic you run, not something you configure.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the **Scan broken configuration** permission to the administrator/operator
   role that should be allowed to run the scan.
3. Run the scan and review the reported broken or invalid configuration entries,
   then fix or remove them. Because the module only reads configuration, it is safe
   to run without risk of changing anything.
