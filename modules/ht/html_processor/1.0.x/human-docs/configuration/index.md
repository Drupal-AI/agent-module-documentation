# Configuration

HTML Processor works entirely from code without any configuration — but the settings
form lets you save a **default pipeline** that's applied automatically when a call
doesn't specify its own options. Defaults are opt‑in, and **explicit options passed
in code always override** what you set here.

## Open the settings form

1. Log in as a user with the **Administer HTML Processor settings** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → HTML Processor**.

## The default pipeline settings

The form mirrors the stages of the processing pipeline. Set the defaults you want,
and leave the rest off:

- **Container / content extraction** — the CSS selector(s) that identify the part of
  the HTML to keep (for example `article, #main-content`); everything outside the
  match is dropped. This is precise, but review your selectors if a source site
  changes its markup.
- **Remove ads and boilerplate** — enable the built‑in patterns that strip common
  ad‑network and boilerplate markup, and add your own patterns if needed.
- **Regex stripping** — remove unwanted fragments with regular expressions. These are
  **admin‑trusted only** and guarded against ReDoS — never build them from anonymous
  input.
- **Rewrite links/images to absolute URLs** — turn relative `href`/`src` values into
  absolute ones so links and images keep working once the HTML is moved out of its
  original context.
- **Sanitize** — filter elements and attributes through the Symfony HTML Sanitizer.
  These settings decide what markup is allowed to survive, so they are central to
  XSS safety — review them carefully.
- **Output shaping** — optionally **wrap** the result as a full HTML document, or
  **minify** it.

Save the form to store your default pipeline.

## Tips

- **Heading for Markdown?** Turn **minify off** (it breaks code blocks) and keep
  sanitization **light** to preserve structure for the converter.
- **Container extraction** relies on explicit CSS selectors — accurate, but check
  them periodically if you process a site whose markup you don't control.
- **Never** feed the regex‑stripping or ad‑pattern configuration from untrusted or
  anonymous input; those features assume an administrator wrote them.
