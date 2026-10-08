# Eulerian TacJS — manual setup guide

**Eulerian TacJS** (`eulerian_tacjs`) connects the **Eulerian** analytics
integration to the **TacJS** consent‑managed tag loader. It registers Eulerian as a
service within TacJS, so the Eulerian tracking tag is loaded **according to the
visitor's consent** rather than firing unconditionally.

It is a small bridge module: it depends on both the **Eulerian** module (which
provides the tracking itself) and the **TacJS** module (which manages consent and
loads tags accordingly). Once all three are in place, Eulerian tracking becomes a
consent‑gated service in your TacJS setup.

From a privacy standpoint this is exactly what you want: the third‑party Eulerian
tracking tag runs in visitors' browsers and processes analytics data, so gating it
behind consent (and disclosing it in your privacy policy) helps meet GDPR/ePrivacy
obligations. The module has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Eulerian + TacJS dependencies.

This module has **no settings form of its own** — it registers Eulerian with TacJS,
and the settings live in the Eulerian and TacJS modules, described in "How to use
it" below.

## How to use it

1. Configure the **Eulerian** module with your Eulerian domain and tracking options
   (see the Eulerian module's own guide).
2. Set up the **TacJS** consent manager — its consent banner and the categories that
   control which services may load.
3. With **Eulerian TacJS** enabled, Eulerian appears as a service managed by TacJS.
   Confirm it is assigned to the appropriate consent category so the Eulerian tag
   loads only after the visitor consents.
4. Test as an anonymous visitor: the Eulerian tag should **not** load until consent
   is given, and should load once it is.
