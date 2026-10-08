# Configuration

There is no global settings page. You enable the soft-hyphen feature **per text
format**, and it takes two coordinated steps on each format — plus a possible third if
you restrict allowed HTML.

## Set it up on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   **CKEditor 5** (for example *Full HTML*).
2. In the **Toolbar configuration**, drag the **Soft hyphen** button from *Available
   buttons* into the *Active toolbar*.
3. In the **Enabled filters** list, tick **Cleanup SHY markup**.
4. Save.

> **Order matters — the gotcha.** The Soft hyphen button will **not appear** in the
> editor until the *Cleanup SHY markup* filter is enabled on the *same* format. The
> CKEditor plugin declares a dependency on that filter, so if the button seems to be
> missing, check that the filter is ticked.

## If you limit allowed HTML

If the format also has **Limit allowed HTML tags and correct faulty HTML**
(`filter_html`) enabled, add the `class` attribute to `<span>` in the *Allowed HTML
tags* list — i.e. include `<span class>`. This is only needed so that **legacy**
content authored with the old `<span class="shy">` markup survives filtering. New
content uses the `<shy>` element, which the CKEditor plugin registers as allowed
automatically.

## How it behaves once set up

- In the editor, clicking the **Soft hyphen** button (or pressing **Ctrl+Hyphen**)
  inserts a soft hyphen at the cursor. It's stored as a `<shy>` element in the saved
  content.
- On output, the **Cleanup SHY markup** filter replaces every `<shy>` (and any legacy
  `<span class="shy">`) with the real UTF-8 soft-hyphen character. That character is
  invisible unless the browser actually breaks the word at that point, in which case a
  hyphen appears.

Enable the button and filter only on the formats where you want editors to have this
control — it doesn't affect any other format.

## What gets saved

Setting this up only changes core configuration — the format's filter settings
(`filter.format.<id>`) and the CKEditor 5 toolbar (`editor.editor.<id>`). The module
itself ships no configuration of its own.
