# Configuration

Simple Add More works with no configuration at all — everything here is optional.
There are two things you can adjust: the **labels and help text** on a settings
form, and a **per‑widget opt‑out**.

## Customise the labels and help text

1. Go to **Configuration → Content authoring → Simple Add More Settings**
   (`/admin/config/content/simple-add-more-settings`). You need the **Administer
   sam** permission (see below).
2. Edit any of the four fields — all are required:

| Field | Default | What it does |
|---|---|---|
| **Add another item label** | `Add another item` | The label of the button that reveals one more empty element. |
| **Remove label** | `Remove` | The label of the per‑row button that clears a value. |
| **Help text (singular)** | `@count additional item can be added` | The help text shown when exactly one more item can be added. Use `@count` as the placeholder for the remaining count. |
| **Help text (plural)** | `@count additional items can be added` | The help text shown when more than one item can be added. Again, `@count` is the remaining count. |

3. Click **Save configuration**. These strings are passed to the JavaScript, and
   they export/deploy with `drush config:export` like any other configuration.

## Turn the behaviour off for a specific widget

Sometimes you want a particular field to keep showing all its empty rows. You can
opt an individual widget out:

1. Go to the bundle's **Manage form display** (for example
   **Structure → Content types → *Article* → Manage form display**).
2. Click the **gear icon** on the field's widget to open its settings.
3. Tick **"Skip 'Simple Add More' simplification"**, then **Update** and **Save**.

That widget will now render all of its empty elements the way core normally does.
(This opt‑out lives on the Manage form display screen, so it is gated by the normal
*administer form display* permissions, not by the Simple Add More permission.)

## When Simple Add More acts

For orientation, the simplification is applied to a widget only when **all** of
these are true:

- The field's cardinality is **greater than one** but not unlimited (single‑value
  and unlimited fields are skipped).
- The widget is **not** marked "Skip simplification".
- The widget's type is on the supported list — text, textarea (including text with
  summary), email, number, telephone, path, uri, link, link‑attributes,
  entity‑reference autocomplete, and Linkit.

Developers can add more widget types to that list with
`hook_sam_allowed_widget_types_alter()` (see the [`agent/`](../agent/start.md)
docs).

## Permission

The module defines a single permission, **Administer sam**, which controls access
to the settings form above. It is marked as a trusted/administrative permission.
The simplification behaviour itself is not permission‑gated — it applies wherever a
supported field is rendered.

```bash
drush role:perm:add content_admin 'administer sam'
```
