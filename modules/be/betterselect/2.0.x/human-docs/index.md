# Better Select — manual setup guide

**Better Select** (`betterselect`) replaces Drupal's default multiple-select
HTML element with a styled list of checkboxes. Native multi-select boxes are
awkward — you have to Ctrl/Cmd-click to pick several options, and long lists are
hard to scan. Better Select renders those same multi-value options as stylized
checkboxes instead, which are easier to read and select.

It is a form-widget / theming enhancement and has no content or access-control
role of its own. It has no module dependencies. (It does declare its own
permission and config schema, but there is no dedicated settings page to fill
in.)

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Better Select applies to multi-value fields whose widget is a select element.
To use it, edit the field's widget under **Manage form display** for the
relevant entity — for a content type that is **Structure → Content types →
*(your type)* → Manage form display**
(`/admin/structure/types/manage/{type}/form-display`) — and choose the Better
Select widget for the multi-value field. The options then render as stylized
checkboxes on the edit form. There is no separate configuration page to visit.
