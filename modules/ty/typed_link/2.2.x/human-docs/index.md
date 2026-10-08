# Typed Link — manual setup guide

**Typed Link** (`typed_link`) is a field type: a normal Drupal link (a URL plus optional
link text) with one extra ingredient — a **link type** chosen from a list you define. Each
link an editor adds gets tagged with a category such as *PDF*, *Video*, *External site*, or
*Download*, and you can use that category to drive theming: show a PDF icon for PDF links,
style external links differently, turn call‑to‑action links into buttons, and so on. The
original use case was linking to files on an external CDN and tagging each with an asset
type, but it's useful anywhere you want categorised links.

Under the hood it extends core's Link field, so it inherits everything Link does — internal
and external URL validation, the "link text disabled/optional/required" setting, and the
standard link formatter options like `rel="nofollow"` and `target="_blank"`. The "type" part
works exactly like a core **List (text)** field: you define the allowed types as `key|label`
pairs (or supply them from a callback) in the field's storage settings. Editors then pick a
type from a dropdown whenever they enter a URL, and the front end shows the human‑readable
label next to the rendered link. Because the type is stored in an indexed column, you can
also filter or group entities by link category in Views.

There is no global settings page and no permissions — everything is configured per field on
the field's settings, **Manage form display**, and **Manage display** tabs. It has no
submodules and depends only on core's **Field**, **Link**, and **Options** modules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

Typed Link has no admin page of its own. You add and configure a Typed Link field on a
fieldable bundle — for content types that's **Structure → Content types → [type] → Manage
fields / Manage form display / Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. **Add the field.** On a content type (or any fieldable entity), add a field of type
   **Typed Link**.
3. **Define the allowed link types.** In the field's *storage* settings (the same form a
   *List (text)* field uses), enter your types as `key|label` pairs, for example:
   ```
   pdf|PDF document
   video|Video
   external|External site
   ```
   The keys are stored on each link; the labels are what editors and visitors see. You can
   instead populate the list dynamically by naming an *allowed values function*.
4. **Set the field (instance) options.** These are the standard core Link options — for
   example whether link text is disabled, optional, or required.
5. **Configure the widget** (on **Manage form display**). The Typed Link widget shows the
   usual URL and link‑text inputs plus a **link type** dropdown. The dropdown becomes
   required as soon as an editor fills in the URL. You can set placeholder text for the URL
   and title inputs.
6. **Configure the display** (on **Manage display**). The Typed Link formatter renders the
   link as normal and appends the selected type's label. If a type was later removed from the
   allowed list, it falls back to showing the raw stored value. You also get the inherited
   core link formatter settings — trim length, show URL as plain text, `rel`, `target`, and so
   on.

That's the whole workflow. Style your links from the type value in your theme (the label or
the stored key), and use the indexed type column to filter link lists in Views.
