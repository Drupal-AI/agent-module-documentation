Adds an "Image select" Webform element that lets respondents pick from a grid of images instead of a plain dropdown or radio list.

---

Webform Image Select provides a `webform_image_select` element — a variant of the standard select/options element whose choices are rendered as clickable images with optional titles. Each option maps a value to an image URL, so users choose visually (icons, product photos, avatars, ratings). Image sets can be defined inline on a single element or, more powerfully, stored as reusable `webform_image_select_images` config entities managed at Admin → Structure → Webform → Options → Images, so the same gallery can be shared across forms and exported as configuration. The module ships the element and render-element classes, a config entity type with full add/edit/duplicate/delete/list-builder UI, an autocomplete/filter controller, a JS/CSS library for the picker, and two alter hooks (`hook_webform_image_select_images_alter()` and a per-id variant) for programmatically modifying image lists. It depends only on `webform`, uses the `administer webform` permission for management, and includes a default "dogs" image set as an example.

---

- Let users pick an option by clicking an image instead of a dropdown.
- Build a visual product or plan selector in a form.
- Create an icon-based rating or reaction question.
- Offer avatar or theme selection during signup.
- Present a gallery of choices with titles and thumbnails.
- Define a reusable image set shared across multiple webforms.
- Manage image option sets centrally under Webform → Options → Images.
- Export image sets as configuration for deployment.
- Duplicate an existing image set as a starting point for a new one.
- Support single or multiple image selection on one element.
- Add an image-based "choose your interest" onboarding step.
- Let respondents select a color swatch or pattern visually.
- Replace radio buttons with a more engaging visual picker.
- Filter/search large image sets in the management UI.
- Seed a demo with the bundled "dogs" example image set.
- Alter available images programmatically via `hook_webform_image_select_images_alter()`.
- Modify a specific set's images via the per-id alter hook.
- Localize or theme the image picker via its CSS/JS library.
- Build a survey with picture-based answer options for low-literacy audiences.
- Provide a size/variant selector using product photos.
- Reuse one gallery across contact, order, and feedback forms.
- Restrict image management to users with `administer webform`.
