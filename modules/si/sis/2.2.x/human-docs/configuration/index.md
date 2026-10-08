# Configuration

Smart Imaging Styles has a small settings form (the `sis.settings` route under
**Configuration**), but the real work happens on your image displays. There is no
long list of switches to flip — you point image fields at the Smart Imaging Styles
formatter and let its JavaScript do the measuring.

## The general workflow

1. **Enable the module** (see [Installation](../installation/index.md)). It builds
   on core Responsive Image, so having your responsive image styles and breakpoints
   set up the way core expects is a good starting point.
2. **Choose the formatter.** Go to a content type or media type's *Manage display*
   screen (**Structure → Content types → *(your type)* → Manage display**, or the
   equivalent for media), find your image or media field, and select **Smart Imaging
   Styles** as its formatter.
3. **Save and view.** On the front end the module loads a low-resolution placeholder
   first, then measures the real rendered size of the image's parent element and
   swaps in the best-fitting variant for that context. The same image placed in a
   narrow column and a full-width section will now request different, appropriately
   sized derivatives.

## Working with an imaging service (optional)

If you connect an on-the-fly imaging service such as Thumbor or Cloudinary, the
service generates each derivative on demand as the module requests it — which is
what unlocks smart cropping (including face detection) at exactly the size the
layout needs. This is optional; the module also works with the image variants
Drupal already produces.

Because Smart Imaging Styles only governs which image variant is displayed, it adds
no permissions and touches no content or access rules — the only decision to make
is which image displays should use it.
