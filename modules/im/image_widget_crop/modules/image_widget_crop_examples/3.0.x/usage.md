Demo submodule of ImageWidgetCrop that installs a ready-made "Crop test" content type, crop types, image styles and displays so you can see the crop widget working out of the box.

---

`image_widget_crop_examples` is a learning/reference submodule, not something you enable in production. Installing it creates an example content type wired up with the ImageWidgetCrop widget across several scenarios: a plain image field, images inside Media, images embedded through Entity Browser, and images added via Inline Entity Form. It also ships example crop types and matching responsive image styles so the crops actually render. Because of that it pulls in a broad set of dependencies (media, responsive_image, entity_browser, inline_entity_form, ctools). Use it to explore configuration, copy the form-display and image-style setup into your own site, or reproduce issues for bug reports. Uninstall it once you have seen how the pieces fit together.

---

- See the crop widget working immediately after install without manual setup.
- Study a working form-display configuration for the crop widget.
- Learn how crop types map to responsive image styles.
- Explore cropping inside Media entities.
- Explore cropping through Entity Browser.
- Explore cropping inside Inline Entity Form.
- Copy example image styles into a real project.
- Demonstrate ImageWidgetCrop to stakeholders or clients.
- Reproduce a bug on a clean, known configuration for an issue report.
- Compare your own broken setup against a working reference.
- Teach editors how the crop UI behaves.
- Prototype art-directed responsive images quickly.
- Test upgrade behaviour of the crop widget on sample content.
- Verify Cropper library loading in your environment.
- Bootstrap a demo site for training sessions.
