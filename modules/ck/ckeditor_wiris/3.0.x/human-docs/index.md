# CKEditor5 Wiris (MathType/ChemType) — manual setup guide

**CKEditor5 Wiris** (`ckeditor_wiris`) integrates the WIRIS **MathType** and
**ChemType** editors into CKEditor 5, giving content editors a **visual equation
builder** for mathematical and chemical notation. Instead of hand-writing MathML
or LaTeX — or worse, pasting images of equations — authors click a toolbar button,
build the formula visually, and the module stores it as **MathML** in the content.

This matters most on scientific and educational sites. An equation is structured
content: stored as MathML it is searchable, selectable, scalable with the
surrounding text, and readable by screen readers — none of which is true of an
image of an equation. MathType handles mathematics; ChemType handles chemical
notation. The module's only Drupal dependency is core's CKEditor 5.

Two things are essential to understand before adopting it:

- **WIRIS is commercial.** This module is free and open source, but MathType and
  ChemType are commercial WIRIS products. A **valid WIRIS license is required** to
  use them — see <https://www.wiris.com/en/mathtype/> or contact WIRIS sales. The
  module integrates the products; it does not license them.
- **Rendering is separate.** WIRIS generates the equation as MathML but does not
  render it on your published pages. You need a **rendering solution such as
  MathJax** to display formulas to visitors. Also note whether your equation
  rendering is **self-hosted or WIRIS-hosted** — the hosted option means equation
  rendering depends on an external service (an egress/availability consideration).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the MathType/ChemType buttons per
   text format, and set up rendering and licensing.

## Where it lives in the admin menu

CKEditor5 Wiris has no Drupal settings page of its own. You add the **MathType**
and **ChemType** buttons per text format at **Administration → Configuration →
Content authoring → Text formats and editors** (`/admin/config/content/formats`).
Licensing is handled with WIRIS, and rendering is handled by a separate module such
as MathJax — see the configuration guide.
