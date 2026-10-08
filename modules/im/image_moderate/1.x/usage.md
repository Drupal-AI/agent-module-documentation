<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatic Image Moderation screens uploaded images for adult/offensive content via a moderation service.

---

Automatic Image Moderation automatically checks all uploaded images for adult and racist/offensive content, storing moderation results as entities so editors can review and act on flagged uploads. It's aimed at sites with user-generated image uploads that need automated screening.

Screening sends uploaded images to an external moderation API, so images leave the site — store the API credential securely (env-backed) and consider privacy/cost. Permissions cover CRUD on moderation entities (`view/add/edit/delete/administer image moderate entity`). Supports Drupal 8 through 11.

---

- Screen uploaded images automatically.
- Detect adult content.
- Detect racist/offensive content.
- Store moderation results as entities.
- Let editors review flagged uploads.
- Send images to an external API.
- Note images leave the site.
- Store the API credential securely.
- Keep the credential env-backed.
- Consider privacy and cost.
- Gate CRUD with image-moderate-entity permissions.
- Support Drupal 8 through 11.
- Screen user-generated uploads.
- Flag inappropriate images.
- Automate image review.
- Act on moderation results
- Configure the moderation service
- Protect against bad uploads
