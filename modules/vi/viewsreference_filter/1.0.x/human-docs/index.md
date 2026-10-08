# Views Reference Field Filter — manual setup guide

**Views Reference Field Filter** (`viewsreference_filter`) extends the
[Views Reference](https://www.drupal.org/project/viewsreference) field so that
content editors can set a referenced view's **exposed filter** values right on the
entity edit form — without ever touching the view itself. When an editor places a
view (in a node, a paragraph, a Layout Builder block, and so on), they can
pre-select a category, an event type, a date range, a search term, or any other
exposed filter, and optionally show that filter form to visitors on the rendered
page.

This makes the classic "same view, different filter" pattern possible with no
custom code. You build one generic view — say "products by taxonomy term" or
"latest articles" — and reuse it in many places, each placement pre-set to
different filter values. A per-placement **Show Filters on Page** checkbox decides
whether the editor's values are fixed (the filter form is hidden and visitors see
the pre-filtered result) or whether visitors get the live exposed form and can
refine the listing themselves.

Technically, the module adds a single *setting plugin* (`exposed_filters`) to the
Views Reference field. It has no admin settings page of its own, no permissions,
and no Drush commands — you switch it on per field, and it rides entirely on the
Views Reference field and widget machinery.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Views Reference module) and enable it.

## Where it lives in the admin menu

There is no central settings page. You enable the feature on each Views Reference
field under **Structure → (your entity type) → Manage fields**, on that field's
settings form. Editors then use it on the normal entity edit form wherever the
field appears.

## How to use it

1. Make sure you have a **Views Reference** field on a bundle (add one under
   *Manage fields* if needed), and that the view it references has **exposed
   filters** on the chosen display — otherwise there is nothing for this module to
   render.
2. Edit that field's settings. Under **Enable extra settings**, tick **Exposed
   Filters - editor view**, and save.
3. Now, on the entity edit form for that field, editors see the referenced view's
   own exposed-filter widgets inline, plus a **Show Filters on Page** checkbox:
   - Leave a widget **blank** to not filter on it (empty values are ignored).
   - With **Show Filters on Page unchecked**, the editor's chosen values are
     applied as fixed filters and the exposed form is hidden from visitors.
   - With **Show Filters on Page checked**, visitors see the live exposed form and
     can override the editor's defaults.

That is the whole workflow — no configuration form, just a per-field toggle and
the familiar filter widgets on the edit form.
