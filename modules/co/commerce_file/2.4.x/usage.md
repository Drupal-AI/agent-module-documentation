Commerce File extends Drupal Commerce so you can sell access to downloadable files: buying a product grants a license that lets the customer download the attached file(s), with optional per-file download limits.

---

Commerce File builds on [Commerce License](https://www.drupal.org/project/commerce_license). You add the module's **`commerce_file`** entity trait to a product variation type, which gives variations a required `commerce_file` field (multi-value, private file scheme by default) holding the digital goods. It also registers a **`commerce_file`** license type: when an order containing such a variation is placed, Commerce License creates an active File license for the buyer. Access is enforced in two layers — a `hook_ENTITY_TYPE_access()` for files that forbids downloading/viewing a licensable file without an active, non-expired license, and a dedicated download route (`/commerce-file/{file}/download`) whose custom access checker allows the download only when the current user holds a matching active license. A `LicenseFileManager` service resolves which product variations reference a file and which of a user's licenses are still valid, honoring download limits configured globally (*admin/commerce/config/licenses/file*) or per license/variation. Downloads are recorded by a `DownloadLogger` (a `KernelEvents::TERMINATE` subscriber tags responses via `hook_file_download` headers) so limits can be counted; admins and users with `bypass license control` skip logging and limits. It ships a checkout "Files download" pane, a computed `licensed_files` field on licenses, a download-link field formatter, a "My files" view, and Amazon S3 (Flysystem) redirect support for public buckets.

---

- Sell an e-book, PDF, or software installer as a downloadable Commerce product.
- Grant buyers a license that unlocks file downloads immediately after checkout.
- Attach multiple files to one product variation and license them together.
- Store paid files under the private file scheme so they aren't publicly accessible.
- Enforce a global cap on how many times a user can download each licensed file.
- Override the download limit per product variation or per individual license.
- Reset a customer's download count by re-granting their license.
- Show purchased files to the buyer on the checkout complete page via the download pane.
- Give customers a "My files" page listing everything they're licensed to download.
- Render a themed download link for a licensed file with a field formatter.
- Deny direct file access to anyone without an active license (403).
- Let store admins download any licensed file via the `bypass license control` permission.
- Serve large media (mp4, wav, images, office docs) as paid downloads out of the box.
- Redirect downloads to a public Amazon S3 bucket URL when using Flysystem S3.
- Log each licensed download (user, file, license, IP, time) for auditing and limit counting.
- Automatically enable the license trait when an editor adds the file trait to a variation type.
- Sell time-limited access by combining File licenses with Commerce License expiration.
- Restrict a downloadable resource library to paying members.
- Offer course materials or design assets as licensed downloads.
- Track abuse by reviewing the download log table for excessive downloads.
- Build a digital-goods storefront without writing custom file-access code.
- Expose licensed files programmatically through the computed `licensed_files` license field.
- Gate firmware or driver downloads behind a purchased support license.
- Provide per-variation download policies for tiered products (e.g. standard vs. extended license).
