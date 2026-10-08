# Configuration

Open the settings at **Configuration → Media → File MIME Type Enforcer**
(`/admin/config/media/file-mime-type-enforcer`). The form is designed to be edited
in **JSON**, mapping each supported file extension to the content-based MIME types
you are willing to accept for it.

## Allowed MIME mappings

For each file extension, list the MIME type(s) that fileinfo may legitimately
detect from the content. The enforcer accepts an upload when the extension's
guessed type and the content-detected type agree, or when the detected type is one
you have explicitly allowed for that extension in this mapping.

This matters because some valid files genuinely report a content type that differs
from their extension. Rather than loosening the check globally, you add a specific,
documented exception for that extension — keeping the protection tight everywhere
else.

## Strict vs permissive mode

The module offers two modes:

- **Strict mode** — reject any upload whose content does not match its extension
  (and is not covered by an allowed mapping). This is the protective setting for
  production.
- **Permissive mode** — allow the upload but **log** the mismatch. Useful when you
  are first rolling the module out and want to discover which legitimate files
  would be blocked, so you can add the right mappings before switching to strict.

## Auditing existing files

The module ships a **Drush command** that scans files already stored on the system
for extension/content mismatches. It writes log entries for any failed validations
and can display them on screen, so you can find pre-existing problem files that
were uploaded before the module was in place. Run it from your project root (prefix
with `ddev` on DDEV).

## How it fits with core

File MIME Type Enforcer is a **security-positive** layer, not a replacement for
Drupal's own upload controls. Keep using core's per-field allowed-extensions list,
store uploads on the private scheme where appropriate, and ensure your server does
not execute uploaded files. The enforcer adds the content-vs-extension check that
those measures don't provide on their own.
