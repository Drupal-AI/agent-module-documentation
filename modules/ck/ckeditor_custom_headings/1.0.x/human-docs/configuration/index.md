# Configuration

Custom Headings is configured per text format, inside the CKEditor 5 plugin
settings — there is no separate admin page. The custom headings you define become
extra entries in that format's Heading dropdown.

## Enable custom headings on a text format

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   CKEditor 5.
3. In the CKEditor 5 toolbar configuration, make sure the **Heading** button is in
   the *Active toolbar*. The custom‑headings settings only appear when it is.
4. Under **CKEditor 5 plugin settings**, open the new **Headings** tab.
5. Tick **Customize headings** to enable your own heading definitions.

## Define your headings

In the definitions field, add **one heading per line** using this format:

```
h2.custom-heading-2|Custom heading (h2)
```

Each line has three parts:

- **The tag** (required) — for example `h2`, `h3`, `h4`.
- **An optional class**, prefixed with a dot — for example `.custom-heading-2`.
  This becomes the CSS class applied to the heading, letting your theme style it.
- **An optional title**, prefixed with a pipe (`|`) — the friendly label editors
  see in the Heading dropdown, for example `Custom heading (h2)`.

So the example above produces an `<h2 class="custom-heading-2">` element and shows
"Custom heading (h2)" in the dropdown. Add as many lines as you need for the
heading styles your theme supports.

## Allow the markup in the text format

Because these headings carry tags and classes, the format's **Allowed HTML tags**
filter must permit them — both the heading tags and the classes you use (for
example `<h2 class>`), or the filter will strip them on render. Keep the allowed
attributes reasonable and limited to what your headings actually need.

## Save

Click **Save configuration**. Edit a piece of content in that format, open the
Heading dropdown, and your custom heading options should be listed alongside the
standard ones.

---

*This module is based on the `rgpublic/ckeditor_custom_heading` project on GitHub.*
