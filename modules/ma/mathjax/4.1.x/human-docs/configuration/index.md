# Configuration

MathJax has two things to set up: the **settings form** (how and from where the
library loads, and which mode it runs in) and, in the recommended mode, the
**MathJax filter** on a text format.

## Open the settings form

1. Log in as a user with the **Administer MathJax** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → MathJax**, or navigate directly to
   `/admin/config/content/mathjax`.

The form has a built-in test block so you can confirm the library is loading once
you save.

## The settings, field by field

### Use a CDN

A checkbox, **on** by default. When ticked, MathJax loads from the external URL
below. Untick it to load a local copy from `/libraries/MathJax` instead (see
[Serving the library locally](#serving-the-library-locally)).

### CDN URL

The external script URL. The default points at the cdnjs **MathJax 2.7.0**
`TeX-AMS-MML_HTMLorMML` bundle. You can edit this to pin a specific version, but
keep it on a **2.x** build — the module's re-typesetting JavaScript uses the
MathJax 2 API, and a 3.x/4.x URL will load but break AJAX re-typesetting and
ignore the `?config=` parameter.

### Configuration type

A choice of two modes:

- **Text Format** *(default, recommended)* — MathJax attaches nothing globally.
  Instead you add the *MathJax* filter to a text format (see below), and only
  content using that format is typeset. Everything else on the page is left alone.
- **Custom** — MathJax is attached to **every** page and the whole page is scanned
  for maths. No filter is needed. This mode uses the custom configuration string
  below.

### Custom MathJax configuration (JSON)

Only used in **Custom** mode. A JSON blob that is assigned to the browser's
`window.MathJax` object before the library loads — this is where you set your own
delimiters, extensions, message style, and so on. In Text Format mode the module
uses its own default configuration instead (inline `$…$` and `\(…\)`, display
`$$…$$` and `\[…\]`).

### Enable MathJax for admin pages

A checkbox, **off** by default, and only relevant in **Custom** mode. Off keeps
MathJax off admin routes (so it does not slow the editorial UI); tick it if you
are building a page that needs to preview formulas inside the admin area.

## Save and clear caches

Click **Save configuration**. The form rebuilds all caches for you on submit,
which is necessary because the library URL is baked into a cached library
definition. (If you ever change these values with `drush cset` instead of the
form, run a cache rebuild yourself afterwards or the old URL sticks around.)

## Adding the MathJax filter (Text Format mode)

In the default Text Format mode, this is the step that actually turns maths on:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format you want maths in — for example **Full HTML**.
3. Under **Enabled filters**, tick **MathJax**.
4. Scroll to **Filter processing order** and drag **MathJax** to the **bottom**
   of the list. This matters: filters that clean up or limit HTML can otherwise
   run afterwards and mangle the maths delimiters or MathJax's wrapper markup.
5. Save the format.

Now any field using that format will have its maths typeset. Which visitors see
typeset maths is decided purely by their access to that text format — MathJax has
no separate "view" permission.

## Serving the library locally

If you cannot use a CDN:

1. Download MathJax (a 2.x release) and unpack it so the file
   `/libraries/MathJax/MathJax.js` exists in your docroot.
2. On the settings form, untick **Use a CDN** and save.

If the local file is missing, Drupal's **Status report**
(`/admin/reports/status`) shows an error ("Missing JavaScript libraries") so you
can spot the problem.

## Who can change these settings

The whole form is gated by the single **Administer MathJax** permission, which is
marked as a restricted/trusted permission. Because the custom configuration
string is injected verbatim into the page's JavaScript, granting this permission
effectively lets someone add arbitrary JavaScript configuration — so give it only
to administrators you trust.
