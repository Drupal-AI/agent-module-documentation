<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flickr Integration Suite Field adds a field so a Flickr photoset or stream can be attached to a content item.

---

This is the option to choose when the Flickr content belongs to a specific piece of content rather than to the site. An event with its photo gallery, an exhibition with its documentation, a news item with a photoset — in each case the relationship is between one entity and one set of photos, and a field is how Drupal models that.

The consequences of using a field are the ones you want here. The value is part of the content, so it is revisioned with it, translated with it if the content is translatable, exported and imported with it, and visible in Views. Display is a Manage-display decision, so a teaser can show a thumbnail and the full view a gallery.

It is also the option that puts the choice in the editor's hands rather than the site builder's — which is right when the answer differs per item and wrong when it should be uniform.

---

- Attach a photoset to an event.
- Document an exhibition with Flickr photos.
- Add a gallery to a news item.
- Let editors choose photos per item.
- Revision the photo reference with the content.
- Translate content carrying a Flickr field.
- Export content with its photo reference.
- Show a thumbnail in a teaser.
- Show a full gallery in the full view.
- Expose the field in a View.
- Vary display per view mode.
- Require a photoset on a content type.
- Migrate existing photo references into a field.
- Audit which content references Flickr.
- Keep photo association with the content it belongs to.