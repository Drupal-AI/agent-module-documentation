# FlowDrop Gin — manual setup guide

**FlowDrop Gin** (`flowdrop_gin`) makes the **FlowDrop** interface feel native inside
the **Gin** admin theme. It automatically maps FlowDrop's design tokens to Gin's accent
colours and synchronises dark mode, so the FlowDrop workflow builder and its dashboard
components — stat cards, action links, content cards — pick up Gin's look in both light
and dark appearances.

This is a purely presentational integration. It aligns styling and nothing else: it
has no content, no permissions, and no access role of its own. If you run FlowDrop on a
site themed with Gin, enabling this module removes the visual mismatch between the two.

It works the moment you enable it — there is **nothing to configure**. Just make sure
Gin is your admin theme and FlowDrop is installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   alongside FlowDrop and the Gin theme.

There is **no configuration page** for this module — it applies its styling
automatically. Gin itself is configured at its own settings page, and FlowDrop at its
own; this module simply bridges the two.
