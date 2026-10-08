# IEF Complex Widget Dialog — manual setup guide

**IEF Complex Widget Dialog** (`ief_popup`) improves the editing experience of the
Inline Entity Form module. When you use IEF's **Complex** widget to edit
referenced entities inside a host form, its add, edit, duplicate, remove, and
"add existing" sub-forms normally expand *inline*, pushing the rest of the form
down the page. This module makes those sub-forms open as a centred **modal popup**
instead — with a styled title bar, an overlay, and a close button — so editors get
a focused, distraction-free space and the host form stays compact.

It is a purely presentational layer on top of Inline Entity Form. It changes no
data model and adds no fields; it just wraps the existing IEF sub-form in
jQuery-UI-dialog-style markup and shows a contextual title (Add / Edit /
Duplicate / Remove) so editors know which action they are in. You turn it on per
widget with a single checkbox, and turning it off reverts cleanly to stock inline
IEF.

It works with node, block content, taxonomy term, and user host forms, and has a
special case for Layout Builder block configuration forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the popup on a specific field
   widget.

## Where it lives in the admin menu

There is no dedicated settings page and no permission of its own. The one setting
is a checkbox on a field's widget settings, under **Manage form display** for the
relevant entity/bundle — see [Configuration](configuration/index.md).
