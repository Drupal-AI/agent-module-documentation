# Configuration

This module has no traditional settings form. Instead, you configure it in place —
each time you drop its **Field Display** component into a Canvas template, you
choose which field to show and how to render it. All the work happens inside the
Drupal Canvas editor's template and component tooling (the component collection).

## Place a Field Display component

1. In the Canvas editor, open the **template list** and open the template you want
   to edit.
2. Open the **component library** and drag a **Field Display** component into the
   template where you want the field to appear.
3. **Select the field** — choose the field from the current node's (or other
   entity's) content type that you want to display.
4. **Select the formatter** — pick the formatter to render that field, exactly as
   you would on a *Manage display* page (for example an image style for an image
   field, or a date format for a date field).
5. **Configure the formatter settings** — set any options the chosen formatter
   offers. Because the module supports third-party formatter settings, options
   added by modules that extend formatters appear here too.

## Why render through the formatter

The Field Display component sends the field through Drupal's normal formatter
pipeline rather than reimplementing field output. That means image styles and
responsive image styles, date and text formats, entity-reference rendering,
multi-value output, and field-level access all apply automatically — the same
behaviour you would get displaying the field anywhere else on the site.

Save the template in the Canvas editor when you are done; the field renders in the
composed layout immediately.
