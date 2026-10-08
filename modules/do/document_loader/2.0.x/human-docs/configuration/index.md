# Configuration

Document Loader's own configuration is small and framework-level: you tell it, for
each **loader type**, which concrete **loader plugin** should handle it, and you can
try loading a document to confirm everything works. The heavy lifting of parsing a
particular format lives in the individual loader plugin modules, most of which are
configured entirely in code and have no form of their own.

To reach the settings, you need the **`document_loader.administer`** permission
(grant it at **People → Permissions** to trusted roles only).

## Open the settings page

Go to **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`). This is the module's configure route
(`document_loader.settings_form`).

## Map loader types to plugins

Document Loader groups loaders by *type* and lets you choose a **default loader
plugin** for each type. This is what lets a consumer ask for "load this document"
without caring which specific plugin does the work — the mapping decides. Set the
defaults here to point each loader type at the plugin you installed for it (for
example, pointing the PDF type at the PDF Parser plugin). If you have only one
plugin capable of a given type, that mapping is usually straightforward.

## Test loading a document

The same page lets you **test out loading your own documents** — a quick way to
confirm a plugin is installed correctly and producing the normalized output you
expect (text, HTML, Markdown, JSON, and so on, depending on the plugin). Use this
after installing or changing a loader plugin before you wire it into a real
pipeline.

## Good to know

- **Most loader plugins have no admin form.** Modules such as PDF Parser, PHPWord,
  HTML Processor, and the Webpage/API loaders are configured programmatically —
  their processing options are passed in code, not through this page. Once enabled,
  they simply appear here as available plugins.
- **Access follows content.** When you load a document, its content is read and
  normalized into a new form. If the source was access-restricted, remember that the
  extracted content may now live somewhere with different access rules — understand
  where it ends up before ingesting private material.
- **Keep parsers patched.** The extraction is done by third-party libraries inside
  the loader plugins (for PDF and Office formats especially). These parsers are a
  known attack surface, so keep the plugin modules and their libraries up to date.
