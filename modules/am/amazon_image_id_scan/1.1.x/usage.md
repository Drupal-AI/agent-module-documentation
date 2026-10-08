Amazon Image ID Scan validates images uploaded through a Drupal image field by sending them to AWS Rekognition and checking the returned labels and OCR text against an admin-defined rule set.

---

The module replaces the core image-field widget with `ImageScanWidget` (plugin id `image_widget`). When content is uploaded, the widget reads the just-saved file, passes the raw bytes to Rekognition's `DetectLabels` (with `Attributes: ALL`) and `DetectText` operations through the bundled `aws/aws-sdk-php` client, and evaluates a named validation profile against the response: the image must contain each configured *positive* label at or above a minimum confidence percentage, must not contain any *negative* label, and the concatenated detected text (with spaces and periods stripped) must match every configured regular expression. Any failed check aborts the upload with a `FormState` validation error carrying the profile's configured error message. Profiles ("tab configs") and the Rekognition access key/secret are edited on the settings form at `/admin/config/amazon_image_id_scan/configuration` (permission `administer site configuration`, menu under Configuration → Media). The Rekognition client is hardwired to region `us-east-1` and API version `latest`. Because the widget extends core's image widget, the module effectively requires the core `image` module and an image field on some entity; a validation profile is bound per view-form widget via the widget's *Config id scan* setting.

---

- Verify that an uploaded national ID card is actually an ID document before accepting a registration.
- Require a passport photo page to be present (positive label "Passport" at high confidence) on a KYC onboarding form.
- Reject selfies or random photos on a document-upload field by requiring a "Document"/"Text" label.
- Confirm a driver's license image contains a license-number pattern via a regex on the OCR'd text.
- Enforce that an uploaded certificate contains an expected keyword or reference code before submission.
- Block screenshots or memes on an identity field by configuring forbidden ("negative") labels such as "Screenshot".
- Validate that a utility-bill image contains a digits-only account number matching a regex.
- Gate a hiring-portal form so applicants must upload an authentic-looking diploma image.
- Add automated first-pass document triage in a government e-procedure form (permits, applications).
- Confirm a uploaded prescription image contains readable text before allowing a restricted-product purchase.
- Require a specific ID type per content type by assigning different validation profiles to different image fields.
- Reject blurry or textless document photos where DetectText returns nothing, prompting the user to retake the photo.
- Enforce a minimum Rekognition confidence threshold (percentage) per required label so low-quality matches fail.
- Localise the rejection message shown to the user per validation rule via each rule's error-description field.
- Build multiple named validation profiles (e.g. "ID card", "Passport", "Certificate") and reuse them across fields.
- Combine positive labels, negative labels and regex checks in one profile for stricter document validation.
- Use the OCR text-extraction path (`DetectText`) to confirm a document number format without storing the number.
- Provide immediate inline feedback at upload time (the check runs during the AJAX upload-button validation), not after full form submit.
- Standardise document-quality acceptance criteria across an organisation's Drupal intake forms.
- Prototype an identity-verification step without building a custom Rekognition integration from scratch.
