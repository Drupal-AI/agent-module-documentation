# SULA Eligibility Calculator — manual setup guide

**SULA Eligibility Calculator** (`sula_calculator`) gives your site a small,
self-service tool that helps students estimate their SULA (Subsidized Usage
Limit Applies) student-loan eligibility right on the page. It ships as two
configurable blocks — a **Credit** calculator and a **Clock/time** calculator —
each of which runs the numbers with AJAX, so a visitor gets a result without the
page reloading.

The problem it solves is a familiar one for financial-aid and enrollment pages:
students often need a quick, ballpark answer about whether their subsidized loan
usage is running low, and pointing them at a dense policy document rarely helps.
This module lets you drop an interactive estimator next to your enrollment
content instead. The calculations are driven by configurable academic-year
length values, so you can tune the tool to match how your institution counts
usage.

The module does not do anything until you place one of its blocks — enabling it
alone changes nothing visible. Once a block is placed and (optionally) its
parameters are adjusted, visitors can use the calculator immediately. It depends
only on core's **Block** module, and it ships no submodules. The version 2.x
release rebuilt the form markup around Bootstrap 5 classes; the module works
without a Bootstrap theme, but a Bootstrap 5-based theme is needed for the layout
to look its best.

This guide is written for a **human** placing and configuring the blocks through
the admin UI. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they are terser and cheaper to
consume.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the calculator blocks and tune
   the calculator's parameters.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → System → SULA Calculator**
(`/admin/config/system/sula_calculator`) and is protected by the **Administer
SULA calculator** permission. This is where you adjust the calculator's values.

## How to use it

The calculators surface as blocks. On **Structure → Block layout** you will find
two new blocks — the **SULA credit calculator** and the **SULA clock/time
calculator** — which you place into any region, on any page, with the usual block
visibility rules (per path, per role, and so on). A visitor fills in the form and
the estimate is computed and shown via AJAX, with no page reload.
