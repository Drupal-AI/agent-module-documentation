# Content Entity Clone — manual setup guide

**Content Entity Clone** (`content_entity_clone`) adds a **Clone** action to your
content entities — nodes, taxonomy terms, media, comments, custom entities — so editors
can duplicate an item and tweak the copy instead of rebuilding it from scratch. You
decide, per bundle, whether cloning is available and which fields are carried over into
the new copy.

You switch cloning on from an admin overview that lists your entity types and bundles.
For each bundle you enable, you set the label for the clone link and, field by field,
choose a **field processor** that decides how that field's value is handled when
cloning. The shipped processors cover the common cases: copy the value as-is, append
" [CLONE]" to the title so copies are obvious, deep-clone referenced entities instead
of reusing them, or copy a Layout Builder layout. Only the fields you list are carried
over — anything you leave out starts blank on the copy.

When an editor with the right permission views an enabled entity, a **Clone** operation
and local task appear. Clicking it opens the normal entity creation form, pre-filled
with the processed values, as a new **unsaved** entity — so the editor reviews the copy
and saves it deliberately. That makes it safe: nothing is duplicated behind their back.

For developers, the field-processor system is a real plugin type, so you can write your
own processor (say, to uppercase a field or reset a URL alias) and it will appear as a
choice in the bundle settings; a hook also lets other modules alter the available
processors. Access is controlled by two permissions — one to configure cloning, one to
actually clone.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the config-object shape and the FieldProcessor plugin API —
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable cloning per bundle, choose field
   processors, and grant the permissions.

## Where it lives in the admin menu

The clone overview sits at **Configuration → Content Entity Clone**
(`/admin/config/content_entity_clone`). The **Clone** action itself appears on the
entities you have enabled it for — in their operations list and as a local task tab.
