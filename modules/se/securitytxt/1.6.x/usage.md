Security.txt serves a standards-compliant `/.well-known/security.txt` file (the security.txt draft RFC / RFC 9116) from a single Drupal settings form, telling security researchers how to report vulnerabilities to your site.

---

The module adds a settings form at **Admin → Configuration → System → Security.txt** (route `securitytxt.configure`, path `/admin/config/system/securitytxt`) where you enter contact details (email, phone, contact-page URL), an expiry date, and optional encryption-key, policy, acknowledgments and hiring URLs, preferred languages, and canonical URLs. All values are stored in one config object, `securitytxt.settings`. A controller then serves the assembled plain-text file at `/.well-known/security.txt`, and — if you enable signing and paste a PGP signature on the **Sign** tab (route `securitytxt.sign`) — a detached signature at `/.well-known/security.txt.sig`. Both paths are gated by the `view securitytxt` permission (grant it to Anonymous + Authenticated), while editing needs `administer securitytxt`. The file is only served when the `enabled` flag is TRUE; when disabled the routes return 404. At least one contact method is required before the file will save as enabled. A `SecuritytxtSerializer` service turns the config into the field lines (`Contact:`, `Expires:`, `Policy:`, `Canonical:`, etc.). There are no plugins, no Drush commands, and no entities — it is a pure config-plus-controller module.

---

- Publish a `/.well-known/security.txt` file so researchers can find your security contact.
- Advertise a `security@example.com` reporting address via a `Contact: mailto:` line.
- Advertise a security hotline with a `Contact: tel:` line in full international format.
- Point to an HTTPS contact/report page with a `Contact:` URL line.
- Comply with the security.txt draft RFC / RFC 9116 for responsible disclosure.
- Set an `Expires:` date so researchers know the file is still current.
- Link your PGP/GPG public key with an `Encryption:` line for encrypted reports.
- Link a written security/disclosure policy page with a `Policy:` line.
- Credit researchers by linking a hall-of-fame page with an `Acknowledgments:` line.
- Advertise security job openings with a `Hiring:` line.
- Declare which languages you accept reports in via `Preferred-Languages:` (e.g. `en, fr`).
- Publish `Canonical:` URLs indicating the authoritative location(s) of the file.
- Digitally sign the file (PGP) and serve the detached signature at `/.well-known/security.txt.sig`.
- Restrict who can view the file by controlling the `view securitytxt` permission per role.
- Restrict who can edit disclosure details with the `administer securitytxt` permission.
- Toggle the whole file on/off from one `enabled` checkbox without deleting your settings.
- Manage all of the above declaratively via the `securitytxt.settings` config object in code.
- Ship a preconfigured security.txt across environments by exporting/importing config.
- Satisfy bug-bounty or pen-test onboarding requirements that expect a security.txt.
- Give automated scanners a machine-readable path to your security contact.
- Provide a consistent disclosure endpoint across a multisite via shared config.
- Warn editors (via form messages) when contact/encryption/canonical URLs are not HTTPS.
