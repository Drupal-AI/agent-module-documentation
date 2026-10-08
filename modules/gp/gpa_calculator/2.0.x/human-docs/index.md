# GPA Calculator — manual setup guide

**GPA Calculator** (`gpa_calculator`) gives schools and universities a ready‑made
**grade point average calculator** to place on their site as a block. A visitor
fills in a small table of courses and computes their GPA on the spot — no page
reload, no back‑end processing. It's aimed at education sites that want to offer
prospective or current students a quick self‑service tool.

The calculator form starts with **six rows** and three columns — *Class/Course
Name*, *Grade* and *Credits Earned* — and visitors can **dynamically add more
rows** as needed. There is also a section for entering a **cumulative (past) GPA
and credits earned**, so the result can factor in prior study rather than only the
courses just entered.

The **Grade** select boxes are configurable: you can define the grade options and
their numeric values, and the module validates that those values are numeric so
the maths comes out right. If you leave the grades setting blank, the select
boxes fall back to a set of built‑in default values.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate site‑wide settings page** — the calculator is placed and
configured as a block, described in "How to use it" below.

## How to use it

1. Enable the module.
2. Go to **Structure → Block layout** and **place** the GPA Calculator block in a
   region on the pages where you want it (for example a "Tools" or "Admissions"
   page).
3. In the block's configuration, optionally set the **grade options** — the labels
   students pick from and the numeric value each represents. Make sure every value
   is numeric so the GPA calculation is correct. Leave it blank to use the
   built‑in default grades.
4. Save the block. Visitors can now enter their courses, add rows as needed, enter
   any cumulative GPA/credits, and see their calculated GPA.

> **Note:** the calculator runs in the browser, so visitors need **JavaScript
> enabled** for it to work.
