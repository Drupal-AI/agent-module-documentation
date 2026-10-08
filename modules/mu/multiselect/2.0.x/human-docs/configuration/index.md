# Configuration

There are two things to set up: **attach the widget to a field** (per field), and
optionally **adjust the global box width** (one site‑wide setting).

## Attach the Multiselect widget to a field

Multiselect is a field widget, chosen per field on the bundle's **Manage form
display** page:

1. Go to the bundle's Manage form display — for a content type, that's
   **Structure → Content types → [your type] → Manage form display**
   (e.g. `/admin/structure/types/manage/article/form-display`).
2. Find the field you want and, in its **Widget** column, choose **Multiselect**.
3. Click **Save**.

The widget is offered for these field types:

- **List (text)** — `list_string`
- **List (integer)** — `list_integer`
- **List (float)** — `list_float`
- **Entity reference**

On the form, the field now renders as the two‑box Available / Selected selector
with Add and Remove buttons. (The second box only appears when the field has more
than one allowed option.) The widget has no per‑field settings of its own beyond
core's size hint.

## Set the global box width

The module has a single site‑wide setting: the width of the two select boxes, in
pixels.

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Multiselect**
   (`/admin/config/content/multiselect`).
3. Set **Width of Select Boxes (in pixels)** — the default is **250**. Widen it
   (say to 400) if your option labels are long, or narrow it to save space.
4. Click **Save configuration**.

The value applies to every Multiselect widget on the site. To read or set it from
the command line:

```bash
drush config:get multiselect.settings multiselect.widths
drush config:set multiselect.settings multiselect.widths 400 -y
```

Because the setting lives in the `multiselect.settings` config object, it is
exported and deployed like any other configuration.
