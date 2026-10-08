# Configuration

Launch Checklist has no traditional settings form — the "configuration" is the
checklist itself, provided through Checklist API. You open it, work through the
items, and save; Checklist API records who ticked what and when.

## Open the checklist

1. Log in as a user with permission to edit the checklist. Checklist API grants
   these per checklist — typically an *edit the Launch Checklist* permission for
   ticking items and a *view the Launch Checklist report* permission for reading
   the progress report. Grant them at **People → Permissions**
   (`/admin/people/permissions`).
2. Open the **Launch Checklist** from the **Configuration** area (route
   `checklistapi.checklists.launch_checklist`), where it appears among your
   site's checklists.

## Working through the checklist

- The checklist is organised into **14 sections**. Expand a section to see its
  items.
- Each **item** has a short description and helpful links so you can complete the
  task or verify it is already done — for example checking robots.txt, confirming
  analytics is installed, submitting the sitemap, turning off error display,
  configuring cron, changing the install‑time admin password, or setting the 404
  and 403 pages.
- Tick the checkbox for each item you have genuinely completed or verified.

## Save and the audit trail

Click **Save** to store your progress. When you save, Checklist API records **the
date/time and the user** against each item you checked — that is what makes the
list an audit trail rather than a disposable to‑do. The saved state can be
exported with **Configuration synchronization** and committed to version control
alongside the rest of your site config.

## Get the most from it

- **Treat it as a memory aid, not a test.** Ticking an item records a claim; a
  site with every box checked can still be broken. The items worth keeping are the
  ones someone actually verifies.
- **Tailor the list to your organisation.** The shipped checklist is a starting
  point. The items that catch real problems are the ones you add after a launch
  goes wrong, so maintain it over time — that is where the value compounds.
