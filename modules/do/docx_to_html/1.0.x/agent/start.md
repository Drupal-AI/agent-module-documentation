<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOCX to HTML Converter (docx_to_html) — agent index

A single admin **tool page** that converts a user-selected Word `.docx` into HTML **entirely in the
browser** with the bundled **Mammoth.js**, so an author can copy the result and paste it into a
rich-text field. Package `Content authoring tool`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0 (dir 1.0.x). **No module dependencies**, no composer `require`, no entities, no
plugins, no services, no config form, no config schema, no Drush.

- **The page, its route/permission, the controller, template and front-end library, and how to use
  it** → [config/converter-page.md](config/converter-page.md)

## What it actually provides (from source)

- **Route** `docx_to_html.page` (`docx_to_html.routing.yml`): path `/docx-to-html`, controller
  `\Drupal\docx_to_html\Controller\DocxToHtmlController::content`, requirement
  `_permission: 'access docx to html converter'`. Also the module's `configure` link.
- **Permission** `access docx to html converter` (`docx_to_html.permissions.yml`), title
  *"Access DOCX to HTML Converter"*.
- **Controller** `DocxToHtmlController::content()` (`src/Controller/DocxToHtmlController.php`) —
  returns `['#theme' => 'docx_to_html_page', '#attached' => ['library' => ['docx_to_html/docx_to_html']]]`.
  No request/file handling of any kind.
- **Theme hook** `docx_to_html_page` (`docx_to_html_theme()` in `docx_to_html.module`) →
  template `templates/docx-to-html-page.html.twig` (a `<input type="file" id="document">`, a
  `#copy-button`, and an empty `#output` div).
- **Menu links** (`docx_to_html.links.menu.yml`): `docx_to_html.admin` under
  `system.admin_config_content`, and `docx_to_html.shortcut` under `system.admin`.
- **Asset library** `docx_to_html/docx_to_html` (`docx_to_html.libraries.yml`): CSS
  `css/docx_to_html.css`; JS `js/mammoth.browser.min.js` (vendored Mammoth 1.8.0) + `js/docx_to_html.js`;
  depends on `core/jquery`, `core/drupal`, `core/once`, `core/drupal.message`.

## Mechanism (client-side only)

- `js/docx_to_html.js` (`Drupal.behaviors.docxToHtml`) binds a `change` handler on `#document` and a
  click handler on `#copy-button` via `core/once`.
- On file select it checks `file.type === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'`
  (rejects anything else with an error message), reads the file with `FileReader.readAsArrayBuffer`,
  then calls `mammoth.convertToHtml({ arrayBuffer })` in the browser.
- The converted HTML is placed into `#output` and shown; the copy button uses a `Range` selection +
  `document.execCommand('copy')` to put it on the clipboard.
- **There is no server upload, no server-side file parsing, no config, and no persistence** — the
  document never leaves the author's browser.

## Notes

- `composer.json` is mis-filled by the author: its `description` is a copy-paste about a FullCalendar
  view plugin and it declares `license: BSD-2-Clause` and no `require`. The real license is
  GPL-2.0-or-later (`LICENSE.txt`, GNU GPL v2) per Drupal.org policy; there are no PHP dependencies.
- Ships PHPUnit FunctionalJavascript tests under `tests/` (`DocxToHtmlTest`, `DocxToHtmlSecurityTest`)
  plus fixture files, including an anonymous-access-denied assertion.
