# Signature Field — manual setup guide

**Signature Field** (`signaturefield`) provides a **signature form element and
field type**: a canvas where a person draws a signature with the mouse or a touch
device, which is then stored as field data or as a generated PNG file. It builds
on the Signature Pad library and is meant for the everyday need to capture a
signature — an agreement, a consent, a delivery confirmation — in a way that works
on touchscreens.

Under the hood it ships a `Signature` form element, field types (including a
file-backed variant that saves a PNG), widgets, a formatter, and a converter that
turns the drawn strokes into a PNG image. Its display name is "Signature Field"
and its machine name is `signaturefield`; it is one of several signature modules,
distinguished by being pure field-and-element machinery rather than a set of
standalone endpoints.

That design is worth calling out as a strength. The module has **no routes and no
controllers** — there are no AJAX endpoints that accept and save signatures out of
band. A signature is captured and stored only through the normal entity form and
field save path, so it inherits standard field and entity **access control**: a
signature is written only when a user who can edit the entity saves it. That
avoids the unauthenticated-write problems that have affected some other signature
modules. Be clear-eyed, though, about what a drawn signature *means* — it is
evidence of intent, not a cryptographic signature. It does not authenticate the
signer or bind a document, and a stored PNG is only as trustworthy as the access
controls on the entity that holds it. Treat it as a UX artifact for consent and
agreement flows, protect the entities that carry signatures with appropriate
permissions, and do not rely on it as a legal or cryptographic guarantee.

The module has no dependencies and no submodules, and no third-party libraries to
download.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page. You add the signature capability as a field:

1. On the content type (or other entity) where you want a signature, add a new
   field of the **Signature** type — or the file-backed signature type if you want
   the drawing persisted as a PNG file.
2. On the entity's **Manage form display**, the signature field shows the drawing
   canvas widget so users can sign with mouse or touch.
3. On **Manage display**, use the module's formatter to render the stored
   signature.

Because everything happens through the standard field save path, protect the
signing form and the entities that carry signatures with the permissions
appropriate to your content.
