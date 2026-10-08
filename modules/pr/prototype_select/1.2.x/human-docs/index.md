# Prototype Select — manual setup guide

**Prototype Select** (`prototype_select`) provides accessible enhancements to native
HTML `<select>` elements. It improves the usability and accessibility of dropdowns —
adding keyboard and screen‑reader support and styling — while keeping them standard
select elements rather than replacing them with a heavy custom widget. It implements
the "Select A11y" pattern.

This is a purely accessibility‑positive, front‑end enhancement. It touches how form
select widgets look and behave; it has no content and no access‑control role, and it
requires no other modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Enable
it, and it enhances the relevant select elements.
