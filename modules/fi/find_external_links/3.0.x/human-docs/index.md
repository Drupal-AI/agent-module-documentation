# Find External Links — manual setup guide

**Find External Links** (`find_external_links`) scans your node content for
outbound (external) links and collects them into an admin report. It parses the
HTML of the node fields you choose, pulls out every `<a href>` that points off your
site, and lists each external URL together with the content type and node it came
from — with a link straight to the source node. It's built for auditing outbound
links: broken or unwanted third-party links, SEO and compliance reviews, or
enforcing a link policy. It has no third-party dependencies.

You control which fields get scanned and which domains to ignore on the settings
page, then run the scan as a batch process. Each run rebuilds the list from
scratch, so the report always reflects your latest content. Results appear in a
paged, sortable table. Access is restricted by a dedicated admin permission.

One useful reassurance: despite the name, the module only *parses stored content*.
It does not make any server-side HTTP request to the URLs it finds, so it doesn't
fetch or follow external links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: which fields to
   scan and which domains to ignore, then running the scan and reading the report.

## Where it lives in the admin menu

Find External Links lives under **Configuration → System**:

- **Settings:** **Configuration → System → Find external links**
  (`/admin/config/system/find-external-links`).
- **Report:** the results list at
  `/admin/config/system/find-external-links/list`.

Both pages are gated by the module's **administer find external links** permission.
