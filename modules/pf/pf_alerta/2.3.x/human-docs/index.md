# Push Framework Alerta — manual setup guide

**Push Framework Alerta** (`pf_alerta`) adds an **Alerta channel** to the
[Push Framework](https://www.drupal.org/project/push_framework). Push Framework is
the module that abstracts sending notifications over pluggable channels; this
add‑on lets those notifications be delivered to your own **Alerta** instance —
Alerta being a well‑known open‑source alert dashboard whose strength is
**deduplicating** alerts so a flood of repeated notifications collapses into a
single, manageable entry.

The typical use case is operational awareness. Site administrators want to know
when important things happen on their site, but don't want to be buried under
duplicate messages. Pointed at Alerta, this channel gives them a single dashboard
where those signals are deduplicated. It pairs especially well with **DANSE** —
enable the **DANSE Log** submodule and every log entry above your chosen error
threshold gets pushed to Alerta, surfacing the errors (from real issues or
poorly‑tested third‑party modules) that would otherwise go unnoticed.

This is a notifications/integration add‑on with **no access‑control role**. If
your Alerta instance requires an **API key or credentials**, treat them as
**secrets** — store them via the environment or the Key module and make sure the
channel talks to Alerta over **HTTPS**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Push Framework.
2. [Configuration](configuration/index.md) — point the Alerta channel at your
   Alerta instance and enable it in the Push Framework.

## Where it lives in the admin menu

Alerta is one **channel** within the Push Framework, so you manage it from the
Push Framework's configuration (under **Configuration → System → Push
framework**), where you enable the Alerta channel and supply your Alerta
connection details. See [Configuration](configuration/index.md).
