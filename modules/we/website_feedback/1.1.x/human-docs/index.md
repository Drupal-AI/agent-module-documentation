# Website Feedback — manual setup guide

**Website Feedback** (`website_feedback`) adds a site‑wide floating **Feedback**
button that opens a short form so people can send you feedback, support requests,
or bug reports — optionally with a screenshot of the page they were looking at,
captured right in their browser. Each submission is stored on your own site as a
`website_feedback` content entity, so it is a self‑hosted alternative to embedding
a third‑party feedback widget or SaaS tool.

The button never shows up for everyone by default. It is attached to pages only
for users who hold the **create website feedback** permission, so you decide which
roles see it — a QA team, editors, all logged‑in users, or even anonymous
visitors. When someone submits the form, the module records which URL they were on
(from the browser's Referer header), lets them pick a type (Feedback, Support
request, or Bug report), optionally tag it with taxonomy terms, and optionally
attach a screenshot generated client‑side by the html2canvas library. Screenshots
load html2canvas from the jsDelivr CDN by default, or from a local copy if you
prefer.

Staff review everything in an admin listing at
`/admin/content/website-feedback`, where a Views‑based collection offers bulk
**Resolve**, **Unresolve**, and **Delete** actions so you can run a simple triage
workflow. The module depends only on core's **Text** and **Image** modules and
ships with a settings form for tuning the button and form. Five permissions gate
the whole workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission that shows the button.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus how permissions and the admin listing fit together.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Website
Feedback settings** (`/admin/config/development/website-feedback`). Submissions are
managed under **Content** at `/admin/content/website-feedback`, and new items can
be added directly at `/admin/content/website-feedback/add`.

## How to use it

Enabling the module alone does not put the button on your site — nothing appears
until you grant the **create website feedback** permission to a role. Once you do,
members of that role see the floating **Feedback** button on every page. They
click it, fill in a summary and description, optionally pick a type, add tags, and
capture a screenshot, then submit. The item appears in the admin listing for your
team to work through and mark **Resolved** when handled.
