<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Moderation state columns adds a Views style plugin that arranges moderated content into columns, one per workflow state, giving editorial teams a Kanban-style board of their content.

---

It targets sites using core Content Moderation. You build a View of moderated entities as usual, then choose the "Moderation state columns" format. In the style settings you pick a **Workflow** and which of its **states** to show as columns (an AJAX callback refreshes the state list when the workflow changes). At render time, `template_preprocess_views_view_moderation_state_columns()` walks each result row, finds the moderated entity, confirms it belongs to the chosen workflow, buckets its rendered markup under its current `moderation_state`, and JSON-encodes the states plus per-state rendered rows into the template. A bundled JS library (`view_display`) reads that JSON and draws the columns; cache tags from the workflow and each entity are merged in for correct invalidation.

Because it is a Views style, access is entirely governed by the View's own access settings and by each entity's access — the plugin renders rows Views already resolved. There are no routes, permissions, services, or write operations. Typical setup: create a View listing your moderated nodes (add the moderation-state filter for the states you want), set the format to Moderation state columns, select the workflow and states, and save.
---
- Show moderated content as a Kanban-style board of state columns
- Give editors an at-a-glance view of what is Draft vs Published vs Archived
- Build an editorial dashboard per content type
- Choose exactly which workflow states become columns
- Bind the board to a specific Content Moderation workflow
- Combine with Views filters to scope the board (author, type, date)
- Render each item using a Views row plugin (fields or entity)
- Reflect custom workflow states as custom columns
- Track content moving through an editorial pipeline visually
- Add a review queue board for content awaiting approval
- Use per-workflow boards on multi-workflow sites
- Cache correctly via workflow + entity cache tags
- Provide reviewers a focused list of items in one state
- Present a publishing calendar-style overview by state
- Restrict who sees the board through the View's access settings
- Hide states you do not want as columns while keeping filters
