C2PA Sign automatically embeds and signs C2PA Content Credentials (provenance manifests) into supported media files when they are uploaded, published, or turned into image-style derivatives.

---

C2PA Sign is a signing integration for the Coalition for Content Provenance and Authenticity (C2PA) "Content Credentials" standard. It wraps the `jrglasgow/c2patool` PHP library, which drives the `c2patool` command-line utility, and uses a site-configured X.509 certificate plus private key to cryptographically sign a manifest that is embedded directly into each media file. The module hooks Drupal's entity lifecycle: file entities are signed on presave (upload), files attached to nodes and other content entities are signed when the entity is first published, and image-style derivatives are signed as they are rendered by a kernel response subscriber. Each manifest records claim-generator information (site/org name, logo, module version, Drupal version), a list of C2PA actions (created, published, resized, cropped, converted, color adjustments, orientation, etc.) derived from what happened to the file, and custom `drupal.c2pa_sign.*` assertions noting who uploaded or published the asset. Manifest assembly is fully alterable through four events, and certificate usage is tracked per public-key fingerprint so admins can audit and monitor certificate expiry. Configuration (certificate directory, c2patool binary path, site identity, and which actions trigger signing) is done at `/admin/config/media/c2pa_sign`.

---

- Prove the authenticity and origin of press or newsroom photography by signing every uploaded image with Content Credentials.
- Attach tamper-evident provenance metadata to media so downstream verifiers (e.g. the Content Authenticity Initiative Verify tool) can inspect it.
- Automatically sign a photo the moment an editor uploads it through a standard file/image field widget.
- Sign media only when the parent content is published, so drafts stay unsigned until they go live.
- Record a `c2pa.published` action and the publishing user/site in the manifest when a node is published.
- Record a `c2pa.creativeWork` / `c2pa.created` action and the uploading user when a new file enters the site.
- Sign image-style derivatives (thumbnails, medium, large) and describe the transformation as C2PA actions (`c2pa.resized`, `c2pa.cropped`, `c2pa.converted`, `c2pa.orientation`, `c2pa.color_adjustments`).
- Preserve the provenance chain by opening (`c2pa.opened`) an already-signed original when generating a derivative and linking it as the parent.
- Choose whether derivatives get a manifest even when the original image has no manifest of its own.
- Embed a site/organization name and logo into the claim generator so consumers see who signed the asset.
- Use a directory of `.pem`/`.key` certificate pairs and automatically select the pair that expires last.
- Supply the signing certificate and key through the `C2PA_SIGN_CERT` and `C2PA_PRIVATE_KEY` environment variables instead of on-disk files.
- Warn administrators on admin page loads (optional) or on the status report when the signing certificate is expired or expiring within a month.
- Surface c2patool availability and version, plus certificate details (issuer, subject, validity, algorithm), on the Drupal status report (`hook_requirements`).
- Track how many times each certificate has been used to sign, keyed by public-key fingerprint, in the `c2pa_sign_certificate_uses` table.
- Extend or modify the manifest for specific entities via the `ManifestCreateEvent` (e.g. add custom assertions, or block embedding for certain content).
- Alter the c2patool `Tool` or `Signer` configuration before signing via the `CreateToolEvent` and `PreSignEvent`.
- Provide custom certificate-validation logic through the `CertificateValidateEvent` when the built-in validation rejects a certificate.
- Support the common newsroom pipeline where uploaded photographs are signed once and re-signed derivatives keep the provenance trail intact.
- Sign a wide range of media types supported by c2patool: JPEG, PNG, WebP, AVIF, TIFF, DNG, HEIC/HEIF, SVG, MP4/MOV/AVI video, and MP3/WAV/M4A audio.
- Add C2PA actions for custom image effects by implementing `c2paAction()` / `c2paMetadata()` methods on the effect plugin.
