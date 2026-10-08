# Configuration

CKEditor Spacing has no central settings page. All of its setup happens **per
text format**, at **Administration → Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`). Because it is configured
per format, you can offer more spacing options on a full-featured format and less
on a restricted one.

There are **two required steps** — the toolbar button and the filter — plus some
optional per-format tuning. Both required steps matter: if you add the button but
skip the filter, the editor will appear to work but published pages will show no
spacing at all.

## 1. Add the Spacing toolbar button

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors** and
   click **Configure** next to a format that uses CKEditor 5 (for example *Full
   HTML* or *Basic HTML*).
3. In the **Toolbar configuration**, drag the **Spacing** button from *Available
   buttons* up into the *Active toolbar*.

## 2. Enable and order the filter

In the same format's configuration form:

1. Under **Enabled filters**, tick **"Apply spacing to block elements"**.
2. Open **Filter processing order** and drag that filter so it runs **after**
   **"Limit allowed HTML tags and correct faulty HTML"**. Order matters here —
   the spacing filter needs to run after the allowed-HTML filter so the
   data attributes it relies on survive.
3. Click **Save configuration**.

## Per-format plugin settings

With the button in place, the format's **CKEditor 5 plugin settings** section
gains options for Spacing. These let you decide how much freedom editors get on
this particular format:

- **Units offered** — choose which units editors may pick from (px, rem, em, %,
  vw, vh). A restricted format might expose only a couple; a full format can offer
  all of them.
- **Horizontal padding** — control whether horizontal padding is offered at all
  on this format.

Editors always type free numeric values (not a fixed scale), so the per-format
settings govern the *units* and *which controls* appear, not preset sizes.

## A note on safety

Spacing never enables the `style` attribute on your text format, so a restricted
format stays restricted. Values are validated by the same grammar in JavaScript
and PHP, and rejected server-side if they are negative, use `calc()`, use an
unknown unit, or look like an injection attempt — the value is never concatenated
into CSS unparsed. This is why the module exists: it gives editors the one-off
spacing they need without opening the door to arbitrary inline CSS.
