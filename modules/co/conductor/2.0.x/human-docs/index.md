# Writing Assistant (Conductor) — manual setup guide

**Writing Assistant** (machine name `conductor`) integrates **Conductor** — a
content-writing and SEO optimization platform (Acquia SEO Content Insights) — into
Drupal's authoring experience. It surfaces keyword research, real-time
recommendations, and content-optimization guidance right where your team writes,
so marketers and editors can improve organic search performance without leaving
Drupal.

The module brings Conductor's guidance into **Canvas**, Drupal's experience
builder, so it depends on the **Canvas** module. It also depends on the **Key**
module, which it uses to store your Conductor API credentials securely rather than
in plaintext configuration. You'll need a **Conductor account and API credentials**
(an `api_key` and a `shared_secret`) to use it — the module has no value until those
are entered.

Two things to keep in mind. First, credential handling: because it uses the Key
module, store the Conductor credentials (the `api_key` + `shared_secret` JSON) as a
**Key** (backed by an environment variable or another secure provider), never as
plaintext. Second, data-flow: your
content or topic data may be sent to Conductor's service for analysis, which is a
normal data-handling consideration to review against your policies. The module
provides its own permission and has no access-control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with its Canvas and Key dependencies).
2. [Configuration](configuration/index.md) — store your Conductor API credentials
   with the Key module and connect the assistant.

## Where it lives in the admin menu

After enabling, connect the module by selecting your Conductor credentials Key on
its settings page at **Configuration → System → Services → Writing Assistant
settings** (`/admin/config/services/conductor`, available to users with the
*Conductor SEO* / `administer conductor` permission). Once connected, open a page in
**Canvas** and pick the **Writing Assistant** extension from the left-hand sidebar to
get the writing/SEO guidance. A drafts overview is available under **Reports** at
`/admin/reports/conductor`. See [Configuration](configuration/index.md) for the
credential setup.
