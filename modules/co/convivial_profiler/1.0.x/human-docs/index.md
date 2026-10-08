# Convivial Profiler — manual setup guide

**Convivial Profiler** (`convivial_profiler`) provides visitor personalization and
profiling. It builds a behavioral profile of a visitor — the interests and actions
they show as they move around your site — so you can personalize the content and
experience they see. It is part of the Convivial toolkit from Morpht and depends
on the **Convivial Core** (`convivial_core`) module.

The module does not do anything until you configure it: there is a settings form
where you define how profiles are built and where consent is handled. Because
profiling collects **behavioral and personal data**, this is a privacy‑significant
feature. Depending on where the profile is built (in the browser and/or on the
server) and where it is stored, you must disclose the profiling in your privacy
policy, obtain **consent** where the law requires it (profiling and tracking are
regulated under GDPR and ePrivacy), and give visitors a way to opt out. Avoid
profiling sensitive categories of data. The module has no access‑control role
beyond its own permission — it decides what a visitor *sees*, not what they are
*permitted* to do.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Convivial Core.
2. [Configuration](configuration/index.md) — set the profiler and consent options.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → Convivial → Profiler**
(`/admin/config/convivial/profiler`), where you set all of its options.
