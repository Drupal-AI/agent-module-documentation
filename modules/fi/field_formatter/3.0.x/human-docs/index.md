# Field formatter — manual setup guide

**Field formatter** (`field_formatter`) is a small collection of display
formatters that let you show a **single field from a referenced entity**, or
**wrap a field's output in a link** to the entity it belongs to. It's aimed at
sites that use entity references (and Paragraphs-style *entity reference
revisions*) and want fine control over what appears on a page without building a
custom formatter by hand.

For example, imagine an Article that references an Author entity. With core's
default formatters you'd render the whole author teaser or just its label. With
this module you can render *just the author's photo field*, or *just their
biography*, right inside the article's display — and optionally turn it into a
link back to the article. That's the idea behind all three formatters it adds.

Everything is configured on the standard **Manage display** page, exactly like
any other field formatter — there is no separate settings screen. You pick one
of the module's formatters from the **Format** dropdown for a field and set its
options inline.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central configuration page. You use the module's formatters on each
bundle's **Manage display** page — for example, for the Article content type:
**Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

On a Manage display page, change a field's **Format** dropdown to one of the
three formatters this module adds, then click the gear icon to set its options.

**1. Field formatter with inline settings** — for entity reference and entity
reference revisions fields. Choose *one* field of the referenced entity to
display, then configure that inner field's own formatter right there (an
AJAX-driven picker walks you through Field → Formatter → that formatter's
settings). Options include the referenced field's **label** position and a
**Link to the parent entity** checkbox.

**2. Field formatter from view display** — also for entity reference and entity
reference revisions fields. Instead of configuring the inner formatter yourself,
this reuses the formatting a referenced field already has in a chosen **view
mode** (for example *Teaser*). Pick the view mode and the single field to keep;
the module borrows that view mode's formatting for just that field. It also
offers the **Link to the parent entity** checkbox.

**3. Field linker** — works with *every* field type. It renders the field with
whatever inner formatter you choose, then wraps each rendered item in a link to
the host entity's own page. (It can't wrap itself, so Field linker isn't offered
as its own inner formatter.)

About the **Link to the parent entity** option (formatters 1 and 2): when
checked, each rendered item links to the *parent/host* entity's canonical page
rather than to the referenced entity, without adding any extra wrapper markup. It
only takes effect for field output that supports a URL.

Once you've picked a formatter and its settings, click **Update**, then **Save**.
For developers, the module also ships two abstract base classes
(`FieldFormatterBase` and `FieldWrapperBase`) you can subclass to build your own
single-field or wrapping formatters — see the
[`agent/`](../agent/extend/base-classes.md) docs for details.
