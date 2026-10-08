# Filter Format Audit — manual setup guide

**Filter Format Audit** (`filter_format_audit`) is a security/QA tool that scans
your existing content to find where a text (filter) format may be stripping out
tags or attributes. Text formats decide which HTML survives when content is saved
and rendered, and those rules change over time — you tighten a lax format, migrate
content in from another system, or swap one format for another. This module tells
you which content is actually affected before you make a change, so a reformatting
job doesn't silently break markup or expose raw HTML.

You run it as an analysis. Point it at your site, let it work through your content,
and review the report of where each format is used and what it would strip. Then
edit your formats or content, re-run, and repeat until you are happy. It depends
on core's Filter module and on the contributed **Dynamic Entity Reference** module,
and it adds its own permission so only trusted staff can run the audit and read
its results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Dynamic
   Entity Reference dependency) with Composer and enable it.

This module has **no settings form**. It works entirely through its analysis
report, described in "How to use it" below.

## Where it lives in the admin menu

Filter Format Audit adds a report page under **Content**. Once enabled, visit
**Content → Filter format audit** (`/admin/content/filter-format-audit`) to run
and review the analysis. Access is gated by the module's own permission.

## How to use it

1. Log in as a user who has the module's audit permission (grant it under
   **People → Permissions** to the roles that should be allowed to run audits).
2. Go to `/admin/content/filter-format-audit`.
3. Click **Run analysis** and let it work through your content.
4. Review the results — they show where formats are used and what content could be
   affected. Edit your text formats or the content itself as needed.
5. Re-run the analysis and repeat until the results look right.
