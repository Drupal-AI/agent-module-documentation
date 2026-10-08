# Supported Image Field — manual setup guide

**Supported Image Field** (`supported_image`) gives you a new image field type that
works just like core's Image field but adds two extra sub-fields: **Caption** and
**Attribution**. It is built for sites that need to display properly credited
images — a photo with a caption underneath and a "Photo by … on …" credit line.

The problem it addresses is that core's Image field gives you *Alt* and *Title* but
nothing for the visible caption and source credit that editorial and photo-heavy
sites need. With Supported Image Field, those two extra pieces travel with the
image itself. Crucially, the **Caption** and **Attribution** sub-fields are
free-form, formatted text fields, so editors get the familiar WYSIWYG tools to
create, link and format the text — which makes it easy to produce the many
different attribution formats real image licenses require (for example a linked
"Source.com/Author", or "'Title' by Author is licensed under License"). Like core's
Alt and Title, each sub-field can be toggled on or off and set required or optional
per field instance, and you can restrict which text formats editors may use in them.

A few things worth knowing: the module **leaves core's Image field type
untouched** — it adds a new field type alongside it rather than replacing it. It
depends on core's **Image** and **Text** modules. Default output uses semantic
`<figure>` / `<figcaption>` markup and can be overridden with a Twig template. It
includes basic Views support, and a bundled **Responsive Supported Image Formatter**
for responsive image styles. Companion modules extend the display further — Image
Delta Formatter support, a baguetteBox.js lightbox formatter, and a Swiper carousel
formatter — each shipped as its own project.

One caveat to keep in mind: because Caption and Attribution are text entered by
editors, they are ordinary user-entered text and should be output safely through
the site's normal text-format filtering. Restrict the allowed text formats on these
sub-fields to what your editors actually need.

This guide is written for a **human** adding and configuring the field through the
admin UI. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Setup is per field, on the entity you want to add images to:

1. Go to **Manage fields** for your content type (or other fieldable entity) and
   **add a field** of type **Supported image**.
2. In the field settings, toggle the **Caption** and **Attribution** sub-fields on
   or off, mark each required or optional, and choose which text formats editors may
   use in them.
3. On the entity's **Manage display** page, pick one of the Supported Image field
   formatters (including the bundled Responsive Supported Image Formatter) to control
   how the image, caption and attribution render.

You can also set caption and attribution content on the field's **default image**,
at either the storage or field-instance level, so a fallback image comes
pre-credited.
