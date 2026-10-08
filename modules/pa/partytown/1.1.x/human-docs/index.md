# Partytown — manual setup guide

**Partytown** (`partytown`) integrates the [Partytown](https://partytown.builder.io/)
library into Drupal so you can move heavy third‑party scripts — analytics, tag
managers, chat widgets — **off the browser's main thread and into a web worker**.
Those scripts still run, but they no longer compete with your own code for the main
thread, which can meaningfully improve responsiveness metrics such as Interaction
to Next Paint (INP) and Total Blocking Time (TBT). The module takes care of
attaching the Partytown scripts and gives you a **UI to configure** the
integration, so you do not have to wire it up by hand.

It is aimed at exactly one problem: you have a site with failing Core Web Vitals,
you know third‑party scripts are a big part of the blocking time, and you are not
in a position to simply remove those scripts. If that is you, Partytown may help.

> **Worth knowing before you get excited:** Partytown is an experimental technology
> with real trade‑offs — not every third‑party script runs happily inside a web
> worker, and some need extra configuration (or simply cannot be offloaded). Read
> the Partytown project's own "trade‑offs" documentation before rolling this out,
> and test each script you offload. Also note: offloading a script to a worker
> changes *where* it runs, not *what* it does — the privacy and consent
> considerations of your third‑party scripts are unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Partytown JS
   library, then enable it.
2. [Configuration](configuration/index.md) — the getting‑started flow and the
   settings UI for choosing which scripts to offload.

## How to use it

The path to a working setup is three steps: install the module, install the
Partytown JavaScript library, and then send some scripts to Partytown. The first
two are covered in [Installation](installation/index.md); choosing which scripts to
hand over to the web worker is covered in [Configuration](configuration/index.md).
