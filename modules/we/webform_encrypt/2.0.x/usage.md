<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Encrypt encrypts the submitted values of individual Webform elements at rest, using an Encrypt module encryption profile, so sensitive submission data is stored ciphered in the database and only revealed to users who hold the "view encrypted values" permission.

---

The module bridges the Webform and Encrypt modules. On each webform element's configuration form (Advanced tab) it adds an **Encryption** fieldset with an "Encrypt this field's value" checkbox and an encryption-profile selector; enabling it stores a per-element third-party setting on the webform: `webform.webform.<id>` → `third_party_settings.webform_encrypt.element.<element_key>` = `{encrypt: true, encrypt_profile: <profile_id>}`. It swaps the `webform_submission` entity's storage class for `WebformEncryptSubmissionStorage`, which encrypts flagged element values in `doPreSave()` and decrypts them again in `doPostSave()` and `loadData()`. Encrypted values are serialized as `{data, encrypt_profile}` so the module knows which profile decrypted a given value. It also swaps the access-control handler for `WebformEncryptSubmissionAccessControlHandler`, which forbids the `update` operation on a submission containing encrypted elements unless the user has the `view encrypted values` permission; users lacking that permission see the placeholder `[Value Encrypted]` instead of decrypted data. There is no admin settings page and no configure route — configuration is entirely per element, per webform. On uninstall the module decrypts all stored values back to plaintext so no data is lost.

---

- Encrypt a Social Security / national ID number collected on a webform so it is ciphered at rest in `webform_submission_data`.
- Store credit-card or payment reference fields encrypted while keeping the rest of the submission in plaintext.
- Protect health or medical intake answers to help meet HIPAA-style confidentiality requirements.
- Encrypt personally identifiable information (PII) on contact and registration forms for GDPR compliance.
- Restrict who can read decrypted submission values to a small "view encrypted values" role.
- Keep a phone number or email address element encrypted while a name field stays readable.
- Encrypt free-text elements (textarea) that may contain sensitive disclosures.
- Choose a different encryption profile per element so different keys protect different data classes.
- Prevent site editors without clearance from editing submissions that contain encrypted fields (update is forbidden for them).
- Show `[Value Encrypted]` placeholders to lower-privilege users viewing results tables.
- Encrypt values on multi-step (wizard) webforms where sensitive answers appear on a later page.
- Encrypt composite / nested element values (the module recurses into array children to encrypt each scalar).
- Migrate an existing webform to encrypted storage by ticking the element checkbox (new submissions are then encrypted).
- Safely uninstall the module later, automatically decrypting all stored values back to plaintext.
- Deploy element encryption settings through configuration by exporting the webform's `third_party_settings.webform_encrypt`.
- Combine with the Key and Encrypt modules to hold the actual encryption key outside the database (e.g. env/file provider).
- Reduce the blast radius of a database leak by ensuring sensitive columns are unreadable without the key.
- Encrypt survey answers about salary, ethnicity, or other confidential topics.
- Keep exported/downloaded results safe by gating decryption behind a permission check.
- Apply encryption to a "message" or "notes" element on a support-request form.
- Encrypt applicant data on a job-application webform.
- Selectively encrypt only the elements that need it, leaving performance unaffected for the rest.
- Rotate encryption by switching the element's profile and re-saving submissions.
- Audit which elements on a webform are encrypted by reading `third_party_settings.webform_encrypt.element`.
