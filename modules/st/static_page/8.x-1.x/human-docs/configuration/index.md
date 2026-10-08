# Configuration

Configuring Static Page is a matter of dedicating a content type to it and
pointing the module at the field that holds the page source. The important part is
the security decision that comes with it — read that section before you let anyone
but yourself author static pages.

## Prepare a content type

1. Create (or choose) a content type — for example **Static page** — that has a
   **single text-area field** to store the whole HTML source of the page.
2. Decide the **text format** for that field. This is the safety-critical choice
   (see below).

## Tell the module which types and fields to use

1. Go to **Configuration → Content authoring → Static page**
   (`/admin/config/content/static_page`).
2. Select which content types should act as static pages.
3. For each selected type, choose the single text-area field that holds the static
   page content.
4. Save.

From now on, any node of that type renders its text-area field as the entire page,
bypassing Drupal's theme system. The node **title** is used only in the
administrative interface, not on the rendered page. If the page needs CSS or
JavaScript, put it directly into the markup you enter in the text area.

## The security choice — do not skip this

A content type configured as a static page **bypasses Drupal's regular text
filtering**. That means:

- The rendered page is only ever as safe as the **text format** attached to the
  field. If that format is permissive (for example **Full HTML**), an author can
  put arbitrary markup — including `<script>` — straight into the page. That is a
  stored cross-site-scripting (XSS) capability.
- For anyone who is not a fully trusted author, use a **restricted, filtered text
  format** on the field so dangerous markup is stripped.
- Grant permission to create static-page-enabled content types **only to trusted
  users**. Treat "can author a static page" as equivalent to "can put raw HTML and
  JavaScript on the site."

Used with a sensible format and trusted authors, Static Page is a simple, safe way
to serve hand-written pages. Used with an unfiltered format and untrusted authors,
it hands them raw HTML — so choose deliberately.
