# Opquast Checklist — manual setup guide

**Opquast Checklist** (`opquast_checklist`) adds a ready‑made checklist of the
**Opquast web‑quality best practices** to your Drupal site. Opquast is a
widely‑recognised, openly‑licensed (Creative Commons BY‑SA) set of around 240 rules
covering quality, accessibility, SEO, privacy, performance and user experience,
organised into themes such as Alternatives, Code, Contents, E‑Commerce, Forms,
Hyperlinks, Navigation, Presentation, Security and Confidentiality, and more.

The module presents those rules through the **Checklist API**, so your team can work
through them, tick off the ones the site already follows, and record progress over
time. It is purely a **quality‑assurance and governance aid**: it records status and
gives you a repeatable reference to audit against — it does **not** change your site
or enforce anything. You use it alongside the actual implementation work.

Each rule links back to the Opquast website, so if you don't understand a rule or
aren't sure how to implement it, you can click through for the full explanation. The
module is available in English and French.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Checklist API dependency.

There is **no configuration page** for this module — it has no settings form. You
work with it entirely from its report page, described below.

## Where it lives in the admin menu

Once enabled, the checklist appears under **Reports → Checklists → Opquast
Checklist** (`/admin/reports/checklistapi/opquast`).

## How to use it

1. Go to **Reports → Checklists → Opquast Checklist**.
2. Work down the themed list and **check the boxes** for the best practices your
   site already implements.
3. **Remember to save your progress** before leaving the page — the checklist stores
   what you have completed so you can pick up where you left off and report on
   compliance later.
4. If a rule is unclear, follow its link to the Opquast website for the full
   guidance on how to satisfy it.

Treat this as a living record you revisit as the site evolves, not a one‑time task.
