# DROWL Admin — manual setup guide

**DROWL Admin** (`drowl_admin`) is a small collection of backend and
admin‑toolbar tweaks from the German Drupal agency DROWL. It applies a handful of
modifications and fixes to the Drupal administration experience — the kind of
polish that makes the admin backend a little nicer to work in — and it is meant
to sit underneath the other `drowl_*` modules (such as
[DROWL Layouts](../../drowl_layouts/4.2.x/human-docs/index.md) and
[DROWL Paragraphs](../../drowl_paragraphs/4.2.x/human-docs/index.md)),
improving how their controls appear on administration pages.

It is worth being blunt about this up front, because the module's own project
page is: **DROWL Admin is not useful on its own.** It exists to support the rest
of the DROWL feature set. If you are not already running one or more other
`drowl_*` modules, there is little reason to install it. Its only hard dependency
is core's **Layout Builder** (`layout_builder`), which Drupal will enable for you.

There is nothing to configure. The module works the moment you enable it — the
admin/backend modifications and toolbar fixes are applied automatically, and it
does not change content or access in any way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form and
requires no setup beyond enabling it.

## Where it lives in the admin menu

DROWL Admin adds no admin page of its own. Once enabled, its backend and
admin‑toolbar improvements are simply active across the administration UI.
