<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DOCX to HTML converter page

## Install & enable

```bash
composer require drupal/docx_to_html
drush en docx_to_html -y
```

No module dependencies, no external PHP/JS libraries to install — Mammoth.js is vendored in the
module. There is **no settings form** and **no config object**; the `configure` link simply points at
the tool page itself.

## Access it

- URL: **`/docx-to-html`**.
- Admin menu: *Administration → Configuration → Content authoring → DOCX to HTML Converter*
  (menu link `docx_to_html.admin`, parent `system.admin_config_content`). A second link
  `docx_to_html.shortcut` sits under `system.admin`.
- **Permission required:** `access docx to html converter` (*"Access DOCX to HTML Converter"*).
  Grant it to the roles that should use the tool at *People → Permissions*. Anonymous users without
  it get an access-denied page (asserted by `DocxToHtmlTest::testAccessAsAnonymous`).

## Route & controller

`docx_to_html.routing.yml`:

```yaml
docx_to_html.page:
  path: '/docx-to-html'
  defaults:
    _controller: '\Drupal\docx_to_html\Controller\DocxToHtmlController::content'
    _title: 'DOCX to HTML Converter'
  requirements:
    _permission: 'access docx to html converter'
```

`DocxToHtmlController::content()` (`src/Controller/DocxToHtmlController.php`) is a one-method
`ControllerBase` subclass. It returns only a render array — it does **not** read the request, handle
uploads, or touch the filesystem:

```php
return [
  '#theme' => 'docx_to_html_page',
  '#attached' => ['library' => ['docx_to_html/docx_to_html']],
];
```

The `docx_to_html_page` theme hook (`docx_to_html_theme()` in `docx_to_html.module`) renders
`templates/docx-to-html-page.html.twig`: a `<input type="file" id="document">`, a "Copy the HTML"
`#copy-button`, and an empty `<div id="output">`.

## Front-end library

`docx_to_html.libraries.yml` defines `docx_to_html/docx_to_html`:

- CSS: `css/docx_to_html.css` (hides `#output` and `#copy-button` until a conversion runs).
- JS: `js/mammoth.browser.min.js` (vendored **Mammoth.js 1.8.0**) and `js/docx_to_html.js`.
- Dependencies: `core/jquery`, `core/drupal`, `core/once`, `core/drupal.message`.

## How conversion works (all in the browser)

`js/docx_to_html.js` (`Drupal.behaviors.docxToHtml`):

1. `once()` binds a `change` listener to `#document` and a `click` listener to `#copy-button`.
2. `handleFileSelect()` reads `event.target.files[0]`; if the MIME type is not
   `application/vnd.openxmlformats-officedocument.wordprocessingml.document` it shows an error
   (*"Invalid file type. Please choose a DOCX file."*) and stops.
3. `readFileInputEventAsArrayBuffer()` uses a `FileReader` (`readAsArrayBuffer`) to get the bytes,
   then `mammoth.convertToHtml({ arrayBuffer })` produces HTML **in the browser**.
4. `displayResult()` puts the HTML into `#output`, surfaces any Mammoth messages as warnings via
   `Drupal.Message`, and reveals `#output` and `#copy-button`.
5. `copyToClipboard()` selects the `#output` contents with a `Range` and runs
   `document.execCommand('copy')`.

The document never leaves the client: there is no AJAX call, no form submission, and nothing is
written server-side. The author then pastes the copied HTML into a long-text field. Because target
Drupal text formats apply their own tag/attribute filtering, what survives depends on the chosen
format (e.g. CKEditor 5 / Full HTML / Basic HTML restrictions), not on this module.

## Tests

`tests/src/FunctionalJavascript/` ships `DocxToHtmlTest` (valid conversion + copy, anonymous access
denied) and `DocxToHtmlSecurityTest` (invalid-type rejection and conversion of a crafted document),
with fixtures under `tests/files/`.
