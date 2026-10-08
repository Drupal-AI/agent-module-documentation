# Search and Replace — manual setup guide

**Search and Replace** (`snr`) searches your site's database for a string in
entity field content and replaces it in bulk. It is the tool you reach for when
the same text appears in many places and you need to change it everywhere at once
— fixing a repeated typo, updating a brand name site‑wide, rewriting absolute
URLs to relative ones, correcting a file path after moving directories, or
locating how often and where a problem string occurs.

Search‑and‑replace queries operate **directly on the selected database tables and
columns**, and each operation is batched so it scales to large datasets. You can
narrow what gets touched by entity type, bundle, field name, column name, and
field data type, so a replacement can be as broad or as surgical as you need.

This is powerful and, used carelessly, dangerous: it performs bulk, potentially
**irreversible** content modification, and a bad search/replace can corrupt many
pieces of content in one run. The module's own documentation recommends using it
with extreme caution. In practice that means restricting it to trusted
administrators, always taking a backup before running (or using the `snr_safe`
submodule's safer preview mode), and testing your replacement on a small scope
first. The module reads and writes content with the operator's privileges and has
no access‑control role of its own — the safety is entirely in how deliberately
you run it.

It ships one submodule, **`snr_safe`**, which provides a safer/preview mode so you
can see what a replacement would do before committing to it. The module has no
other dependencies or third‑party libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the `snr_safe` preview submodule.

## How to use it

There is no site‑wide settings form. You run a search‑and‑replace as an operation:
you enter the string to find and the replacement, then scope the operation by
entity type, bundle, field name, column name, and/or field data type before
running the batched replacement. Before you run anything for real, back up your
database (or enable `snr_safe` and preview the change), and test on a narrow scope
so you can confirm the result before applying it broadly.
