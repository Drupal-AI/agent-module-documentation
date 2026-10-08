<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Thumbor Effects allows using Thumbor's smart imaging effects (smart crop, filters) in Drupal image styles.

---

Thumbor Effects lets Drupal image styles use Thumbor — a smart imaging server — for image processing,
adding effects such as smart cropping (content-aware), filters and transformations that Thumbor
performs. Image derivatives are generated via the Thumbor service rather than (or alongside) Drupal's
own toolkit. It depends on core Image, is configured at `thumbor_effects.settings_form`, and provides its
own permissions.

Use it where Thumbor's smart-imaging (especially face/feature-aware cropping) improves image handling.
The security-relevant point is the Thumbor **security key**: Thumbor URLs are typically HMAC-signed with
a shared secret so only your app can request transformations — store that security key as a secret
(never commit it), so attackers can't forge transformation URLs against your Thumbor server. Configure
the Thumbor server URL and key, and use the effects in image styles.

---

- Use Thumbor effects in image styles.
- Apply smart (content-aware) cropping.
- Process images via Thumbor.
- Add Thumbor filters/transformations.
- Depend on core Image.
- Configure at thumbor_effects.settings_form.
- Provide its own permissions.
- Store the Thumbor security key as a secret.
- Prevent forged transformation URLs.
- Sign Thumbor URLs with HMAC.
- Configure the Thumbor server URL.
- Generate derivatives via Thumbor.
- Use face-aware cropping.
- Improve image handling.
- Never commit the security key.
- Apply effects in image styles.
- Offload image processing.
- Use smart imaging.
- Handle the Thumbor connection.
- Add smart crops.
