Focal Point lets editors click the single most important spot on an image so that every automatically-cropped derivative (thumbnails, teasers, responsive variants) keeps that spot in frame instead of blindly cropping from the center.

---

Focal Point extends Drupal's image field and Image Styles so that a content author can mark a focal point directly on the image upload widget — a draggable crosshair overlaid on the preview. The chosen point is stored as a relative X,Y percentage using the Crop API (the `crop` module), so it survives image replacement and is independent of the original dimensions. Three image effects ship with the module — Focal Point Crop, Focal Point Crop by width/height, and Focal Point Scale and Crop — which you add to any Image Style; when Drupal generates a derivative it crops around the saved focal point rather than the geometric center. A preview dialog shows the editor how the image will look across every image style that uses a focal-point effect. The module integrates with the core Image widget and the Media Library upload form, and provides migrate source/process plugins for importing legacy focal-point data. It depends on core Image and the contrib Crop module, and requires no manual configuration beyond adding the effects to your image styles. This is the standard solution for keeping faces and key subjects centered across responsive breakpoints and art-directed crops.

---

- Keep a person's face in frame across every thumbnail size.
- Let editors set the important area of a hero/banner image.
- Crop landscape source images to square avatars without cutting off heads.
- Drive art-directed responsive image variants that all respect one focal point.
- Replace center-cropping with subject-aware cropping site-wide.
- Add a Focal Point Crop effect to an existing Image Style.
- Add a Focal Point Scale and Crop effect for fixed-dimension teasers.
- Add a Focal Point Crop by width/height effect for aspect-ratio crops.
- Preview how an image will crop in all styles before publishing.
- Store the focal point as a percentage so it survives image re-upload.
- Set focal points on images uploaded through the Media Library.
- Provide consistent product photo crops in a commerce catalog.
- Ensure logos and infographics are not cropped through their key element.
- Give news teasers subject-focused thumbnails automatically.
- Fine-tune the crop point via a draggable crosshair widget.
- Enter an exact X,Y focal value by hand for precise control.
- Migrate legacy focal-point/imagefield_focus data with migrate plugins.
- Reuse a single uploaded image at many sizes without manual re-cropping.
- Keep decorative background images centered on their subject.
- Support IMCE-inserted images with focal-point-aware crops.
- Generate square, portrait, and landscape derivatives from one source.
- Programmatically create/update a crop entity for a file via the manager service.
- Validate focal-point coordinate input in custom code.
- Maintain visual consistency in card grids and listing pages.
- Improve perceived quality of automatically generated thumbnails.
