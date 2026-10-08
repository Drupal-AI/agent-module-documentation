# Configuration

Taxonomy Depth Widget is configured entirely per field, in the form display —
there is no global settings page. You set which depth (or range of depths) of
the vocabulary a term‑reference field should offer.

## Set the depth on a field

1. Log in as a user who can administer the entity type (an administrator by
   default).
2. Go to **Structure → [your entity type, e.g. Content types → Article] →
   Manage form display**, or the equivalent Manage form display screen for the
   entity that carries the field.
3. Find your **taxonomy term‑reference field** in the list. Make sure its widget
   is one this module supports — a **select list** or **checkboxes / radio
   buttons** widget.
4. Click the **gear / settings** icon at the end of that field's row to open the
   widget settings.
5. Choose the **depth**, or a **range of depths**, that the field should offer.
   Depth is counted from the top of the vocabulary: the root terms are the
   shallowest level, and deeper levels are their children, grandchildren, and so
   on. For a "leaves only" setup on a three‑level tree, for example, you would
   restrict the field to the deepest level; to allow a band of levels, set a
   range.
6. Click **Update** to close the widget settings, then **Save** the form display.

## What happens next

When someone creates or edits content with that field, the widget now lists only
the terms at the depth (or within the range) you selected — so, on a country →
region → city vocabulary restricted to the deepest level, only cities are
offered.

Remember the two caveats from the [main guide](../index.md): this only shapes
*this* form widget (other write paths can still store any term, so use a field
constraint if you need it enforced), and it assumes the vocabulary's branches
are all the same depth — on an uneven tree a fixed depth rule will hide the
leaves of the shallower branches.
