# Hooks

Declared in `webform_image_select.api.php`. Both let you alter the image options for an
image-select element at render time.

## `hook_webform_image_select_images_alter(&$images, &$element, $images_id = NULL)`
Alter the images for any image-select element. `$images` is the associative array of options,
`$element` the element render array, `$images_id` the `webform_image_select_images` entity id
(or NULL when the images are defined inline on the element). Use it to add/remove/reorder
options globally or inject dynamic images.

## `hook_webform_image_select_images_WEBFORM_IMAGE_SELECT_IMAGES_ID_alter(&$images, &$element)`
Same, but scoped to one specific image set — replace `WEBFORM_IMAGE_SELECT_IMAGES_ID` with the
set's machine name (e.g. `..._dogs_alter`). Fires only for that set.

Typical uses: pull image options from an external source, filter by user role/permission, or
localize labels. Return nothing; mutate `$images` by reference.
