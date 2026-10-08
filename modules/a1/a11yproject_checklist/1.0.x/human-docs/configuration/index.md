# Configuration

This module has no settings form of its own — its "configuration" is the
checklist itself, provided through the Checklist API module. This page explains
where it lives, how to use it, and how access is controlled.

## Open the checklist

1. Log in as a user who has Checklist API's permission to edit the checklist.
2. Go to **Configuration → Development → A11Y Project Checklist**, or navigate
   directly to `/admin/config/development/a11y-project-checklist`.

You'll see the list of accessibility tasks sourced from The A11Y Project. Each
item has a title, a short description, a **WCAG reference**, and a link to the
relevant handbook page for remediation guidance.

## Using the checklist

- **Tick off** items as your team completes them and **Save** the form. Checklist
  API records which user checked each item and when, and shows an overall
  percent-complete figure you can share with stakeholders.
- Because progress is stored, you can return to it across releases — use it as an
  audit worksheet at launch, an onboarding aid for authors learning
  accessibility, or a visible remediation backlog.
- A built-in **tour** walks through the checklist UI the first time.
- If other Checklist API checklists are installed (an SEO checklist, say), they
  appear alongside this one in the same admin area.

## Permissions

Access is governed entirely by **Checklist API's** own permission — this module
adds none of its own. On **People → Permissions**, grant the Checklist API
permission (to edit/complete checklists) to the roles that should be able to
work through the accessibility list, typically editors and site builders.

## Refreshing the item data

The checklist items are fetched from The A11Y Project over HTTP when the list is
built, so the site needs outbound HTTP access. To pull the latest set of tasks,
rebuild caches:

```bash
drush cr
```

If the fetch fails (no outbound connection, remote unavailable), the failure is
logged and the checklist renders empty — clear caches to try again once
connectivity is restored.
