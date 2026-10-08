# Configuration

Field Widget Layout is configured in two places: the **per‑field widths** on each
form display (this is where the real work happens), and a small **global settings
form** for module‑wide behaviour.

## Per‑field widths (Manage form display)

This is the main way you use FWL.

1. Log in as a user who can administer the entity's display (an administrator by
   default).
2. Go to **Structure → Content types (or any fieldable bundle) → *(bundle)* →
   Manage form display**.
3. For the field you want to size, click the gear/edit icon at the end of its row
   to open the widget settings. You will see two FWL inputs:
   - **Width in %** — the field's width as a percentage of the form row. Give two
     fields `50` each to place them side by side; use `33` for three‑up rows, and
     so on. Fields flow onto the same row until their widths fill it, then wrap.
   - **Maximum width in px** — an optional cap so a field never grows wider than a
     set pixel value, even when its percentage would allow it. Handy for keeping
     short inputs (a postcode, a year) from stretching across a wide monitor.
       Leave it empty for no cap.
4. Click **Update**, then **Save** the form display. The chosen values also appear
   in the widget's settings summary so you can see the layout at a glance.

Repeat for the other fields on the row. Because these are stored as third‑party
settings on the form display config, they are included when you export
configuration.

## Global settings form

A module‑wide settings form lives at **`/admin/config/fwl`** and requires the
**Administer site configuration** permission. It controls FWL's overall
behaviour; adjust it only if you need to change how the module applies widths
site‑wide. For most sites the defaults are fine and all the per‑form layout work
happens on Manage form display above.

## Save

After changing per‑field widths, always **Save** the Manage form display screen;
after changing the global form, click **Save configuration**. Reload an edit form
to see the new layout take effect.
