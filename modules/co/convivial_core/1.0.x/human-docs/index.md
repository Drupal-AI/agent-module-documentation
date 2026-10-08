# Convivial Core — manual setup guide

**Convivial Core** (`convivial_core`) provides the shared base functionality and
APIs for the **Convivial CXP** — the customer‑experience platform and toolkit from
Morpht. It bundles common services, configuration, and helpers that other Convivial
modules (such as Convivial Enricher and Convivial Profiler) build on. On its own it
is plumbing: you probably won't install it deliberately unless another Convivial
module requires it.

Because it is a base/framework module, it does not add end‑user features of its
own. It provides its own permission and a configuration page where the Convivial
options are set, but the meaningful behaviour comes from the Convivial components
that depend on it. It requires no modules outside Drupal core and runs on Drupal
9.5 through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — where the Convivial configuration
   options live.

## Where it lives in the admin menu

Once enabled, the Convivial configuration lives at **Configuration → Convivial**
(`/admin/config/convivial`), where you set the options for the Convivial stack.
