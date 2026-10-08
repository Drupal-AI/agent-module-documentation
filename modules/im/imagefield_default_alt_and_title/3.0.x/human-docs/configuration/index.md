# Configuration

The module has two pieces of admin UI that work together: a **settings form**
where you choose where defaults apply, and a **batch page** that fills in
existing content in one pass.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Imagefield Default Alt And
   Title**, or navigate directly to
   `/admin/config/search/imagefield-default-alt-and-title`.

## Settings

The settings let you scope where the module fills in defaults. Rather than
touching every image everywhere, you can specify the exact content type (material
type) that alt and title should be added to, so the automatic behaviour only
applies where you want it. Choose the content type(s) you care about, then save.

After saving, when content of the selected type is created or edited, image
fields whose alt (and title) attributes are left empty are given a default taken
from the entity's title.

> **A note on quality.** The default is the *title of the content*, which
> describes what the image belongs to, not what it depicts. That is a reasonable
> fallback for illustrative photos, but it is not a substitute for a written
> description on images that convey information, and the HTML `title` attribute
> in particular is a tooltip/SEO nicety that assistive technology does not
> reliably announce. Use this to eliminate *empty* alt text, and still write real
> descriptions for meaningful images.

## Backfill existing content (the batch page)

The most valuable part of the module is filling in content that already exists.
From the settings area, open the **batch page**
(`/admin/config/search/imagefield-default-alt-and-title/batch-page`) and start
the batch. It walks through existing content and fills empty alt and title
attributes from each item's title, so a site with thousands of blank image
attributes can be brought up to a baseline in a single operation instead of one
image at a time.

Run the batch once after installing and configuring the module (and again after a
large import if needed). Because it changes stored field values, it is wise to
back up your database first, and to run it on a staging copy if you want to review
the result before applying it to production.
