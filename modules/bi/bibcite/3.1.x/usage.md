<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation (bibcite) is the core API of the Bibcite suite: it renders bibliographic data as formatted citations using Citation Style Language (CSL) styles, and defines the pluggable processor and import/export format systems the submodules build on.

---

The core module itself stores no bibliographic content — that is the job of the `bibcite_entity`
submodule. Bibcite core provides: a **CSL style** config entity (`bibcite_csl_style`) plus five
shipped styles (APA, Chicago author-date, MLA, MLA 8th, AMA); a global settings object
`bibcite.settings` choosing the citation **processor** (`processor`, default `citeproc-php`), the
**default CSL style** (`default_style`, default `apa`) and whether to linkify URLs
(`convert_urls`); and the `bibcite.citation_styler` service that renders a CSL data array to an
HTML citation via the selected processor and style. It defines two **plugin types**:
`bibcite_processor` (annotation/attribute plugins that turn CSL + data into a citation string —
the only shipped one is `citeproc-php`, wrapping the seboettg/citeproc-php library) and
`bibcite_format` (YAML-declared import/export formats whose `encoder` class implements Symfony's
Encoder/Decoder — provided by the bibtex/endnote/marc/ris submodules). A `bibcite.human_name_parser`
service (adci/full-name-parser) splits author names, and a format param-converter resolves
`{bibcite_format}` route slugs. Admin lives under `/admin/config/bibcite` (permission
`administer bibcite`), including a CSL styles collection where custom `.csl` files can be uploaded.

---

- Render a bibliographic record as an APA / MLA / Chicago / AMA formatted citation.
- Choose the site-wide default citation style used when none is specified.
- Install a custom CSL style by uploading a `.csl` file from the 8000+ official CSL repository.
- Switch the citation processor implementation via the `processor` setting.
- Programmatically style a CSL data array with `bibcite.citation_styler->render($data)`.
- Render the same reference in multiple styles by setting the styler's style per call.
- Provide the plugin framework that bibtex/endnote/marc/ris formats plug into for import/export.
- Define a custom `bibcite_processor` plugin to use a different citation engine.
- Add a new import/export format by declaring a `bibcite_format` plugin with an encoder.
- Parse a human author name into prefix/first/last/suffix parts via the name-parser service.
- Linkify URLs inside rendered citations with the `convert_urls` setting.
- Manage CSL styles (add/edit/delete/enable) at `/admin/config/bibcite/settings/csl_style`.
- Localize citation rendering by passing a language code to the styler.
- Fall back gracefully on references with malformed dates (invalid date fields are stripped).
- Provide the `administer bibcite` permission gate for all Bibcite configuration.
- Serve as the shared dependency for the Bibcite entity, export, import and format submodules.
- Set a per-request citation style without changing the stored default.
- Integrate scholarly citation rendering into custom themes/templates via the styler service.
- Supply the CSL style config entity used to store both shipped and uploaded styles.
- Back a references bibliography page whose entries are rendered through the chosen CSL style.
